#[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
#[ -z "$TMUX"  ] && { tmux attach || exec tmux new -s "tmux" && exit;}

#24283b Enable Powerlevel10k instant prompt. Should stay close to the top of /home/michael/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-/home/michael/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-/home/michael/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#if [[ $(whoami) != "root" ]]; then
  ##export PF_INFO="ascii title os host kernel uptime pkgs memory wm shell editor"
  #export PF_INFO="ascii title os kernel wm pkgs shell"
  #pfetch
#fi


#font size
if [[ $DESKTOP_SESSION = 'gnome' || $DESKTOP_SESSION = 'gnome-xorg' ]]; then
  if [[ $(xrandr --listmonitors | wc -l) -gt 2 ]]
  then
    python /home/michael/.customizar.py -s 8.5
  else
    python /home/michael/.customizar.py -s 9.5
  fi
fi

export _JAVA_AWT_WM_NONREPARENTING=1

######################### ALIASES ##########################

alias yt='youtube-dl'
alias bl='brightnessctl set 100%-'
alias pb='cd /home/michael/.config/polybar'
alias bp='cd /home/michael/.config/bspwm'
alias cl='clear'
alias ca='cd ..'
alias caa='cd ../..'
alias cn='bluetoothctl'
alias tree="exa -T --icons"
alias tred="exa -TD --icons"
alias l='exa'
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias lsa='exa -a'
alias la='exa -al'
alias ll='exa -l'
alias ls="exa"
alias kn='ssh spb20@dif-cluster.si.ehu.es'
alias feh='feh -F'
alias rr='ranger'
alias nvim='nvim -p'
alias vi='nvim'
alias suvi='sudoedit'
alias cm='python /home/michael/.customizar.py'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias at='alacritty-themes && rm /home/michael/.config/alacritty/*bak' 
alias p='paru'
alias e='exit'
alias updt='paru -Syyuu --noconfirm && paru -Rns $(paru -Qqdt) --noconfirm'
alias spnd='systemctl suspend && exit'
alias cat="bat --theme=base16 --style=full --paging=never"
alias history='cat /home/michael/.zsh_history'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
export VISUAL=nvim;
export EDITOR=nvim;

############### FUNCIONES ##########################

nvimx() {
  touch $1; chmod 755 $1; 
  if [[ $1 == *.py ]]; then
    #echo "#!/usr/bin/env python\n\ndef main():\n\tpass\n\nif __name__ == '__main__':\n\tmain()" >> $1
    echo "#!/usr/bin/env python\n\ndef main():\n\n\nif __name__ == '__main__':\n\tmain()" >> $1
    nvim +4 $1
  elif [[ $1 == *.sh ]]; then
    echo "#!/bin/sh\n\n" >> $1
    nvim +3 $1
  fi
}

dot() {
  a="$(readlink -f $1)"
  b=${a:14}
  c="/home/michael/code/repos/dotfiles/$b"
  cp -r $a $c 
}

gcx() {
  gcc $1 -o $2 -lm; ./$2
}

gco() {
  gcc -O2 -fopenmp $1 -o $2 -lm; ./$2
}

gcn() {
        nvcc -O2 $1 -o $2 -lm; ./$2
}

cop() {
  xclip -sel c < $1
}

newhist(){
  cd /home/michael
  mv .zsh_history .zsh_history_bad
  strings -eS .zsh_history_bad > .zsh_history
  fc -R .zsh_history
  rm .zsh_history_bad
}


##################### HISTORY ########################

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=/home/michael/.zsh_history

##################### WINDOW TITLE ###################


function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

# Runs before showing the prompt
function mzc_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec


#################### VIM MODE ########################

bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


#################### P10K ###########################


# To customize prompt, run `p10k configure` or edit /home/michael/.p10k.zsh.
[[ ! -f /home/michael/.p10k.zsh ]] || source /home/michael/.p10k.zsh

source /home/michael/.repos/powerlevel10k/powerlevel10k.zsh-theme

#Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

################### ANACONDA #########################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/michael/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/michael/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/michael/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/michael/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

