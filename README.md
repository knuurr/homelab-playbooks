# HomeLab Showcase 🏠

Welcome to the HomeLab Showcase, where I share the infrastructure setup of my personal homelab. This project revolves around leveraging Ansible playbooks and Docker Compose to streamline the management of various applications within my homelab environment.

The end result is a bootstrapped server with a **reverse proxy** using **Traefik v2**, protected by **Single Sign-On (SSO) with Authelia**. Additionally, a dashboard provided by the **Homepage** project displays all necessary services, thanks to clever use of *labels* within compose stacks for autodiscovery.


## Introduction

My homelab infrastructure is designed to be easily deployable and maintainable using Ansible playbooks and Docker Compose. The main playbooks and configurations are organized to provide a clear understanding of the setup, with a focus on simplicity and flexibility.

## Warning

I provide this repo as learning opportunity for others. Since it's my Homelab expect things to sometimes break, sometims change drastically without any notice. Be warned if you try to attempt to mirror my infrastructure and follow any commits.

## Project Structure

### `main.yml`

The `main.yml` file serves as the primary playbook for bootstrapping the homelab. While it was initially used to set up the entire infrastructure, it may not contain all roles due to infrequent updates. Use it as a starting point and customize it according to your needs.

### `manage-containers.yml`

This playbook, `manage-containers.yml`, facilitates the synchronization of the stack folder between local and remote locations. Utilizing arrays, it performs various container operations such as stopping, starting, recreating, and restarting. It's a quick way to manage containers.

### `docker-compose/`

This folder holds the entire stack of Docker Compose files used for hosting various services. Each application has its dedicated folder containing a `docker-compose.yml` file and an `.env.example` file. To use the provided files, remove the `.example` suffix from both files in the respective application folder.

### `roles/`

The `roles/` folder comprises various Ansible roles used to set up different aspects of the homelab infrastructure. Roles are organized by tasks, and some may include subdirectories with additional files.

### `handlers/`

The `handlers/` folder contains various handlers used in the playbook execution. These handlers are triggered to respond to specific events during the deployment and maintenance processes.

### `maintenance/`

The `maintenance/` directory houses playbooks dedicated to system maintenance tasks, such as updates and monitoring free disk space. Regularly running these playbooks ensures the homelab stays up-to-date and performs optimally.

### `vars/`

The `vars/` folder is the designated location for setting up variables. Ensure to remove the `.example` suffix from the provided files, particularly within the `docker-compose/` and `vars/` folders. Adjust these variables according to your homelab requirements.

I document only the most "sure" files in here as some of my ideas come and go.

## Usage

1. Remove all files with the `.example` suffix, primarily within the `docker-compose/` and `vars/` folders.
2. Remove the `.example` suffix from `ansible.cfg` and `inventory`.
3. Check and adjust variables under the `vars/` folder.
4. Run the `main.yml` playbook to bootstrap your homelab.

## Contributing

Contributions to enhance and expand this homelab showcase are welcome. Feel free to submit issues, feature requests, or pull requests.


## Things to consider:

- fix oh-my-zsh install and plugin instllation
- adjust Ansible user elevation in playbooks
- (eventually) move it all to *Kubernetes*
- GitOps - it's not as convienent when using Docker-Compose as it is with Kubernetes sadly.


All remarks and questions related to my project welcome :)


Happy Homelabbing!