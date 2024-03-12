# Testing SSH

## Setup
* docker compose build
* docker compose up -d
* update ~/.ssh/config file and add the following lines;
```
Host ssh-server
  User opf_ssh_user
  Port 22
  GSSAPIAuthentication no
  PubKeyAuthentication yes
  IdentitiesOnly yes
  IdentityFile <path-to>/ssh_assets/id_opf_ssh_user_ed25519
```
* connect using ssh
    * `ssh opf_ssh_user@localhost` - this shold forward to sshd within the container. See port binding in docker-compose.yml
    * `ssh opf_ssh_user@ssh-server` - this will require an update to /etc/hosts as follows;
```
127.0.0.1 ssh-server
```


