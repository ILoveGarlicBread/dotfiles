if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="true"

plugins+=(git zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias f="fastfetch"
alias gpt="tgpt"
alias :q="exit"
alias yays="yay -S $1"
alias yayr="yay -Rns $1"
alias py='python'
alias vi='nvim'
alias update-grub='sudo update-grub'
alias pacman-restart='sudo rm /var/lib/pacman/db.lck'
alias keysound='Neptune -cli -soundkey "Nk Cream 2"'
alias ls='lsd'
alias pyactivate='source .venv/bin/activate'
alias birdears='python -m birdears'
alias icat='kitten icat'
alias ranger='source ranger 2>/dev/null'
alias c='z'
alias ci='zi'

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
    return 1
  elif [[ $filename == *.sh ]]; then
    bash "$filename"
  else
    echo "Unknown file type"
    return 1

  fi

  if [ $? -eq 0 ]; then
    echo "Compilation successful\n"
    ./"$outputname"
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


eval "$(zoxide init zsh)"
eval "$(tmuxifier init -)"
