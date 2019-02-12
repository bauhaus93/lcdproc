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
of lcdproc, the namespace under which all keys are stored is `/sw/lcdproc/<app>/#0/current`
where `<app>` will either be server configuration `lcdd` or the client configurations
 `lcdproc`, `lcdvc` and `lcdexec`. So in the upper example we change the background
 color of the curses driver to green for the server.