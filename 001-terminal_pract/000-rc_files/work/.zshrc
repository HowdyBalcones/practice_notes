cal; date; echo "\nWelcome Back -- What are we doing today?";

# Color for the terminal
PROMPT='%F{yellow}%1~ %F{blue}%n@%m %F{green}%# %f'

export LSCOLORS=ExFxCxDxBxegedabagacad

# this is for aliases
alias where="pwd | sed -Ee 's/ /\\\\ /g' -e 's/\\(/\\\(/g' -e 's/\\)/\\\)/g' ";
alias pract="cd /Users/camdenbailey/.repos/practice_notes ; l ";
alias t='todo.sh';
alias ls='ls -G';
alias l='ls -laF';
alias fontLib='open /Users/camdenbailey/Library/Fonts';

# >> sourcing .files
alias ediVim='vim ~/.vimrc'
alias ediZsh='vim ~/.zshrc'
alias srcZsh='source /Users/camdenbailey/.zshrc'
alias srcVim='source /Users/camdenbailey/.vimrc'

# >> moving around
alias signB='cd /Volumes/company/Signs/Sign\ Books'
alias signC='cd /Volumes/company/CONTRACTS/'
alias signLib='cd /Volumes/company/Signs/Multi\ Use\ 2\.0/0-Approved/\~Sign\ Library/'
alias cbf='cd /Users/camdenbailey/Desktop/003-CBFource/Jobs/'
alias genU='cd /Volumes/company/General_Use/003-CBFource/Jobs/'

# >> changing some keybindings
#bindkey "\e[1;5D" backword-word
#bindkey "\e[1;5C" backword-word
set -o vi

# this is for backups, FRC job utils
alias upFrc='rsync -rv /Users/camdenbailey/Desktop/003-CBFource/Jobs/ /Volumes/company/General_Use/003-CBFource/Jobs/'

# this is for using pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    	eval "$(pyenv init --path --no-rehash)"
fi
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'

# this is all configuration for ycm-core
#export PATH="/usr/local/opt/llvm/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/llvm/lib"
#export CPPFLAGS="-I/usr/local/opt/llvm/include"
#export CC="/usr/local/opt/llvm/bin/clang"
#export CXX="/usr/local/opt/llvm/bin/clang++"

export MANPATH="/usr/share/man:/opt/local/share/man:usr/local/share/man:/usr/local/man:/usr/local/Cellar:/usr/local/Homebrew/:$MANPATH"
export PATH="/usr/local/bin:/usr/local/Cellar:/home/user/bin:/Users/camdenbailey/scripts:/usr/local/sbin:/usr/local/Cellar:$PATH"
#export PATH="/usr/local/bin/:/Users/camdenbailey/scripts:$PATH"
#export PATH="$HOME/.pyenv/bin:$PATH"
  
  
