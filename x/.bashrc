#!/usr/bin/env bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
_USER=michalm

function is_cmd() {
	PROG=$1
	tmp=`which $PROG 2> /dev/null`
	if [ "$tmp" = "" ]; then
		return 1
	else
		return 0
	fi
}

function check_sudo() {
	_SUDO=sudo
	if ! is_cmd $_SUDO; then
		_SUDO=''
	fi
}
check_sudo

umask 007
export CVS_RSH=ssh
alias vi='nvim' # echo -e "set mouse-=a\nset ts=4 sw=4\nsyntax on\n" > ~/.vimrc;
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=never'
alias l='ls -la --color=auto'
# alias lg -> func
alias rg='/usr/bin/rg --hidden'
alias rgl='/usr/bin/rg --hidden --follow'
alias rgf='/usr/bin/rg --hidden --files | rg'
alias ag="/usr/bin/ag --silent --hidden --ignore={'PlayOnLinux*','.wine'}"
alias agl="/usr/bin/ag --follow --silent --hidden --ignore={'PlayOnLinux*','.wine'}"
alias grep='grep --color=never'
alias egrep='grep -E --color=never'
alias fgrep='grep -F --color=never'
alias fd='fd --hidden --exclude .git'
alias g='grep --color=auto'
alias eg='grep -E --color=auto'
alias fg='grep -F --color=auto'
alias du10='find -maxdepth 1 -exec du -hsx "{}" \; | sort -rh | head -11'
alias du100='find -maxdepth 1 -exec du -hsx "{}" \; | sort -rh | head -101'
alias file_list='_file_list'
alias file_du='_file_du'
alias file_del='_file_del'
alias ping='ping -c 2'
alias mc='mc -a'
alias sshp='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias shp='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias sh='ssh'
alias sshm='ssh -F /home/michalm/.ssh/config'
alias scpm='scp -F /home/michalm/.ssh/config'
alias sh_kim5='sshfs kim5:/ /home/sh_kim5/ -C -o reconnect'
alias sh_kim5_down='fusermount3 -uz /home/sh_kim5/'
# alias fzf="fzf -m --preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind ctrl-a:select-all,ctrl-d:deselect-all,f2:toggle-preview"
alias ver='
	echo - OS: `cat /etc/os-release 2>/dev/null | sed -rn "s/.*PRETTY_NAME=\"(.+)\".*/\1/p"` `if cat /proc/1/cgroup | grep -q --color=never -P "0::.+containerd"; then echo "(DOCKER CONTAINER)"; else echo ""; fi`; \
	echo - MySQL: `mysql -V 2>/dev/null | sed -rn "s/.*Distrib (.+),.*/\1/p"`; \
	echo - PHP: `php -v 2>/dev/null | sed -rn "s/^PHP ([0-9\.]+)[^0-9\.].*/\1/p"`; \
	echo - Apache: `if type apache2 >/dev/null 2>&1; then apache2 -v 2>/dev/null; else httpd -v 2>/dev/null; fi | sed -rn "s/.*Server version: Apache\/([^ ]+)[ ].*/\1/p"`; \
	echo - Kernel: `uname -a`; \
	echo - Ker.RUN: `uname -r`; \
	echo - Ker.INS: `if [ -f /var/log/pacman.log ] && [ -d /lib/modules/ ]; then ls -A1 /lib/modules/ | grep --color=never -P "^$(uname -r | sed -rn "s/^([^\.]+?\.[^\.]+?).*/\1/p")" | tail -n 1; else echo "not-found"; fi`; \
	'

## Screen:
_IS_SCREEN_FOUND=0
if [ $(id -u) = 0 ]; then
	if [ -f /home/michalm/.screenrc_r ]; then
		_IS_SCREEN_FOUND=1
		alias rrs='screen -X -S michalm_screen_root quit ; cd /root/ ; screen -c /home/michalm/.screenrc_r -S michalm_screen_root -d -RR'
	elif [ -f /root/michalm/.screenrc ]; then
		_IS_SCREEN_FOUND=1
		alias rrs='screen -X -S michalm_screen_root quit ; cd /root/ ; screen -c /root/michalm/.screenrc -S michalm_screen_root -d -RR'
	elif [ -f /home/michalm/.screenrc ]; then
		_IS_SCREEN_FOUND=1
		alias rrs='screen -X -S michalm_screen_root quit ; cd /root/ ; screen -c /home/michalm/.screenrc -S michalm_screen_root -d -RR'
	elif [ -f /home/michalm/xx/.xscreenrc ]; then
		_IS_SCREEN_FOUND=1
		alias rrs='screen -X -S michalm_screen_root quit ; cd /root/ ; screen -c /home/michalm/xx/.xscreenrc -S michalm_screen_root -d -RR'
	fi
elif [ "`whoami`" == "michalm" ]; then
	if [ -f /home/michalm/.screenrc ]; then
		_IS_SCREEN_FOUND=1
		alias rrs='screen -X -S michalm_screen quit ; cd /root/ ; screen -c /home/michalm/.screenrc -S michalm_screen -d -RR'
	elif [ -f /home/michalm/xx/.xscreenrc ]; then
		_IS_SCREEN_FOUND=1
		alias rrs='screen -X -S michalm_screen quit ; cd /root/ ; screen -c /home/michalm/xx/.xscreenrc -S michalm_screen -d -RR'
	fi
fi
# alias rrs="if screen -list | grep -q 'michalm_screen'; then if [ $(id -u) = 0 ]; then su -c 'screen -X -S michalm_screen_root quit' michalm; else screen -X -S michalm_screen quit; fi; fi; screen -c /home/michalm/xx/.xscreenrc -S michalm_screen -D -RR"
if [ "$_IS_SCREEN_FOUND" == "0" ]; then
	alias rrs='echo ::ERROR: screen config not found.'
fi

alias sudo='sudo '
alias sudoi='sudo -E bash --rcfile ~michalm/x/.bashrc'
alias sudoers_all='sudo echo "michalm ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/local'
alias myip='echo `curl -s http://whatismyip.akamai.com`'
alias ipp='myip'
alias myip2="ip route get 8.8.8.8 | sed -rn 's/.*src ([0-9\.]+)[ |].*/\1/p'"
alias ipp2='myip2'
alias luarocks='sudo luarocks --lua-version 5.1'
alias luarocks53='sudo luarocks --lua-version 5.3'
alias luaperm='sudo chmod -R a+rx /usr/share/lua/ /usr/lib/lua/'
alias pik='pikaur'
alias pikrem='pikaur -Rcs'
alias upd='pik -Syu'
alias updr='pik -Syuo'
alias upda='pik -Syua'
alias updker='pik -S $(pik -Qsq ^linux | grep -E --color=never ^linux)'
alias sys='inxi -Fxxxz'
alias por='nc -vz'
alias port='nc -vz'
alias ports='netstat -tulpn'

## DOCKER:
_DOCKER_PS_FORMAT='table {{.Names}}\t{{.Status}}\t{{.Ports}}'
# _DOCKER_PS_FORMAT='table'
export COMPOSE_IGNORE_ORPHANS=true
_DOCKER_COMPOSE_MODES='["prod", "test", "dev"]'
_DOCKER_COMPOSE_FILE="docker-compose.yml"
_DOCKER_COMPOSE_TMP_FILE="tmp.docker-compose.scmignore.yml"
alias doc='docker'
alias docc='docker compose'
alias dok='_dok'
alias doka='dok a'
alias dokex='dok ex'

alias doklogin='_dokl' # Login
alias dokl='_dokl' # Login
function _dokl { command docker exec -it $@ bash ; }
alias dokclean='_dokclean'
function _dokclean {
	echo ::Remove dangling images and volumes
	command docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
	command docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
}

alias dokbuild='_docker_compose build'
alias dokbuildforce='_docker_compose build --no-cache'
alias dokbuildf='_docker_compose build --no-cache'

alias dokrebuild='_docker_compose up --build -d'
alias dokreb='_docker_compose up --build -d'
alias dokrebuildforce='_dokrebf'
alias dokrebf='_dokrebf'
function _dokrebf {
	_docker_compose build --no-cache $@
	_docker_compose up -d $@
}

alias dokstart='_docker_compose start'
alias dokstop='_docker_compose stop'
alias dokrestart='_docker_compose restart'
alias dokres='_docker_compose restart'

alias dokup='_docker_compose up -d'
alias dokdown='_docker_compose down'

alias doki='docker images | sort -k1 -h'

function _docker_compose()
{
	LAST_ARG=${@: $#}
	PAR1=$(_dok_checked_last_arg $@)
	if [ "$PAR1" == "null" ]; then
		EXCEPT_LAST_ARGS=$@
	elif [[ "$_DOCKER_COMPOSE_MODES" =~ "\"$LAST_ARG\"" ]]; then
		EXCEPT_LAST_ARGS=${@: 1:$#-1}
	else
		EXCEPT_LAST_ARGS=$@
	fi
	_dok_show_last_arg_err $PAR1
	echo ::[$PAR1]
	if [[ "$_DOCKER_COMPOSE_MODES" =~ "\"$PAR1\"" ]]; then
		_ADD_CMD_ARGS=
		if [[ "$PAR1" != "prod" ]]; then
			_ADD_CMD_ARGS+=' -f '${_DOCKER_COMPOSE_TMP_FILE}
			_DOCKER_COMPOSE_MODE_FILE=${PAR1}.scmignore.${_DOCKER_COMPOSE_FILE}
			if [ -f $_DOCKER_COMPOSE_MODE_FILE ]; then
				_ADD_CMD_ARGS+=' -f '$_DOCKER_COMPOSE_MODE_FILE
			else
				_DOCKER_COMPOSE_MODE_FILE=${PAR1}.${_DOCKER_COMPOSE_FILE}
				if [ -f $_DOCKER_COMPOSE_MODE_FILE ]; then
					_ADD_CMD_ARGS+=' -f '$_DOCKER_COMPOSE_MODE_FILE
				fi
			fi
			_dok_tmp_compose_file_create $PAR1
		fi
		docker compose${_ADD_CMD_ARGS} $EXCEPT_LAST_ARGS
		if [[ "$PAR1" != "prod" ]]; then
			_dok_tmp_compose_file_delete $PAR1
		fi
	fi
}
function _dok_checked_last_arg()
{
	LAST_ARG=${@: $#}
	if [[ ! -f $_DOCKER_COMPOSE_FILE ]]; then
		RET=null
	elif [[ "$_DOCKER_COMPOSE_MODES" =~ "\"$LAST_ARG\"" ]]; then
		RET=$LAST_ARG
	else
		if [ "`hostname`" == "box" ]; then
			RET=dev
		else
			RET=prod
		fi
	fi
	echo $RET
}
function _dok_show_last_arg_err()
{
	if [[ ! -f $_DOCKER_COMPOSE_FILE ]]; then
		echo !!! ERROR: NO $_DOCKER_COMPOSE_FILE FILE IN CURRENT DIRECTORY. !!!
	fi
	PAR1=$1
	if ! [[ "$_DOCKER_COMPOSE_MODES" =~ "\"$PAR1\"" || "$PAR1" == "null" ]]; then
		echo !!! ERROR: $PAR1 IS NOT SUPPORTED ACTION. !!!
	fi
}
function _dok_tmp_compose_file_create()
{
	PAR1=$1
	command cp -pf ${_DOCKER_COMPOSE_FILE} ${_DOCKER_COMPOSE_TMP_FILE}
	if [[ "$PAR1" == "test" ]]; then
		sed -i "s|: #srv|_$PAR1: #srv|g" ${_DOCKER_COMPOSE_TMP_FILE}
		sed -i 's|{PROD_|{TEST_|g' ${_DOCKER_COMPOSE_TMP_FILE}
	elif [ "$PAR1" == "dev" ]; then
		sed -i "s|: #srv|_$PAR1: #srv|g" ${_DOCKER_COMPOSE_TMP_FILE}
		sed -i 's|{PROD_|{_DEV_|g' ${_DOCKER_COMPOSE_TMP_FILE}
	fi
}
function _dok_tmp_compose_file_delete()
{
	rm -f ${_DOCKER_COMPOSE_TMP_FILE}

}

##

alias log='_log'
alias rrb='_rrb' ; function _rrb { source /home/$_USER/.bashrc ; }
alias diffdirs='diff -rq $1 $2'
alias diffdirs2='diff -r $1 $2'

# DESKTOP:
alias rra='awesome-client "awesome.restart()"'
alias backup='/home/backup/backup.sh'
alias backup-dry-run='/home/backup/backup-dry-run.sh'
alias fan='systemctl status thinkfan ; sensors | grep --color=never Core'
alias bton='sudo systemctl start bluetooth && bluetoothctl power on && bluetoothctl connect FC:A8:9A:94:AC:44'
alias btof='sudo systemctl stop bluetooth && sleep 2 && awesome-client "awesome.restart()"'
alias btonPrev01='sudo systemctl start bluetooth && sleep 1 && n=10; for ((i=1;i<=$n;i++)); do if $(bluetoothctl connect FC:A8:9A:94:AC:44 | grep -q "Connection successful"); then echo "OK"; break; else echo "wait ($i/$n)"; sleep 1; fi; done;'
alias btofPrev01='sudo systemctl stop bluetooth'
alias tunkim1='ssh -nN -R 0.0.0.0:41443:172.20.0.1:443 -R 0.0.0.0:41080:172.20.0.1:80 kim1'
alias tunkim1b='ssh -nN -R 0.0.0.0:41443:172.30.0.1:443 -R 0.0.0.0:41080:172.30.0.1:80 kim1'
alias color='grabc ; xdotool getmouselocation --shell'
alias xkb='~/x/xkb/xkbcomp_my.sh errors'
alias view='feh'
alias o='xdg-open'
alias aw='awmtt start -B /usr/local/bin/awesomegit -C ~/x/awesomeN_rc.lua -S 1300x720'
alias awr='awmtt stop && aw'
alias code='vscodium'
alias co='vscodium'
alias pdfr='docker exec pdf bash /opt/recode_pdf/run_recode_pdf.sh'
alias hdeno='deno run --allow-net --unstable --watch /home/michalm/projects/p_other_test/deno/src/main.ts'
GTK_THEME='Adwaita'

alias cdf=_cdf
function _cdf {
	LAST=${@: $#}
	if [[ -f $LAST ]]; then
		FILEDIR=$(dirname "$LAST")
	else
		FILEDIR=$LAST
	fi
	OTHER=${*%${!#}}
	if [[ -d $FILEDIR ]]; then
		command cd $OTHER "$FILEDIR"
	else
		command cd $@
	fi
}

alias df=_df
function _df {
 	command df -h $@ | sed -rn "s#^([/|F].*)#\1#p" | sed -e $'s/ *[^ ]* /\033[1;33m&\033[0m/4'
}

alias lg=_lg
function _lg {
	l | grep -E "[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+?$@" \
		| grep -E --color $@
}

function f() {
	if is_cmd fd; then
		f2 $1
	else
		f1 $1
	fi
}
function fc() {
	if is_cmd fd; then
		f2c $1
	else
		f1c $1
	fi
}
function f1() {
	if is_cmd rg; then
		$_SUDO find . -regextype posix-extended -iregex ".*$1.*" 2> /dev/null | rg -i $1
	else
		$_SUDO find . -regextype posix-extended -iregex ".*$1.*" 2> /dev/null
	fi
}

function f1c() {
	if is_cmd rg; then
		$_SUDO find . -regextype posix-extended -regex ".*$1.*" 2> /dev/null | rg -i $1
	else
		$_SUDO find . -regextype posix-extended -regex ".*$1.*" 2> /dev/null
	fi
}
function f2() {
	$_SUDO fd --hidden --exclude .git --exclude /timeshift $1
}
function f2c() {
	$_SUDO fd --case-sensitive --hidden --exclude .git --exclude /timeshift $1
}
function fl() {
	$_SUDO fd --hidden --follow --max-depth 50 --exclude .git --exclude /timeshift $1
}

function s() {
	if is_cmd rg; then
		/usr/bin/rg -i --hidden --follow $1
	else
		grep -E -Ri "$1" .
	fi
}
function sc() {
	if is_cmd rg; then
		/usr/bin/rg --hidden --follow $1
	else
		grep -E -R "$1" .
	fi
}

function _log() {
	PARS=$@
	if [ -z "$PARS" ]; then
		journalctl -r | less
	else
		cmd="journalctl -r | grep -E '$PARS' | less"
		eval $cmd
	fi
}

function _file_list() {
	PARS=$@
	if [ ! -z "$PARS" ]; then
		echo "Finding recursively files to list..."
		find ./ -type f -name "*$PARS*"
		TMP="find ./ -type f -name \"*$PARS*\" -delete"
		echo "COMMAND TO DELETE ABOVE FILES:"
		echo $TMP
	else
		echo "Empty parameter to delete files."
	fi
}

function _file_du() {
	PARS=$@
	if [ ! -z "$PARS" ]; then
		echo "Finding recursively files to count size..."
		find ./ -type f -name "*$PARS*" -exec du -ch {} + | grep total
	else
		echo "Empty parameter to find files."
	fi
}

function _file_del() {
	PARS=$@
	if [ ! -z "$PARS" ]; then
		# echo "Deleting recursively files..."
		# find ./ -type f -name "*$PARS*" -delete
		echo "DONE"
	else
		echo "Empty parameter to delete files."
	fi
}

alias isreboot="_isreboot"
function _get_boot_kernel() {
	local get_version=0
	for field in $(file /boot/vmlinuz*); do
		if [[ $get_version -eq 1 ]]; then
			echo $field
			return
		elif [[ $field == version ]]; then
			# the next field contains the version
			get_version=1
		fi
	done
}
function _isreboot() {
	rc=1

	libs=$(lsof -n +c 0 2> /dev/null | grep 'DEL.*lib' | awk '1 { print $1 ": " $NF }' | sort -u)
	if [[ -n $libs ]]; then
		cat <<< $libs
		echo "# LIBS: reboot required"
		rc=0
	fi

	active_kernel=$(uname -r)
	current_kernel=$(_get_boot_kernel)
	if [[ $active_kernel != $current_kernel ]]; then
		echo "$active_kernel < $current_kernel"
		echo "# KERNEL: reboot required"
		rc=0
	fi
}

function _get_rand_str()
{
	CNT=$1
	if [ "$PAR1" == "" ]; then
		CNT=20
	fi
	RAND=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c${1:-$CNT}`
	echo $RAND
}

function replace() {
	var1=$1
	var2=$2
	if [[ -z $var1 || -z $var2 ]]; then
		echo "Usage: replace par1 par2"
		echo "Info: replaces par1 string with par2 string recursively in current directory (case-sensitive)."
		echo "Error: required two parameters"
	else
		echo 'Are you sure to replace recursively below directory'
		echo `pwd -P`
		read -p "[y/n]? " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo 'EXECUTING...'
			grep -Rl "$var1" . | xargs sed -i "s|$var1|$var2|g"
			echo 'DONE'
		else
			echo 'CANCELED'
		fi
	fi
}

function myphp() {
	PAR1=$1
	if [ "$PAR1" == "" ]; then
		PAR1=status
	fi
	if [ "$PAR1" == "status" ]; then
		docker container ls -a | grep 'myphp' ;
	elif [ "$PAR1" == "start" ]; then
		docker start myphp ;
		docker container ls -a | grep 'myphp' ;
	elif [ "$PAR1" == "stop" ]; then
		docker stop myphp ;
		docker container ls -a | grep 'myphp' ;
	elif [ "$PAR1" == "restart" ]; then
		docker restart myphp ;
		docker container ls -a | grep 'myphp' ;
	elif [ "$PAR1" == "login" ]; then
		docker exec -it myphp bash
	elif [ "$PAR1" == "logs" ]; then
		docker logs --since 2h --follow myphp
	elif [ "$PAR1" == "save" ]; then
		docker save -o /home/michalm/t/myphp.tar myphpimage ; gzip /home/michalm/t/myphp.tar ; chown michalm /home/michalm/t/myphp.tar.gz ;
	elif [ "$PAR1" == "download" ]; then
		scp kim5:/home/michalm/t/myphp.tar.gz /home/michalm/t/myphp.tar.gz
	elif [ "$PAR1" == "load" ]; then
		gunzip /home/michalm/t/myphp.tar.gz ; docker load -i /home/michalm/t/myphp.tar ;
	fi
}
function _dok() {
	CLIENT=$1
	ACTION=$2
	ACTPAR1=$3
	if [ -z "$ACTPAR1" ]; then
		if [ "$CLIENT" != "app" ] && [ ${#CLIENT} == 6 ]; then
			ACTPAR1=${CLIENT:3}
			CLIENT=${CLIENT:0:3}
		fi
	fi
	APPNAME=$CLIENT$ACTPAR1
	if [ "$ACTION" == "" ]; then
		ACTION=status
	fi
	p_company=/home/company
	p_root=$p_company/$CLIENT

	if [ "$CLIENT" == "" ] || [ "$CLIENT" == "list" ]; then
		:
	elif [ "$CLIENT" == "a" ]; then
		:
	elif [ "$CLIENT" == "clean" ]; then
		:
	else
		echo ::[COMPANY: $CLIENT], [APPNAME: $APPNAME], [ACTION: $ACTION]\
			, [COMPANY ROOT: \/share \-\> $p_root]
	fi
	if [ "$CLIENT" == "" ] || [ "$CLIENT" == "list" ]; then
		echo ::[ACTION: $ACTION \(active\)]
		docker ps --format "$_DOCKER_PS_FORMAT"
	elif [ "$CLIENT" == "a" ]; then
		echo ::[ACTION: $ACTION \(all\)]
		docker ps --format "$_DOCKER_PS_FORMAT" -a
	elif [ "$CLIENT" == "ex" ]; then
		echo ::[ACTION: $ACTION \(exited\)]
		docker ps --format "$_DOCKER_PS_FORMAT" -f "status=exited"
	elif [ "$CLIENT" == "clean" ]; then
		echo ::[ACTION: $ACTION \(clean\)]
		echo ::Remove dangling images and volumes
		docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
		docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
	elif [ "$ACTION" == "status" ]; then
		docker ps --format "$_DOCKER_PS_FORMAT" -a -f "NAME=^${APPNAME}$"
	elif [ "$ACTION" == "build" ] || [ "$ACTION" == "recreate" ]; then
		echo ::Remove dangling images and volumes
		docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
		docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
		if [ "$ACTION" == "recreate" ]; then
			echo ::Stop container $APPNAME
			docker stop $APPNAME ;
			echo ::Remove container $APPNAME
			docker rm --force $APPNAME ;
		fi
		docker rmi $APPNAME ;
#		docker rmi --force $APPNAME ;
		mkdir -p /tmp/docker_company_$APPNAME/ ;
		\cp -f /home/company/$CLIENT/etc/docker/$APPNAME/Dockerfile /tmp/docker_company_$APPNAME/Dockerfile ;
		time docker build -t $APPNAME":latest" /tmp/docker_company_$APPNAME/ ;
	elif [ "$ACTION" == "reload" ] || [ "$ACTION" == "recreate" ]; then
		if [ "$ACTION" == "reload" ]; then
			echo ::Stop container $APPNAME
			docker stop $APPNAME ;
		fi
		if [ "$ACTION" == "reload" ]; then
			echo ::Save container $APPNAME as new image $APPNAME
			docker commit $APPNAME $APPNAME ;
		fi
		echo ::Remove dangling images and volumes
		docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
		docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
		echo ::Remove container $APPNAME
		docker rm --force $APPNAME ;
		echo ::Create and run container $APPNAME
		if [ "`hostname`" == "box" ]; then
			options_dev="\
				-v $p_root/_secure:/share/_secure \
				-v /home/michalm/projects:/var/www/html \
				-v /home/michalm/projects:/var/www/htmlssl \
				-v /home/michalm/projects:/var/www/html/projects \
				-v /home/michalm:/share/dev \
				-v $p_root/etc/apache2/_ports.localhost.conf:/etc/apache2/ports.conf \
 				-v $p_root/etc/apache2/_hostname.localhost.conf:/etc/apache2/conf-enabled/_hostname.localhost.conf \
			"
		else
			options_dev=""
		fi
		docker run --name $APPNAME --restart unless-stopped -it -d \
			--net=host \
			--hostname=$APPNAME".localhost" \
			$options_dev \
			-v $p_root:/share \
			-v $p_company:$p_company \
			-v $p_root/wwwroot:/var/www \
			-v $p_root/etc/apache2:/etc/apache2 \
			-v $p_root/etc/php:/usr/local/etc/phpDDD \
			-v $p_root/etc/couchdb:/etc/couchdb \
			-v $p_root/etc/s-nail.rc:/etc/s-nail.rc \
 			-v $p_root/etc/crontab.txt:/etc/cron.d/crontab.txt \
			$APPNAME ;
		echo ::Show images
		docker images ;
		echo ::Show containers
		docker ps --format "$_DOCKER_PS_FORMAT" ;
	elif [ "$ACTION" == "start" ]; then
		docker start $APPNAME ;
		docker container ls -a | grep $APPNAME ;
	elif [ "$ACTION" == "stop" ]; then
		docker stop $APPNAME ;
		docker container ls -a | grep $APPNAME;
	elif [ "$ACTION" == "restart" ]; then
		docker restart $APPNAME ;
		docker container ls -a | grep $APPNAME;
	elif [ "$ACTION" == "login" ]; then
		docker exec -it $APPNAME bash
	elif [ "$ACTION" == "log" ] || [ "$ACTION" == "logs" ]; then
		docker logs --since 2h --follow $APPNAME
	elif [ "$ACTION" == "logclear" ] || [ "$ACTION" == "clearlog" ]; then
		echo ::Clearing log file:
		echo `docker container inspect  --format='{{.LogPath}}' $APPNAME`
		$_SUDO truncate -s 0 `docker container inspect  --format='{{.LogPath}}' $APPNAME`
		echo DONE
	elif [ "$ACTION" == "logsave" ]; then
		docker logs $APPNAME >& ${APPNAME}_`date +%Y%m%d_%H%M%S`.log
	elif [ "$ACTION" == "clean" ]; then
		echo ::Remove dangling images and volumes
		docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
		docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
	elif [ "$ACTION" == "save" ]; then
		docker stop $APPNAME ; \
			docker commit $APPNAME $APPNAME ; \
			docker save -o /tmp/$APPNAME.tar $APPNAME ; \
			gzip /tmp/$APPNAME.tar ; \
			chown michalm /tmp/$APPNAME.tar.gz ; \
			docker start $APPNAME ;
	elif [ "$ACTION" == "download" ]; then
		scp kim5:/tmp/$APPNAME.tar.gz /tmp/$APPNAME.tar.gz
	elif [ "$ACTION" == "load" ]; then
		gunzip /tmp/$APPNAME.tar.gz ; docker load -i /tmp/$APPNAME.tar ;
	elif [ "$ACTION" == "logindb" ]; then
		mysql -h 172.20.0.1 -P 3267 --protocol=TCP -u root -p
	fi
}
function mydbd() {
	ACTION=$1
	CLIENT=mydb
	if [ "$ACTION" == "" ]; then
		PAR1=status
	fi
	p_company=/home/company
	p_root=$p_company/$CLIENT
	echo ::[COMPANY ROOT \/share \-\> $p_root][mydbd]
	if [ "$ACTION" == "status" ]; then
		docker container ls -a | grep 'mydb' ;
	elif [ "$ACTION" == "init" ]; then
		vTS=$(date +%s)
# 		#Install packages:
#		$_SUDO pacman -S docker mariadb-clients
# 		#Enable/start docker:
# 		$_SUDO systemctl enable docker ; $_SUDO systemctl start docker ; $_SUDO systemctl status docker
# 		#Make use docker as normal user:
# 		$_SUDO groupadd docker ; $_SUDO usermod -aG docker $USER ; newgrp docker ; docker run hello-world ;
 		echo ::Pull image mariadb
 		docker pull mariadb/server:10.1 ;
 		docker images ;
		echo ::Stop container mydb
		docker stop mydb ;
		echo ::Backup container mydb as image mydb_ts"$vTS"c
		docker commit mydb mydb_ts"$vTS"c ;
		echo ::Backup image mydb as image mydb_ts"$vTS"i
		docker tag mydb mydb_ts"$vTS"i
		echo ::Remove container mydb
		docker rm --force mydb ;
		echo ::Remove image mydb
		docker image rm mydb
 		echo ::Copy new pulled image as mydb
 		docker tag mariadb/server:10.1 mydb
 		docker images ;
	elif [ "$ACTION" == "reload" ]; then
		echo ::Stop container mydb
		docker stop mydb ;
		echo ::Save container mydb as new image mydb
		docker commit mydb mydb ;
		echo ::Remove dangling images and volumes
		docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
		docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
		echo ::Remove container mydb
		docker rm --force mydb ;
		echo ::Create and run container mydb
		docker run --name mydb --restart unless-stopped -it -d \
			--net=host \
			--hostname=_MYDB_ \
			-v $p_root:/share \
			-v $p_company:$p_company \
			-v $p_root/mysql:/var/lib/mysql \
			-e MYSQL_ROOT_PASSWORD=hi \
			-d mydb ;
		echo ::Show images
		docker images ;
		echo ::Show containers
		docker ps --format "$_DOCKER_PS_FORMAT" ;
	elif [ "$ACTION" == "start" ]; then
		docker start mydb ;
		docker container ls -a | grep 'mydb' ;
	elif [ "$ACTION" == "stop" ]; then
		docker stop mydb ;
		docker container ls -a | grep 'mydb' ;
	elif [ "$ACTION" == "restart" ]; then
		docker restart mydb ;
		docker container ls -a | grep 'mydb' ;
	elif [ "$ACTION" == "login" ]; then
		docker exec -it -w /var/lib/mysql/ mydb bash
	elif [ "$ACTION" == "con" ]; then
		mysql -h 127.0.0.1 -P 3267 --protocol=TCP -u root -p
	elif [ "$ACTION" == "logs" ]; then
		docker logs --since 2h --follow mydb
	fi
#		apt-update
#		apt-get install vim
#		vi /etc/mysql/my.cnf
# 		mysql -h 127.0.0.1 -P 3306 --protocol=TCP -u root -p
# 		mysql -h 127.0.0.1 -P 3267 --protocol=TCP -u root -p
}
function mydbc() {
	ACTION=$1
	if [ "$ACTION" == "" ]; then
		PAR1=status
	fi
	if [ "$ACTION" == "status" ]; then
		systemctl status mydb | grep 'Active:' ;
	elif [ "$ACTION" == "start" ]; then
		systemctl start mydb ;
		systemctl status mydb | grep 'Active:' ;
	elif [ "$ACTION" == "stop" ]; then
		systemctl stop mydb ;
		systemctl status mydb | grep 'Active:' ;
	elif [ "$ACTION" == "restart" ]; then
		systemctl restart mydb ;
		systemctl status mydb | grep 'Active:' ;
	elif [ "$ACTION" == "login" ]; then
		cd /var/lib/mysql_sandboxes/msb_10_1_40/data/
	elif [ "$ACTION" == "save" ]; then
		/root/scripts/dbAll_here_backup_script.sh ; \
			mv /root/scripts/scr_crm_prod.last.zip /home/michalm/t/scr_crm_prod.last.zip ; \
			chown michalm /home/michalm/t/scr_crm_prod.last.zip ;
	elif [ "$ACTION" == "download" ]; then
			scp kim5:/home/michalm/t/scr_crm_prod.last.zip /home/michalm/t/scr_crm_prod.last.zip
	elif [ "$ACTION" == "load" ]; then
		/root/scripts/import_scr1_from_prod_to_dev1test2.sh /home/michalm/t/ ;
# 		gzip /home/michalm/t/scr_crm_prod.sql > /home/michalm/t/mydb.gz ;
# 		chown michalm /home/michalm/t/mydb.gz ;
# 		docker load -l c:/myfile.tar
# 	 		'bunzip2 | docker load'
	elif [ "$ACTION" == "logs" ]; then
		less +G /var/lib/mysql_sandboxes/msb_10_1_40/data/msandbox.err
	fi
}
function mydb() {
	if $(systemctl is-active --quiet mydb); then
		echo [mydbc]
 		mydbc $1 $2
	else
		echo [mydbd]
		mydbd $1 $2
	fi
}
function lin() {
	PAR1=$1
	if [ "$PAR1" == "" ]; then
		PAR1=status
	fi
	echo ::[ARCHLINUX lin]
	if [ "$PAR1" == "status" ]; then
		docker container ls -a | grep 'lin' ;
	elif [ "$PAR1" == "init" ]; then
		vTS=$(date +%s)
 		echo ::Pull image archlinux:base-devel
 		docker pull archlinux:base-devel ;
 		docker images ;
		echo ::Stop container lin
		docker stop lin ;
		echo ::Backup container lin as image lin_ts"$vTS"c
		docker commit lin lin_ts"$vTS"c ;
		echo ::Backup image lin as image lin_ts"$vTS"i
		docker tag lin lin_ts"$vTS"i
		echo ::Remove container lin
		docker rm --force lin ;
		echo ::Remove image lin
		docker image rm lin
 		echo ::Copy new pulled image as lin
 		docker tag archlinux:base-devel lin
 		docker images ;
	elif [ "$PAR1" == "reload" ]; then
		echo ::Stop container lin
		docker stop lin ;
		echo ::Save container lin as new image lin
		docker commit lin lin ;
		echo ::Remove dangling images and volumes
		docker images -f 'dangling=true' -q | xargs --no-run-if-empty docker rmi ;
		docker volume ls -f 'dangling=true' -q  | xargs --no-run-if-empty docker volume rm ;
		echo ::Remove container lin
		docker rm --force lin ;
		echo ::Create and run container lin
		docker run --name lin --restart unless-stopped -d -it \
			--net=host \
			--hostname=lin \
			--privileged \
			--cap-add=NET_ADMIN \
			-v /var/run/docker.sock:/host/var/run/docker.sock \
			-v /dev:/host/dev \
			-v /proc:/host/proc:ro \
			-v /boot:/host/boot:ro \
			-v /lib/modules:/host/lib/modules:ro \
			-v /usr:/host/usr:ro \
			-v /home/michalm:/home/michalm \
			lin ;
		echo ::Show images
		docker images ;
		echo ::Show containers
		docker ps --format "$_DOCKER_PS_FORMAT" ;
	elif [ "$PAR1" == "start" ]; then
		docker start lin ;
		docker container ls -a | grep 'lin' ;
	elif [ "$PAR1" == "stop" ]; then
		docker stop lin ;
		docker container ls -a | grep 'lin' ;
	elif [ "$PAR1" == "restart" ]; then
		docker restart lin ;
		docker container ls -a | grep 'lin' ;
	elif [ "$PAR1" == "login" ]; then
		docker exec -it lin bash -c "$_SUDO -i -H -u michalm bash ~michalm/x/.xbashrc"
	elif [ "$PAR1" == "logs" ]; then
		docker logs --since 2h --follow lin
	elif [ "$PAR1" == "aymvpn" ]; then
		docker exec -i lin openfortivpn 188.65.44.58:10443
	fi
}
function cpdirs() {
	if [ -z "$1" ] || [ -z "$2" ]; then
		echo ::WRONG FORMAT::
		echo Usage: cpdirs DIR1 DIR2
	else
		rsync -a $1/ $2/ && touch $2/ && du -s $1/ $2/ ;
	fi
}
function cpmih() {
	\cp -f $1 ~michalm/ ; chmod 700 ~michalm/* ; chown michalm ~michalm/* ;
}
function cvsdiff() {
	cvsr diff -r HEAD $@
}
function cvsg() {
	cvs -d ':extssh:michalmcvs@repo.arubico.com:/srv/cvsroot' $@ 2>&1 | grep --color 'U \|P \|A \|R \|M \|C \|Client:\|Server:\|.* aborted]:\|?DDD '
}
function cvsr() {
 	cvs -d ':extssh:michalmcvs@repo.arubico.com:/srv/cvsroot' $@ 2>&1
}
function cvsupd() {
	cvsg update -d -P $@
}
function cvsupdn() {
	cvsg -n update -d -P $@
}
function lastfiles() {
	MYNR=$1
	if [ "$MYNR" == "" ]; then
		MYNR=10
	fi
	MYPATH=$2
	if [ "$MYPATH" == "" ]; then
		MYPATH=.
	fi
	echo - !!! Find last $MYNR files in current directory [!www_write !CVS]!!! -
	find $MYPATH -not \( -name 'www_write' -prune -o -name 'CVS' -prune \) -type f -printf "%T@ %TY-%Tm-%Td %TH:%TM:%.2TS %p\n" | sort -nr | head -n $MYNR | cut -d ' ' -f 2-
}
function diffproj() {
	diff --brief -Nr $1 $2 | grep -vE '(/www_write/|/CVS/)'
}
function grepl() {
	# Usage:
	#   grepl PATTERN [FILE]

	# how many characters around the searching keyword should be shown?
	context_length_before=20
	context_length_after=30

	# What is the length of the control character for the color before and after the matching string?
	# This is mostly determined by the environmental variable GREP_COLORS.
	control_length_before=$(($(echo a | grep --color=always a | cut -d a -f '1' | wc -c)-1))
	control_length_after=$(($(echo a | grep --color=always a | cut -d a -f '2' | wc -c)-1))

	grep -aE --color=always "$1" $2 | grep --color=none -aoE ".{0,$(($control_length_before + $context_length_before))}$1.{0,$(($control_length_after + $context_length_after))}"
}
function hping() {
	hping3 $1 -p $2 -c 2 -S
}
function psm() {
	if [ "$1" == "" ]; then
		$_SUDO ps_mem
	else
		$_SUDO ps_mem | grep -e Program -e $1
	fi
}

function _get_cur_dir_md5()
{
	echo "$(pwd -P | md5sum | awk '{print $1}')"
}

alias _init='_init'
function _init()
{
	_USER=michalm
	_TMPREPODIR=/tmp/bashrc.`_get_rand_str`

	git clone https://github.com/mezise/bashrc.git $_TMPREPODIR
	$_SUDO mkdir -p /home/$_USER/xx
	$_SUDO \cp -af $_TMPREPODIR/x/. /home/$_USER/xx/
	\rm -rf $_TMPREPODIR
	$_SUDO chown -R $_USER:$_USER /home/$_USER/xx

	grep -qF "source /home/$_USER/xx/.bashrc" /home/$_USER/.bashrc \
		|| echo "source /home/$_USER/xx/.bashrc" >> /home/$_USER/.bashrc
	_rrb
}

alias _setinit='_setinit'
function _setinit()
{
	if [ "`hostname`" == "box" ]; then
		_CURDIR=`pwd -P`

		_TMPREPODIR=/tmp/bashrc.`_get_rand_str`
		# _TMPREPODIR=/tmp/bashrc.111

		_FILES=()
		_FILES+=( /home/$_USER/x/.bashrc,$_TMPREPODIR/x/.bashrc )
		_FILES+=( /home/$_USER/x/.vimrc,$_TMPREPODIR/x/.vimrc )
		_FILES+=( /home/$_USER/x/.xscreenrc,$_TMPREPODIR/x/.xscreenrc )

		rm -rf $_TMPREPODIR ; git clone git+ssh://git@github.com/mezise/bashrc.git $_TMPREPODIR
		cd $_TMPREPODIR

		for row in ${_FILES[@]};
		do
			_FILE_SOURCE=${row%%,*}
			_FILE_TARGET=${row##*,}
			$_SUDO \cp -f $_FILE_SOURCE $_FILE_TARGET
			git add $_FILE_TARGET
		done

		git commit -a -m 'autocommit'
		git push -u -f origin master

		\rm -rf $_TMPREPODIR

		cd $_CURDIR
	else
		echo ::INFO: Not a box machine.
	fi
}

function _function_add_new_above_dummy() {
	:
}

# === PROMPTS ===
. /etc/environment
if [ -z "$MICHALM_SERVER_NAME" ]; then
	MY_SERVER=$(hostname)
else
	MY_SERVER=${MICHALM_SERVER_NAME}
fi
myPromptSign=$
if [ $(id -u) = 0 ]; then
	myPromptSign=#
fi
export PS1="[$MY_SERVER.\u \w] \n$myPromptSign "
function wtitle {
	if [ "$1" == "$(hostname)" ]; then
		myhost=$1
	else
		myhost=$1"."$(hostname)
	fi
	export PS1="\[\033]0;$myhost.\u:\w\007\]$PS1"
}
wtitle $MY_SERVER
# ===

#if [ -f /home/michalm/proxy_on.sh ] ; then
#	. /home/michalm/proxy_on.sh
#fi

export TERMINAL=/usr/bin/alacritty
export EDITOR=nvim
export CVSROOT=:extssh:michalmcvs@repo.arubico.com:/srv/cvsroot
export LC_ALL=C
PATH=$PATH:/usr/sbin/:/sbin/:~/bin/
export PATH
export FZF_DEFAULT_OPTS="-m --preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --history=$HOME/.fzf_history --bind ctrl-a:select-all,ctrl-d:deselect-all,f2:toggle-preview --ansi"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
export DUPLICACY_SSH_KEY_FILE='/root/.ssh/id_rsa'
export RUSTC_WRAPPER=sccache
export SCCACHE_DIR=/home/t/sccache
export CARGO_TARGET_DIR=/home/t/target

# export LANG=en_CA.utf8
# export LC_COLLATE=C
