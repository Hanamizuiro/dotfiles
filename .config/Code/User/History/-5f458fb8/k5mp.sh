hyprctl dispatch
togglespecialworkspace off /dev/null
2>%1
hyprctl dispatch workspace 5

foot -e cava &
sleep 0.2
foot -e cmatrix &
sleep 0.2
foot -e pipes.sh &
sleep 0.2
foot -e tty-clock &
sleep 1
hyprctl dispatch focuswindow title:TerminalApp