## AWS, Docker, Jenkins, Ansible, Nexus combined Devops example task.

### Purpose
- The purpose of this project is studying and demonstration of abilities.

### What it does ?
#### Step 1
When you launch an AWS instance with the following user-data script;
- Installs git and ansible on the instance.
- Fetches ansible-playbook configuration desctiptions from github.
- Ansible-playbook configures, installs docker, pre-configured dockerized jenkins and sonatype nexus repository like this.

http://<aws-instance-ip>:8080 - jenkins
http://<aws-instance-ip>:8081 - nexus
user: admin
pass: admin123  (for both)

#### Step 2
- There is a preconfigured scripted build pipeline, if you run to build it.




#### Step 2


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
