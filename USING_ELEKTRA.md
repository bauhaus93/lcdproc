# Using Elektra

In the new version of lcdproc, [Elektra](https://www.libelektra.org/home) 
will be used to store and edit configuration settings which are used by lcdproc.

Elektra stores configuration in a global, hierarchical key database. Elektra
comes with a lot of benefits such as [code generation](https://www.libelektra.org/tools/gen) or
[advanced GUIs](https://www.libelektra.org/tools/qt-gui). But one major benefit
 is the possibility to have a 
 [validation on configuration settings](https://www.libelektra.org/tutorials/validate-configuration)
 because of configuration specifications.

This tutorial will teach you how to introspect such a specification and how
to change values accordingly. Be sure to have everything
installed correctly by first reading through [INSTALL.md](INSTALL.md).

## Basic Concept

Elektra stores values in form of a key value pair in a global, 
hierarchical key database. You can easily store values with 
`kdb set <key> <value>` and fetch them via `kdb get <key>`.

Let's take the following example:
```sh
kdb set '/sw/lcdproc/lcdd/#0/current/curses/background' green
kdb get '/sw/lcdproc/lcdd/#0/current/curses/background'
> green
```

Elektra uses the concept of [Namespaces](https://www.libelektra.org/tutorials/namespaces)
which means that keys are organized similar to directories in a file system. In the case
of lcdproc, the relevant keys are located under `/sw/lcdproc/<app>/#0/current`
where `<app>` will either be server configuration `lcdd` or the client configurations
 `lcdproc`, `lcdvc` and `lcdexec`. So in the upper example we change the background
 color of the curses driver to green for the server.
 
 Elektra also comes with specifications for lcdproc such as [LCDd-spec.ini](server/specification/LCDd-spec.ini).
 This guarantees that certain mistakes cannot occur like setting the background color to *greeen* which could
 potentially crash the application. If you have followed the specification installation process correctly
 from the [INSTALL.md](INSTALL.md), you now have the full specification [mounted](https://www.libelektra.org/tutorials/mount-configuration-files)
 under the `spec` namespace. The specification for `/curses/background` background for example
 tells us that only `red, black, green, yellow, blue, magenta, cyan, white` are valid and that the value given 
 has to be of type string. Elektra will prevent you to set invalid values which will help reduce errors and misconfiguration.
  All these data and much more (eg. default values, descriptions, etc.) are saved as 
 [metadata](https://github.com/ElektraInitiative/libelektra/blob/e82b55f0d3ea4c77f3a4c04fa217084021bd8e4b/doc/dev/metadata.md)
 for each and every key under the `spec` namespace.
 
 The following sections will teach you on how to inspect all relevant settings
  and specifications and change desired configuration settings accordingly.
 There are multiple possibilities to do this but our focus will lie on
 
 * `kdb set/get` and
 * `kdb editor`
 
 since they integrate the best with specifications for configurations.
 
### Kdb set
 
Using the native command line is one option to find out which settings are available.
If you want to see all available options for the `server` configuration options for example
you can simply call
```sh
kdb ls '/sw/lcdproc/lcdd/#0/current/server'
#> /sw/lcdproc/lcdd/#0/current/server/autorotate
#> /sw/lcdproc/lcdd/#0/current/server/backlight
#> /sw/lcdproc/lcdd/#0/current/server/bind
#> /sw/lcdproc/lcdd/#0/current/server/driver
...
```
To see all available options at all you can execute `kdb ls '/sw/lcdproc/lcdd/#0/current'`.
To see the current value you can simply call `kdb get` on the respective key.
Now lets take the curses driver for example again and lets see what is the 
current background color is:
```sh
kdb get '/sw/lcdproc/lcdd/#0/current/curses/background'
#> cyan
```
The result comes from the set `default` metadata which is saved for the key. 
You can see all metadata by calling `kdb lsmeta`:
```sh
kdb lsmeta '/sw/lcdproc/lcdd/#0/current/curses/background'
#> check/enum
#> check/type
#> default
#> description
#> type
```
Here we can als see `check/enum` which is used by Elektra to assert
for correct configuration settings. You can query for the values by calling
`kdb getmeta`
```sh
kdb getmeta '/sw/lcdproc/lcdd/#0/current/curses/background' 'check/enum'
#> red, black, green, yellow, blue, magenta, cyan, white
```
If you try to set the value of the background to an invalid value, Elektra
will raise an error and prevent a possible misconfiguration:
```sh
kdb set '/sw/lcdproc/lcdd/#0/current/curses/background' purple
#> Using name user/sw/lcdproc/lcdd/#0/current/curses/background
#> The command kdb set failed while accessing the key database with the info:
#> Sorry, the error (#121) occurred ;(
#> Description: validation failed
#> Reason: Validation of key "user/sw/lcdproc/lcdd/#0/current/curses/background" with string "purple" failed.
#> Ingroup: plugin
#> Module: enum
#> At: <path>/src/plugins/enum/enum.c:218
#> Mountpoint: user/sw/lcdproc/lcdd/#0/current
#> Configfile: <path>/.config/LCDd.conf.17145:1549993505.561040.tmp
```

### Kdb editor
Another sophisticated possibility to see available options and edit them
is to use the `kdb editor`. If you call `kdb editor <key>`, a local editor will
be opened and all keys under the given `<key>` including all metadata will be shown.
Depending on your default storage plugin you have chosen in Elektra the output may differ.
The default storage plugin is the `dump` plugin and the output looks like this:
```sh
kdb editor '/sw/lcdproc/lcdd/#0/current/curses/background'
##Editor
#> kdbOpen 1
#> ksNew 1
#> keyNew 50 1
#> spec/sw/lcdproc/lcdd/#0/current/curses/background^@^@
#> keyMeta 11 54
#> check/enum^@red, black, green, yellow, blue, magenta, cyan, white^@
#> keyMeta 11 5
#> check/type^@enum^@
#> keyMeta 8 5
#> default^@cyan^@
#> keyMeta 12 41
#> description^@background color when "backlight" is off^@
#> keyMeta 5 5
#> type^@enum^@
#> keyEnd
#> ksEnd
```
This is the actual format how the `dump` plugin saves data in a file. You
can see all metadata and its associated meta values. But if you look closely, 
these values are all under the `spec` namespace and changing anything here will not make a difference.
Now lets see what happens when we set the background differently:
```sh
kdb set '/sw/lcdproc/lcdd/#0/current/curses/background' green
#> Using name user/sw/lcdproc/lcdd/#0/current/curses/background
#> Create a new key user/sw/lcdproc/lcdd/#0/current/curses/background with string "green"
```
A new key is created and associated with all metadata from the `spec` namespace:
```sh
kdb editor '/sw/lcdproc/lcdd/#0/current/curses/background'
##Editor
...
spec/sw/lcdproc/lcdd/#0/current/curses/background^@^@
...
user/sw/lcdproc/lcdd/#0/current/curses/background^@green^@
...
```
This truncated output shows both keys under different namespaces.
Now if you want to change the value of the background, you can simply 
replace the text *green* in the `user` namespace and once you save the file,
all changes will apply. If any changed value is invalid, the output after closing
the editor will tell you.

The main advantage of the editor is to see all available metadata with one command.
Also over multiple keys by simply calling `kdb editor` on a parent key, 
eg. `kdb editor '/sw/lcdproc/lcdd/#0/current/curses`. When it comes to setting values
other than the default value, `kdb set` is needed though.
