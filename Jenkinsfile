node{
  def mvnHome
  stage('Preparation'){
    echo "Preparation"
    mvnHome = tool 'M3'
  }
  stage('Create Package'){
    sh "${mvnHome}/bin/mvn -DskipTests - f pom.file package"
  }
}
