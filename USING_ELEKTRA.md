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

Elektra's database is hierarchically structured which means that keys are organized 
similar to directories in a file system. In the case
of lcdproc, the relevant keys are located under `/sw/lcdproc/<app>/#0/current`
where `<app>` will either be server configuration `lcdd` or the client configurations
 `lcdproc`, `lcdvc` and `lcdexec`. LCDproc drivers are installed on the server, 
 so in the upper example we used `lcdd` to change the background 
 color of the curses driver to green.
 
 The new lcdproc comes with a configuration specification such as [LCDd-spec.ini](server/specification/LCDd-spec.ini)
 which is used by Elektra to validate configuration settings.
 This guarantees that certain mistakes cannot occur like setting the background color to *greeen* which could
 potentially crash the application. If you have followed the specification installation process correctly
 from the [INSTALL.md](INSTALL.md), you now have the full specification [mounted](https://www.libelektra.org/tutorials/mount-configuration-files)
 under the `spec` namespace. 
 
 The specification for `.../curses/background` background for example
 tells us that only `red, black, green, yellow, blue, magenta, cyan, white` are valid and that the value given 
 has to be of type string. Elektra will prevent you to set invalid values which will help reduce errors and misconfiguration.
  All these data and much more (eg. default values, descriptions, etc.) are saved as 
 [metadata](https://www.libelektra.org/devdocu/metadata)
 for each and every key under the `spec` namespace.
 
 The following sections will teach you on how to inspect all relevant settings
  and specifications and change desired configuration settings accordingly.
 There best way to change settings is done via `kdb set`
 since it integrates the best with specifications for configurations.
 
### Changing Configurations
 
Using the native command line is the best possibility to find out which configuration settings are available.
If you want to see all available configuration settings for the `server`, you can simply call
```sh
kdb ls '/sw/lcdproc/lcdd/#0/current/server'
#> /sw/lcdproc/lcdd/#0/current/server/autorotate
#> /sw/lcdproc/lcdd/#0/current/server/backlight
#> /sw/lcdproc/lcdd/#0/current/server/bind
#> /sw/lcdproc/lcdd/#0/current/server/driver
...
```
To see all available configuration settings at all you can execute `kdb ls '/sw/lcdproc/lcdd/#0/current'`.
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
#> check/enum/#0
#> check/enum/#1
#> check/enum/#2
#> check/enum/#3
#> check/enum/#4
#> check/enum/#5
#> check/enum/#6
#> check/enum/#7
#> check/type
#> default
#> description
#> type
```
Here we can als see `check/enum/#0-7` which is used by Elektra to assert
for correct configuration settings. You can query for the values by calling
`kdb getmeta`
```sh
kdb getmeta '/sw/lcdproc/lcdd/#0/current/curses/background' 'check/enum/#0'
#> red
```
This `.../#<number>` notation is the typical array notation which is used by Elektra.
If you want to query all metadata and see their values you can use this little script:
```sh
kdb lsmeta '/sw/lcdproc/lcdd/#0/current/curses/background' \
| xargs -I% -n1 sh -c 'printf "% = " && kdb getmeta \
"/sw/lcdproc/lcdd/#0/current/curses/background" "%"'
#> check/enum/#0 = red
#> check/enum/#1 = black
#> check/enum/#2 = green
#> check/enum/#3 = yellow
#> check/enum/#4 = blue
#> check/enum/#5 = magenta
#> check/enum/#6 = cyan
#> check/enum/#7 = white
#> check/type = enum
#> default = cyan
#> description = background color when "backlight" is off
#> type = enum
```
In future versions we might include a command which gives you all metadata 
including their values with a simple command.
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
