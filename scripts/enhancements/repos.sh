#!/bin/bash
set -e

# Ubuntu extra repo
add-apt-repository -ny multiverse
add-apt-repository -ny universe

# Raul Dipeas apt repository
bash -x <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)

# deb-get
apt update
wget -q --show-progress --header="X-Auth-Token: $GITHUB_TOKEN" "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/wimpysworld/deb-get/releases|grep browser_download_url|grep download|grep .deb|head -n1|cut -d '"' -f4)"
sudo apt install -y ./deb-get*.deb

# Pacstall
wget -q --show-progress --header="X-Auth-Token: $GITHUB_TOKEN" "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/pacstall/pacstall/releases|grep browser_download_url|grep download|grep .deb|head -n1|cut -d '"' -f4)"
sudo apt install -y ./pacstall*.deb

# Respin RDX scripts
sudo mkdir -p /usr/local/bin
cat <<EOF |sudo tee /usr/local/bin/get-respin-rdx
#!/bin/bash
set -e
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/get-respin-rdx.sh) "\$1"
EOF
cat <<EOF |sudo tee /usr/local/bin/upgrade-respin-rdx
#!/bin/bash
set -e
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/upgrade-respin-rdx.sh)
EOF