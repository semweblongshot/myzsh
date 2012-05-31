# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="longshot"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# source my functions
source ${HOME}/Documents/Workspace/myzsh/my_funcs.zsh

# vi mode please
set -o vi

# Super user
alias _='sudo '

# Show history
alias h='fc -l 1'
alias j='jobs'

# List direcory contents
alias l='ls -l'
alias la='ls -la'
alias a='ls -a'
alias sl=ls # often screw this up

# LS colors
export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Less settings
export PAGER=less
export LESS='-idqsMeP?f%f :stdin .?e(EOF) ?xNEXT\: %x.:?ltLine %lt .?bB(%bB?s/%s) :) .?pB%pB\% .?m(file %i of %m) ....%t'
export GIT_PAGER='less -FRX'

# CDPATH
export CDPATH=.:${HOME}:${HOME}/Documents/Workspace/client_support:${HOME}/Documents/Workspace

# PATH
export PATH=${HOME}/bin:${HOME}/Documents/Workspace/client_support/scripts:.:${PATH}

# Java environment
# export JAVA_HOME=/Library/Java/Home
export JAVA_HOME=$(/usr/libexec/java_home)
addPath -e JAVA_HOME

# ARQ
export ARQROOT=${HOME}/java/ARQ-2.8.8
addPath -e ARQROOT

# Groovy
export GROOVY_HOME=${HOME}/java/groovy
addPath -e GROOVY_HOME

# GIT
export GIT_HOME=/usr/local/git
addPath -e GIT_HOME

# subversion
export SUBVERSION_HOME=/opt/subversion
addPath -e SUBVERSION_HOME

# MySQL environment
export MYSQL_HOME=/usr/local/mysql
addPath -e MYSQL_HOME

# PostgreSQL
export POSTGRES_HOME=/Library/PostgreSQL/8.3
addPath -e POSTGRES_HOME

# ANT
export ANT_HOME=${HOME}/java/ant
addPath -e ANT_HOME

# Maven
export MAVEN_OPTS="-Xmx2048m"
export MAVEN_HOME=${HOME}/java/maven
addPath -b -e MAVEN_HOME

# Release notes
export EDRN_HOME=${HOME}/Documents/Workspace/lm-scripts/ed-release-notes
addPath -e EDRN_HOME

# personal usb drive
addPath -b /Volumes/personal/bin 
