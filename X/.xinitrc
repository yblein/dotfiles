# X stuff
xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad'
xset r rate 250 30
setxkbmap -option caps:escape
setxkbmap -option compose:menu
xrdb .Xresources

# apps
xfce4-power-manager&
urxvtd&

# launch WM
exec awesome
