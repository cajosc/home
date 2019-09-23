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

function ldapsearch () {
    /usr/bin/ldapsearch \
	-o ldif-wrap=no \
	-LLL \
	-x \
	-y ~/.gupasswd \
	"$@" | \
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
