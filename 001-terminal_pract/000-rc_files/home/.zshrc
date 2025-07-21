# env variables for scripts, aliases


# These are defaults for startup
cal; date; echo "\nWelcome Back -- What are we doing today?";

# This is for connecting to the server, will add conditional to check if it's active later. 


# This is for telling terminal where the man pages are

# Colors for various things
# %n, %m, %1~, and %# are placeholders for username, hostname, 
# truncated path, and prompt character, respectively.

PROMPT='%F{yellow}%1~ %F{blue}%n@%m %F{green}%# %f'

export LSCOLORS=ExFxCxDxBxegedabagacad

# this is for ls aliases
alias where="pwd | sed -E 's/ /\\\\/g' ";
alias pract="cd /Users/23340-webster/Desktop/001-Programming/practice_notes ; l ";
alias t='todo.sh';
alias ls='ls -G';
# >> sourcing .files
alias ediVim='vim ~/.vimrc'
alias ediZsh='vim ~/.zshrc'
alias srcZsh='source /Users/23340-webster/.zshrc'
alias srcVim='source /Users/23340-webster/.vimrc'
# >> moving around
alias homeLib='cd /Volumes/240210-LBSH/000-library'
alias homeGen='cd /Volumes/240210-LBSH/'
alias homeServer='cd /Volumes/240210-LBSH/'
# this is for using pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    	eval "$(pyenv init -)"
fi
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'

# exports
export MANPATH="/usr/share/man:/opt/local/share/man:usr/local/share/man:/usr/local/man:/usr/local/Cellar:/usr/local/Homebrew/:$MANPATH"
export PATH="/usr/local/bin:/usr/local/Cellar:/home/user/bin:/Users/23340-webster/scripts:/usr/local/sbin:/usr/local/Cellar:$PATH"
export PATH="/usr/local/bin:/Users/23340-webster/scripts:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
