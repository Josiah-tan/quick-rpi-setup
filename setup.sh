#!/bin/bash

function update_and_upgrade() {
    sudo apt update
    sudo apt upgrade -y
}

function install_packages() {
    sudo apt install -y git ninja-build gettext cmake unzip curl tmux xsel xclip fd-find ripgrep vim
		# fzf (bash autocomplete ctrl-r)
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install --all
		# nvm
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
		source ~/.bashrc
		# Node.js
		nvm install 20
}

function setup_neovim() {
    git clone https://github.com/neovim/neovim
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ..
}

function clone_configs() {
    git clone https://github.com/Josiah-tan/vimconfig.git ~/.vim
    git clone https://github.com/Josiah-tan/nvimconfig.git ~/.config/nvim
    git clone https://github.com/Josiah-tan/quick-projects-nvim-template.git ~/.config/.quick_projects
    curl -o ~/.tmux.conf https://raw.githubusercontent.com/Josiah-tan/.dotfiles/main/tmux/.tmux.conf
}

show_help() {
    echo "Usage: $0 [-u] [-i] [-n] [-c]"
    echo "  -u    Update and upgrade the system"
    echo "  -i    Install necessary packages"
    echo "  -n    Setup Neovim"
    echo "  -c    Clone configurations"
    echo "  -h    Show this help message"
}

while getopts "uincfh" opt; do
    case ${opt} in
        u )
            update_and_upgrade
            ;;
        i )
            install_packages
            ;;
        n )
            setup_neovim
            ;;
        c )
            clone_configs
            ;;
        h )
            show_help
            ;;
        \? )
            show_help
            ;;
    esac
done

# If no flags were passed, show help
if [ $OPTIND -eq 1 ]; then show_help; fi

