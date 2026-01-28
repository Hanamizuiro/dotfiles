hyprctl dispatch
togglespecialworkspace off /dev/null
2>%1
hyprctl dispatch workspace 5

kitty -e cava &
sleep 0.2
kitty -e cmatrix &
sleep 0.2
kitty -e pipes.sh &
sleep 0.2
kitty -e tty-clock &
sleep 1
hyprctl dispatch focuswindow title:TerminalApp