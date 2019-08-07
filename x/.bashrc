# If not running interactively, don't do anything
[[ $- != *i* ]] && return

umask 007
export CVS_RSH=ssh
alias vi='vim' # echo -e "set mouse-=a\nset ts=4 sw=4\nsyntax on\n" > ~/.vimrc;
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -la --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=always'
alias g='grep --color=always'
alias df='df -h'
alias du10='find -maxdepth 1 -exec du -hsx "{}" \; | sort -rh | head -11'
alias ping='ping -c 2'
alias ver='
	echo - OS: `cat /etc/os-release 2>/dev/null | sed -rn "s/.*PRETTY_NAME=\"(.+)\".*/\1/p"`; \
	echo - MySQL: `mysql -V 2>/dev/null | sed -rn "s/.*Distrib (.+),.*/\1/p"`; \
	echo - PHP: `php -v 2>/dev/null | sed -rn "s/^PHP ([0-9\.]+)[^0-9\.].*/\1/p"`; \
	echo - Apache: `if type apache2 >/dev/null 2>&1; then apache2 -v 2>/dev/null; else httpd -v 2>/dev/null; fi | sed -rn "s/.*Server version: Apache\/([^ ]+)[ ].*/\1/p"`; \
	echo - Kernel: `uname -a`; \
	echo - Updated: `if [ -f /var/log/pacman.log ]; then tail -n 1 /var/log/pacman.log | cut -d " " -f 1 | sed "s/\[//"; else stat -c %y /var/lib/dpkg/lock | cut -d " " -f 1; fi`; \
	'
alias sr="if screen -list | grep -q 'michalm-screen1'; then if [ $(id -u) = 0 ]; then su -c 'screen -X -S michalm-screen1 quit' michalm; else screen -X -S michalm-screen1 quit; fi; fi; screen -c ~michalm/x/.xscreenrc -S michalm-screen1 -D -RR"
#alias sr="ps -ef | grep michalm | grep "/bin/bash$" | grep -v grep | awk '{print $2}' | xargs kill -9 ; screen -c ~michalm/x/.xscreenrc -S michalm-screen1 -d -RR"
alias sudoi="sudo bash --rcfile ~michalm/x/.bashrc"
alias myip="ip route get 8.8.8.8 | awk '{print \$NF; exit}'"
alias ipp='myip'
alias myip2='echo `w3m -no-cookie -dump ifconfig.co/ip`'
alias ipp2='myip2'
lastfiles () {
	MYNR=$1
	if [ "$MYNR" == "" ]; then
		MYNR=10
	fi
	MYPATH=$2
	if [ "$MYPATH" == "" ]; then
		MYPATH=.
	fi
	echo - !!! Find last $MYNR files in current directory [!www_write !CVS]!!! -
	find $MYPATH -not \( -name 'www_write' -prune -o -name 'CVS' -prune \) -type f -printf "%T@ %Tx %TX %p\n" | sort -nr | head -n $MYNR | cut -d ' ' -f 2-
}
diffproj () {
	diff --brief -Nr $1 $2 | grep -vE '(/www_write/|/CVS/)'
}
copym () {
	\cp -f $1 ~michalm/ ; chmod 700 ~michalm/* ; chown michalm ~michalm/* ;
}
hping () {
	hping3 $1 -p $2 -c 2 -S
}

#export TERM=linux
. /etc/environment
if [ -z "$MY_SERVER" ]
then
	MY_SERVER="$(hostname)"
fi
myPromptSign=$
if [ $(id -u) = 0 ]; then
	myPromptSign=#
fi
export PS1="[$MY_SERVER.\u \w] \n$myPromptSign "
function wtitle {
	export PS1="\[\033]0;$1 - \h.\u:\w\007\]$PS1"
}
wtitle $MY_SERVER

export CVS_RSH=ssh
PATH=$PATH:/usr/sbin/:/sbin/
export PATH
