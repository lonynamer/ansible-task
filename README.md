## AWS, Docker, Jenkins, Ansible, Nexus combined Devops example task.

### Purpose
- The purpose of this project is studying and demonstration of abilities.

### What it does ?
#### Step 1
---
When you launch an AWS instance with the following user-data script;
- Installs git and ansible on the instance. (Bash
- Fetches ansible-playbook configuration descriptions from github. (Git)
- Ansible-playbook configures, installs docker, pre-configured dockerized jenkins and sonatype nexus repository like this. (Ansible)

http://<aws-instance-ip>:8080 - jenkins
http://<aws-instance-ip>:8081 - nexus
user: admin
pass: admin123  (for both)
---
`Files:`
- https://github.com/lonynamer/ansible-task/blob/master/ansible/docker-jenkins-nexus-install.yaml
- https://github.com/lonynamer/ansible-task/blob/master/ansible/ansible.cfg
- https://github.com/lonynamer/ansible-task/blob/master/ansible/hosts

#### Step 2 (Pipeline)
---
- There is a preconfigured task with scripted build pipeline from git, if you run to build it.
- Pipeline: 
          - All the pipeline runs on docker jnlp slave and they are deleted in the end.  
          - Jenkins itself do not run anything on itself, only launches the pipeline.
          - Jenkins launches docker slave, on slave does scm checkout which is git.
          - mvn and docker tools installed on docker jnlp slave (launch docker jnlp-slave)
          - mvn builds the sample java application (mvn build)
          - docker builds a tomcat image with our builded application injected. (docker build)
          - deletes the old container in the production. (de-publish)
          - runs the newly builded container with our code. (publish)
---

`Files:`
- https://github.com/lonynamer/ansible-task/blob/master/Jenkinsfile
- https://github.com/lonynamer/ansible-task/blob/master/Dockerfile








`user-data script`
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
