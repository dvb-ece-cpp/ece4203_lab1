#!/bin/bash

# ECE4203 / D. Van Blerkom
# Install script for miniconda3 

echo "Creating miniconda3 directory"
mkdir -p ~/miniconda3

echo "Retrieving installation file"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

echo "Executing installation file"
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

echo "Removing installation file"
rm -rf ~/miniconda3/miniconda.sh

echo "Setting up shell hooks"
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

echo "Installation complete - you must logout and log back in again to use Anaconda"

