# Backup for dotfiles and setup script

## configs for:
1. .zshrc
2. kitty terminal
3. fastfetch
4. optimus-manager



## Theme related content:
1. FiraCode fonts
2. Fira Sans fonts
3. Colloid Nord Dark for gnome-shell


## Screenshots
![alt text](https://github.com/ILoveGarlicBread/dotfiles/blob/master/screenshot1.png)

## Installation
Enable firewall and add exception for gsconnect.
```sh
sudo ufw enable
sudo ufw allow 1716:1764/tcp
sudo ufw allow 1716:1764/udp
sudo firewall-cmd --permanent --zone=public --add-service=kdeconnect 
sudo firewall-cmd --reload
```
Generating ssh key for  github
For more info: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

```sh 
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

```
Run this in all git directory to disable passphrase checking with git actions.
```sh
eval $(ssh-agent)
ssh-add
```
Make bash scripts executable:

```sh 
sudo chmod +x backup.sh install-gnome-extensions.sh setup.sh 
```
Run setup script:
```sh 
./setup.sh
```






