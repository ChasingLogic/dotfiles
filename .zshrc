export PATH="/usr/local/opt/helm@2/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    docker
    dotenv
    helm
)

source $ZSH/oh-my-zsh.sh

# User configuration

source $HOME/.profile
source $HOME/.prompt.zsh
source $HOME/.functions.sh
source_if_exists $HOME/.env.sh
source_if_exists $HOME/.aliases.sh

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/2.2.16/gems/vagrant-2.2.16/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)
