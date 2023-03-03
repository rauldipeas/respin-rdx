#!/bin/bash
set -e

# Ubuntu extra repo
add-apt-repository -ny multiverse
add-apt-repository -ny universe

# Raul Dipeas apt repository
bash -x <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)

# System update
sudo apt update
export DEBIAN_FRONTEND=noninteractive
if [ -f /usr/share/xsessions/xubuntu.desktop ]; then
    sudo apt autoremove --purge chromium-browser
fi
sudo apt dist-upgrade -y -o Dpkg::Options::="--force-confdef" --force-yes

# deb-get
sudo apt install -y deb-get

# Pacstall
sudo apt install -y pacstall

# Respin RDX scripts
sudo mkdir -p /usr/local/bin
cat <<EOF |sudo tee /usr/local/bin/get-respin-rdx
#!/bin/bash
set -e
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/get-respin-rdx.sh) "\$1"
EOF
chmod +x /usr/local/bin/get-respin-rdx
cat <<EOF |sudo tee /usr/local/bin/upgrade-respin-rdx
#!/bin/bash
set -e
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/upgrade-respin-rdx.sh)
EOF
chmod +x /usr/local/bin/upgrade-respin-rdx