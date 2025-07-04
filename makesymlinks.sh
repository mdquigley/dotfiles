#!/bin/bash
############################
# .makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Based on https://github.com/michaeljsmalley/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="zshrc ohmyzsh alias private"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~/"
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in ~/"
    ln -s $dir/$file ~/.$file
done

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my ohmyzsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/ohmyzsh/ ]]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh
