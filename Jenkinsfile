node('docker-host'){
  def mvnHome
  def customImage
  def dockerHome
  checkout scm
  stage('Preparation'){
    echo "Preparation"
    mvnHome = tool 'M3'
    dockerHome = tool 'docker-host'
  }
  stage('Create Package'){
    sh "${mvnHome}/bin/mvn -DskipTests package"
  }
  stage('Build Docker Image'){
  customImage = docker.build("lonyn/timetracker-image:${env.BUILD_ID}", ".")
  }
}
