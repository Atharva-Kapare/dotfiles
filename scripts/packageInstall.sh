sudo apt update && sudo apt upgrade -y

function aptInstall {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

aptInstall curl
aptInstall git
aptInstall awscli
aptInstall htop

aptInstall make
aptInstall unzip
aptInstall gcc
aptInstall ripgrep

# Fun ones apparently
aptInstall figlet
aptInstall lolcat


sudo snap install nvim --classic

# Run all scripts in programs/
for f in programs/*.sh; do bash "$f" -H; done
