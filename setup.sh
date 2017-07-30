#!/bin/bash

# Symlink dotfiles to ~/
# Backs up existing dotfiles to ~/.dotfiles_old/
# Much of this is taken from https://github.com/nicksp/dotfiles


get_os() {

  declare -r OS_NAME="$(uname -s)"
  local os=""

  if [ "$OS_NAME" == "Darwin" ]; then
    os="osx"
  elif [ "$OS_NAME" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
    os="linux"
  fi

  printf "%s" "$os"

}

dir_backup=~/.dotfiles_old             # old dotfiles backup directory

# Create dotfiles_old in homedir
echo -n "Creating $dir_backup for backup of any existing dotfiles in ~/"
mkdir -p $dir_backup

declare -a FILES_TO_SYMLINK=(

  'vimrc'
  'nethackrc'
  'gdbinit'
  'bash_profile'
  'gitconfig'
  'gitignore_global'

)

# Move any existing dotfiles in homedir to dotfiles_old directory
echo "Moving any existing dotfiles from ~ to $dir_backup"
for i in ${FILES_TO_SYMLINK[@]}; do
  mv ~/.${i##*/} $dir_backup
done

# Then create symlinks from the homedir to any files in the ~/dotfiles directory
echo "Creating symlinks to ~/"
for i in ${FILES_TO_SYMLINK[@]}; do

  sourceFile="$(pwd)/$i"
  targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

  if [ "$sourceFile" == "$(pwd)/bash_profile" ]; then
    sourceFile="$(pwd)/bash_profile_$(get_os)"
  fi

  if [ ! -e "$targetFile" ]; then
    ln -fs $sourceFile $targetFile
  fi
  if [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
    printf "\e[0;32m[✔] $targetFile → $sourceFile\e[0m\n"
  else
    printf "\e[0;31m[x] $targetFile → $sourceFile\e[0m\n"
  fi

done
