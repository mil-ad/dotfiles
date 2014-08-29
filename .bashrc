#echo 'Hello Milad. You're in'


# "Marks" from onethingwell.org
# http://onethingwell.org/post/58703826506/marks
# -------------8<---------------------------8<---------------------------
export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark
# -------------8<---------------------------8<---------------------------


#############################
## Shell options (shopt)
#############################
shopt -s cdspell			# Ignore minor typos when using `cd`



export CVSROOT=:pserver:milad.alizaden@chcvs.ch.imgtec.org:/cvs
export P4USER=milad.alizaden
export P4PORT=klperforce.kl.imgtec.org:1666
export P4CONFIG=.p4config


#export METAG_INST_ROOT=/opt/imgtec/metag/2.8
#export UCC_INST_ROOT=/opt/imgtec/ucc/4.22.2

alias g='grep -r -i'
alias e='~/Developer/eclipse/eclipse'
alias s='/opt/sublime_text/sublime_text'
alias ag='ack-grep --ignore-case -C 2 --color-match="bold red" --ignore-dir=docs'
alias ll='ls -l'
alias pc3='nohup rdesktop -d ch -u ensigma.lab -p Bqd4ML7t chlabpc3 &'
alias pc9='nohup rdesktop -d ch -u ensigma.lab -p Bqd4ML7t chShuttle9 &'
alias chUbuntu='ssh -X chlinuxuser1@chUbuntuDesktop1.ch.imgtec.org'
alias p4bt='p4 -c milad.alizadeh_bt_ws'
alias ..='cd ..'
alias more='less'

export PATH=$PATH:/home/milad/Developer/klockwork/bin
export PATH=$PATH:/home/milad/Developer/p4v-2013.4.760393/bin
export PATH=$PATH:/home/milad/bin
export PATH=$PATH:.