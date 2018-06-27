setxkbmap us
setxkbmap -option caps:escape
setxkbmap -option compose:menu
setxkbmap -option caps:escape
setxkbmap -option altwin:swap_lalt_lwin

xset r rate 250 30
#xset m 1/1 4

xmodmap -e "keycode 94 = backslash bar"

exec awesome
