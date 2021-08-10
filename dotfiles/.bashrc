# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias cdtemp='cd $(mktemp -d)'

which oc > /dev/null 2>&1 && source <( oc completion bash )

which rclone > /dev/null 2>&1 && source <( rclone genautocomplete bash /dev/stdout )

function ldapsearch () {
    /usr/bin/ldapsearch \
	-o ldif-wrap=no \
	-LLL \
	-x \
	-y ~/.gupasswd \
	"$@" | \
	egrep -v '^$|^#' | \
	while read field value ; do
	    if [[ "$field" =~ ::$ ]] ; then
		field="${field::-1}"
		decoded=$(echo $value | base64 -d)
		echo $decoded | grep -q '[[:cntrl:]]' || value=$decoded
	    fi
	    echo -n $field
	    [ -n "$value" ] && echo -n " $value"
	    echo
	done 2>/dev/null
}

complete -C /var/home/cjs/.local/bin/mc mc

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] ; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
else
    alias __git_ps1=false
fi

if [ -f /run/.containerenv ] ; then
    __toolbox_name="[$(awk 'BEGIN{FS="="} $1 == "name" {print substr($2, 2, length($2)-2)}' /run/.containerenv)]"
else
    __toolbox_name=""
fi

__red="\[\e[31m\]"
__green="\[\e[32m\]"
__yellow="\[\e[33m\]"
__blue="\[\e[34m\]"
__magenta="\[\e[35m\]"
__cyan="\[\e[36m\]"
__reset="\[\e[0m\]"

if [ -n "$PS1" ] ; then
    PS1="[${__green}\u@\h${__toolbox_name}${__reset} ${__yellow}🗀 \w${__reset} ${__cyan}☸\$(oc whoami -c | sed -e 's#^\([^/]*\)/\([^/:]*\).*/\(.*\)#\3@\2/\1#g')${__reset}${__red}\$(__git_ps1 \" %s\")${__reset}]\$ "
fi

export EDITOR=vi
