node{
  def mvnHome
  checkout scm
  stage('Preparation'){
    echo "Preparation"
    mvnHome = tool 'M3'
    
  }
  stage('Create Package'){
    sh "${mvnHome}/bin/mvn -DskipTests package"
  }
}
