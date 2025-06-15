# Dotfiles
Custom dotfiles are kept in ~/dotfiles, and are symlinked to the user's home directory. The make script also checks for **zsh** and **oh-my-zsh** and installs them if not found.

## Installation
Clone the repo into your home directory:
`git clone git@github.com:mdquigley/dotfiles.git ~/dotfiles`

Open the cloned directory:
`cd ~/dotfiles`

Run the script to symlink the listed files and install zsh:
`./makesymlinks.sh`

### Credit
Adapted from **michaeljsmalley/dotfiles (https://github.com/michaeljsmalley/dotfiles)**
