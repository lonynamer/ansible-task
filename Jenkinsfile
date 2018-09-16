node('docker-host'){
  def mvnHome
//  def customImage
  def dockerHome
  checkout scm
  stage('Preparation'){
    sh "id"
    sh "whoami"
    echo "Preparation"
    mvnHome = tool 'M3'
    dockerHome = tool 'docker-tools'
    //PATH="${mvnHome}:${dockerHome}:${PATH}"
  }
  stage('Create Package'){
    sh "${mvnHome}/bin/mvn -DskipTests package"
  }
  stage('Build Docker Image'){
    sh "${dockerHome}/bin/docker build -t lonynamer/time-tracker ."
  //customImage = docker.build("lonyn/timetracker-image:${env.BUILD_ID}", ".")
  }
  stage('DePublish'){
  sh "${dockerHome}/bin/docker ps | grep 'time-tracker' && ${dockerHome}/bin/docker rm time-tracker"
  }
  stage('Publish'){
  sh "${dockerHome}/bin/docker run --rm -d --name time-tracker -p 8082:8080 lonynamer/time-tracker"
  }
}
