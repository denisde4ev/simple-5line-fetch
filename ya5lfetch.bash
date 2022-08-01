#!/bin/bash
ui=$(tty)
[[ $ui != /dev/tty* ]] &&
if [[ $DE || $WM ]];                                   then ui="${DE:+DE}${DE:+${WM:+/}}${WM:+WM}:      ${DE:+${WM:+$'\e[3D'}}$DE${DE:+${WM:+/}}$WM"
elif [[ $XDG_CURRENT_DESKTOP || $DESKTOP_SESSION ]];   then ui="DE:      ${XDG_CURRENT_DESKTOP:-}${XDG_CURRENT_DESKTOP:+${DESKTOP_SESSION:+, }}${DESKTOP_SESSION:-}"
elif [[ -r ~/.xinitrc || -r ~/.xsession ]];            then
	uiexec=
	for i in $(sed -ne 's/^exec //p' ~/.xinitrc ~/.xsession 2>/dev/null); do
		[[ $(pidof -- "$uiexec") ]] && uiexec+="$(basename -- "$i") "
	done
	[[ ${uiexec% } ]] && ui="WM:      ${uiexec% }"
fi || ui="TTY:     ${ui#/dev/}${SSH_TTY:+, ssh}"

# [[ $os ]] || os=$(sed -ne 's/PRETTY_NAME=//p' "$PREFIX/etc/os-release" || echo "$MACHTYPE"); os=${os#[\'\"]}; os=${os%[\'\"]}
[[ $os ]] || {
	. "$PREFIX/etc/os-release"
	os=${PRETTY_NAME:-${NAME:-$MACHTYPE}}
}

unset w
c=4
case ${os,,} in
arch*)a=\
'     .    
    / \   
   / _ \  
  / / \ \ 
 /`     `\';;
arco*)a=\
'     .    
    / \   
   / . \  
  / / _ \ 
 /`     `\';;


artix*)a=\
"     .    
    / \\   
   /.  \\  
  /   * \\ 
 /   '   \\";c=6;;
artix2)a=\
"     .    
    / \\   
   /'. \\  
  /   .'\\ 
 /   '   \\";c=6;;
artix3)a=\
'
    /\   
   /  \  
  / 🎨 \ 
 /      \';c=6;w=9;;


alpine*)a=(
'
   /\
  /  \' ' /\' '
 /' '◁' '   \' '  \
'
);
c=(4 '' 4 '' 4 '' 4 4 '');w=12;;

android*)a=\
'
 ╲_____╱ 
 ╱ . . ╲ 
▕       ▏
 ▔▔▔▔▔▔▔ ';c=2;w=9;;
kiss*)a=\
'
 +----+
 | |/ |
 | |\ |
 +----+';c=1;w=8;;
manjaro*)a=\
'
 █████ ██
 ██ ▄▄ ██
 ██ ██ ██
 ██ ██ ██';c=2;w=10;;
debian*)a=\
'  ,--. 
 /  _ \
|  (__/
 \     
  `-.  ';c=1;w=9;;


*)a=\
'░░▀▄░░░▄▀░░
░▄█▀███▀█▄░
█▀███████▀█
█░█▀▀▀▀▀█░█
░░░▀▀░▀▀░░░';
 c=${RANDOM:2:1};w=11
;;
# Space Invaders
esac

# printf '\e[3'"$c"'m%s\e[m\n\e[5A' "$a"
for i in "${!c[@]}"; do
	printf "\\e[${c[i]:+3}${c[i]}"'m%s' "${a[i]}"
done
printf '\e[m\n\e[5A'

p='\e[3'"$((EUID==0?1:3))"'m\u\e[m@\h \e[3'"$c"'m\w\e[m'

b='' # detect battery level
for i in /sys/class/power_supply/{battery,{BAT,axp288_fuel_gauge,CMB}*}; do
	[[ -r $i/capacity ]] || continue
	b+="${b:+, }$(< "$i/capacity")% $(< "$i/status")"
done

printf "\\e[${w:-11}C%s\\n" \
	"${p@P}" \
	"OS:      $os" \
	"KERNEL:  $(uname -r)" \
	"${b:+BATTERY: }${b:-SHELL:   $(basename -- ${SHELL:-$0})}" \
	"$ui" \
;
