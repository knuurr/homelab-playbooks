# homelab-playbooks 🏠


Playbooks used for provisioning my home server. 

I extensively describe how I setup my home server, along with explanation of various choices I made in ![my homeserver writeup](https://github.com/knuurr/homelab-writeup).

Created initially to learn about DevOps and automation technologies. 

I publish it because I'm confident that someone might benefit and learn from my work.

I tested this playbook on my machine and I consider it working, but this is an WIP project, so changes, bugs should be expected. 

# How to use

## Preparation

First, you must change extension of each `.example` file to it's native file extension.

Inside each `docker-compose/docker-compose-*/` folder there is `.env.example` file which sets up enviromental variables for particula docker-compose app. Remember to change extension and populate it with your desired values (in most, only subdomain needs to be changed).

Inside `vars/` folder there are also several files which need to have their `.example` suffix removed. Please also take a look inside them and populate with desired values.

## Provisioning

`main.yml` contains calls to all the roles that, after playbook is run, should provision ready-to-use home server, with and containers installed and started.

I also advise to use `config-traefik.yml` playbook to upload necessary Authelia + Traefik configuration files, sourced from Jinja2 templates, located in `files/` folder, *either after first* run or after *each configuration change*.

This is how I personally use this playbook, to upload any configuration changes to the server. Currently this is not integrated into `main.yml`.

There is also `test-compose.yml` playbook for restarting docker-compose applications, if there is need to refresh docker-comopose file, env variables or any other, os that `main.yml` doesn't have to be called.


Things to consider:

- fix oh-my-zsh install and plugin instllation
- adjust Ansible user elevation in playbooks
- (eventually) move it all to *Kubernetes*


All remarks and questions related to my project welcome :)
