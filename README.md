# AWS, Docker, Jenkins, Ansible, Nexus combined Devops example task.

## Purpose
- The purpose of this project is studying and demonstration of abilities.
- It should not be used in production;
  - As security is not configured.
  - Everything is run on one server and not best practicate.

## What is does ?

```
#!/bin/bash
# create dockerized build automation environment

# create a folder for this run to keep ansible files
mkdir ~/ansible-task; cd ~/ansible-task

for log in "user-data"; do

  # install python-pip and git
  apt-get update
  apt-get -y install python-pip git
  pip install ansible

  # fetch ansible playbook files from git temporarily
  git init
  git remote add origin https://github.com/lonynamer/ansible-task.git
  git fetch origin
  git checkout origin/master -- ansible/

  # run playbook to install docker and dockerized jenkins nexus
  cd ./ansible/
  ansible-playbook docker-jenkins-nexus-install.yaml
  echo -e "\n\nTASK_COMPLETED_OK"

done &> ~/ansible-task/user-data.log
```
