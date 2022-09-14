#!/bin/zsh
echo "Starting brew maintenance."
brew update
brew upgrade
brew cleanup
brew update
brew upgrade
brew cleanup
echo "Brew maintenance done."

