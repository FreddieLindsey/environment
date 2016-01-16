## SETTINGS


## --------

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# jenv
jenv_path="$HOME/.jenv/bin"
export PATH="$jenv_path:$PATH"
[ -d "$jenv_path" ] && eval "$(jenv init -)"

# junit
export CLASSPATH=".:$HOME/.config/extras/junit/junit.jar"

# maven
export PATH="$HOME/.config/extras/apache-maven-3.3.9/bin:$PATH"

# Default user avoids unnecessarily long prompt
export DEFAULT_USER="$(basename ~)"

# rbenv
rbenv_path="$HOME/.rbenv/bin"
export PATH="$rbenv_path:$PATH"
[ -d "$rbenv_path" ] && eval "$(rbenv init -)"

# pebble
export PATH="$HOME/.config/extras/pebble/bin:$PATH"

# Set history per session
unsetopt inc_append_history
unsetopt share_history

# cpp aliases
alias gplus="g++-5 -Wall -Werror -pedantic -std=c++11"
alias gnorm="gcc-5 -Wall -Werror -pedantic -std=c90"

# ANTLR4
# alias set_antlr4="export CLASSPATH=\".:$HOME/.config/extras/antlr4/antlr-4.5.1-complete.jar:$CLASSPATH\""
alias antlr4="java -jar $HOME/.config/extras/antlr4/antlr-4.5.1-complete.jar"
alias grun="java org.antlr.v4.gui.TestRig"
alias grun_basic="pi | xargs cat | ./grun antlr.Basic program -gui"

# Haskell
export PATH="$HOME/.cabal/bin:$PATH"

# Prolog
sicstus_path="/usr/local/sicstus4.3.2/bin"
export PATH="$sicstus_path:$PATH"
[ -d "$sicstus_path" ] && alias sicstus="rlwrap sicstus"

# imperial aliases
alias gcic="git clone git@gitlab.doc.ic.ac.uk:$1/$2"
alias gpic="git push gitlab master; git push github master"

# LTSA alias
alias ltsa="java -jar ~/Google\ Drive\ \(freddielindsey.me\)/Documents/Imperial/Year\ 2/CO\ 223\ Concurrency/LTSA\ Tool/ltsatool/ltsa.jar"
