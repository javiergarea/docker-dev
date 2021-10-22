# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:~/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_DISABLE_COMPFIX=true

plugins=(
	git
	asdf
	common-aliases
	rand-quote
	sudo
	colorize
	virtualenv
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# pure
fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure

# asdf
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

# Erlang
export KERL_CONFIGURE_OPTIONS="--without-javac"
asdf global erlang 23.3
asdf global rebar 3.16.0
export ERL_AFLAGS="-kernel shell_history enabled"

# Elixir
asdf global elixir 1.12.1-otp-23
