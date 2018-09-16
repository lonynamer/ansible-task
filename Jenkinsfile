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
  stage('Publish'){
  sh "ansible --version"
  }
}
