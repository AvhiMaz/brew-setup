#! /bin/bash

###########################################################
# Script Name: brew-setup.sh
# Description: This script automates the installation of Homebrew on various Linux distributions based on their package managers.
# Version: 1.0
# Date: December 2023
###########################################################

function is_arch() {
	if [ -f "/etc/arch-release" ]; then
		return 0
	else
		return 1
	fi
}

function is_debian() {
	if [ -f "/etc/debian-release" ]; then
		return 0
	else
		return 1
	fi
}

is_linux_mint() {
	if [ -f "/etc/linuxmint/info" ]; then
		return 0
	else
		return 1
	fi
}

if is_arch; then
	echo "Arch-based distribution is detected. Installing Homebrew for Arch... "
	sudo pacman -Syyu --noconfirm
	sudo pacman -S base-devel --noconfirm
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	echo "Homebrew installation completed. Please restart your terminal or run 'source ~/.zshrc' to start using Homebrew."

elif is_debian || is_linux_mint; then
	echo "Debian-based distribution is detected. Installing Homebrew for Debian..."
	sudo apt-get update && upgrade
	sudo apt-get install -y build-essential curl file git
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	echo "Homebrew installation completed for Debian. Please restart your terminal or run 'source ~/.bashrc' to start using Homebrew."

else
	echo "Unsupported Distribution"
	exit 1

fi
