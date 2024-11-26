if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export PATH="$HOME/.tmux/plugins/tmuxifier/bin/:$PATH"
ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="true"

plugins+=(git zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete zsh-vi-mode)

# Set cursor to blinking line
#echo '\e[5 q'


source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias cdl="cd $1; ls"
alias yays="yay -S $@"
alias yayr="yay -Rns $@"
alias f="fastfetch"
alias gpt="tgpt"
alias :q="exit"
alias py='python'
alias update-grub='sudo update-grub'
alias pacman-restart='sudo rm /var/lib/pacman/db.lck'
alias ls='lsd'
alias ranger='source ranger 2>/dev/null'
alias c='z'
alias ci='zi'
alias rm='rm -i'
alias mv='mv -i'
alias 'gitl'="git log --all --graph --decorate"


# Keybindings
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Functions
mcd() {
  mkdir -p $1 
  cd $1
}

run() {
  filename=$1 
  outputname="${filename%.*}"
  if [[ $filename == *.cpp ]]; then
    g++ -o "$outputname" "$filename"
  elif [[ $filename == *.c ]]; then
    gcc -o "$outputname" "$filename"
  elif [[ $filename == *.asm ]]; then
    nasm -f elf32 -o "${filename}.o" "$filename"
    ld -m elf_i386 -o "$outputname" "${filename}.o"
  elif [[ $filename == *.go ]]; then
    go build -o "$outputname" "$filename"
  elif [[ $filename == *.rs ]]; then
    rustc -o "$outputname" "$filename"
  elif [[ $filename == *.py ]]; then
    python "$filename"
  elif [[ $filename == *.java ]]; then
    javac "$filename"
  elif [[ $filename == *.sh ]]; then
    bash "$filename"
  else
    echo "Unknown file type"
    return 1

  fi

  if [ $? -eq 0 ]; then
    echo "Compilation successful\n"
    if [[ $filename == *.java ]]; then
      java $outputname
    elif [[ $filename == *.py ]]; then
      echo ""
    elif [[ $filename == *.sh ]]; then
      echo ""
    else
      ./"$outputname" 
    fi
    echo "\nExit code: "$?
  else
    echo "Compilation is fucked."
  fi
}
  
function gpt() {
  while true
  do
    # Input text
    echo -n "Input: "
    read userInput
    # Exit the function when user input is ":q"
    if [[ $userInput == ":q" ]]; then
      return 
    else
      tgpt "$userInput"
    fi
  done
  
}
ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
function brickrun(){
  sshpass -p "maker" scp -r ~/Code/ev3/$1 robot@10.42.0.3:/home/robot/ev3/  
  sshpass -p "maker" ssh robot@10.42.0.3 "brickrun ./ev3/$1"
}
function bricksend(){
  sshpass -p "maker" scp -r ~/Code/ev3/$1 robot@10.42.0.3:/home/robot/ev3/  
  if [ $? -ne 0 ]; then
    echo "Error"
  else 
    echo "File sent successfully"
  fi
}


eval "$(zoxide init zsh)"
#eval "$(tmuxifier init -)"
