# docker-gollum

It installs [gollum](https://github.com/gollum/gollum/) and a cron job pushing your changes made to a remote repository.

## Setup

* Clone this repository
`git clone https://github.com/roberto/docker-gollum.git`
* Create a git repository to be used as backup by your Wiki.
* Create a ssh config file with the repository host. Example:

ssh_config:

```
Host github.com
    Hostname github.com
    User git
    IdentityFile ~/.ssh/id_rsa

```

* Generate ssh keys credentials to access it, creating a file with the private key:
`ssh-keygen -t rsa -b 4096 -f id_rsa`
* Add your public key (id_rsa.pub) at your repository host.
	* https://bitbucket.org/account/user/[username]/ssh-keys/
	* https://github.com/[username]/docker-gollum/settings/keys/

## Usage

### Building

```
docker build \
--build-arg repodomain=github.com \
--build-arg repo=git@github.com:owner/project.git \
--build-arg sshkey=id_rsa \
--build-arg sshconfig=ssh_config \
-t gollum .
```

### Running

`docker run -p 4567:80 gollum`

---
Based on [fooforge/docker-gollum](https://github.com/fooforge/docker-gollum) and [aptible/docker-cron-example](https://github.com/aptible/docker-cron-example).
