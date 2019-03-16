kdb set -- /sw/lcdproc/lcdexec/#0/current/general/address localhost
kdb set -- /sw/lcdproc/lcdexec/#0/current/general/port 13666
kdb set -- /sw/lcdproc/lcdexec/#0/current/general/reportlevel 2
kdb set -- /sw/lcdproc/lcdexec/#0/current/general/reporttosyslog false
kdb set -- /sw/lcdproc/lcdexec/#0/current/general/foreground false
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/main /sw/lcdproc/lcdexec/#0/current/menu/menu/main
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/menu/main/entry #2
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmda/displayname You can say A
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmda/exec echo a
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmda/feedback yes
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/menu/main/entry/#0 /sw/lcdproc/lcdexec/#0/current/menu/command/cmdp
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdb/displayname Or you can say B
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdb/exec echo b
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/menu/main/entry/#1 /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/menu/menuc/displayname A menu
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/menu/menuc/entry #1
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdp/displayname P
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdp/exec echo P
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/displayname Show environment
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/exec env
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param #5
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param/#0 /sw/lcdproc/lcdexec/#0/current/menu/param/slider/slider_arg
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/slider/slider_arg/displayname Slider
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/slider/slider_arg/type Slider
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/slider/slider_arg/value 5
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/slider/slider_arg/minvalue 0
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/slider/slider_arg/maxvalue 10
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param/#1 /sw/lcdproc/lcdexec/#0/current/menu/param/ring/ring_arg
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ring/ring_arg/displayname Ring
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ring/ring_arg/type Ring
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ring/ring_arg/value 0
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ring/ring_arg/string Eins
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param/#2 /sw/lcdproc/lcdexec/#0/current/menu/param/numeric/numeric_arg
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/numeric/numeric_arg/displayname Numeric
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/numeric/numeric_arg/type Numeric
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/numeric/numeric_arg/value 5
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/numeric/numeric_arg/minvalue 0
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/numeric/numeric_arg/maxvalue 10
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param/#3 /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg/displayname Alpha
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg/type Alpha
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg/allowedchars +-0123456789ABCDEF
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg/value 5
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg/minlength 0
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/alpha/alpha_arg/maxlength 10
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param/#4 /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/displayname Checkbox
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/type Checkbox
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/value on
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/allowgray yes
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/offtext off
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/ontext on
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/checkbox/checkbox_arg/graytext gray
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/command/cmdq/param/#5 /sw/lcdproc/lcdexec/#0/current/menu/param/ip/ip_arg
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ip/ip_arg/displayname IP
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ip/ip_arg/type IP
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ip/ip_arg/value 10.230.2.2
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/param/ip/ip_arg/v6 no
kdb set -- /sw/lcdproc/lcdexec/#0/current/menu/menu/main/entry/#2 /sw/lcdproc/lcdexec/#0/current/menu/menu/menuc