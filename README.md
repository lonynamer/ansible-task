## AWS, Docker, Jenkins, Ansible, Nexus combined Devops example task.

### Purpose
- The purpose of this project is studying and demonstration of abilities.

#### What it does ?
Step 1
---
When you launch an AWS instance with the following user-data script;
- Installs git and ansible on the instance. (Bash
- Fetches ansible-playbook configuration descriptions from github. (Git)
- Ansible-playbook configures, installs docker, pre-configured dockerized jenkins and sonatype nexus repository like this. (Ansible)

`First Time Credentials:`
- http://`aws-instance-ip`:8080  (jenkins)
- http://`aws-instance-ip`:8081  (nexus)
- user: admin
- pass: admin123  (for both)
---

`Files:`
- https://github.com/lonynamer/ansible-task/blob/master/ansible/docker-jenkins-nexus-install.yaml
- https://github.com/lonynamer/ansible-task/blob/master/ansible/ansible.cfg
- https://github.com/lonynamer/ansible-task/blob/master/ansible/hosts

Step 2 (Pipeline)
---
- There is a preconfigured task with scripted build pipeline from git, if you run to build it.
---
- Pipeline (single branch):
---
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




## Try It:
Step 1:
---
- Launch AWS instance minimum t2.medium instance 2 core 2 GB memory. (0.04 $ / hour) Less will not work.
- image: Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-027583e616ca104df amazon (works on this empty image)
- During the instance launch copy and paste the script below to Advanced/user-data section.
- AWS Security Group creation not included. Create one enable ports 22, 8080, 8081, 8082 
- Login to your new instance with `ubuntu` user and run.
- Even instance is launched, it will take time to build `build automation` environment in the background.
- Run a few times;
$ sudo cat /root/ansible-task/user-data.log
- Ensure that you see in the end `TASK_COMPLETED_OK` message. Wait till you see and environment is ready.
---

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

Step 2:
---
- Browse to Jenkins http://`aws-instance-ip`:8080  (jenkins)
- Run the build `ansible-task`
- In the end of successful pipeline run, production site will be ready, our application.
- Test if application working.
- http://`aws-instance-ip`:8082/time-tracker-web-0.3.1
- connect as ubuntu user, ensure that `time-tracker` container is running
- If docker command donot work reconnect again as ubuntu user to ssh.
$ docker ps
---
