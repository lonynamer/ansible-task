node{
  def mvnHome
  stage('Preparation'){
    echo "Preparation"
    def mvnHome = tools M3
  }
  stage('Create Package'){
    sh "${mvnHome}/bin mvn -DskipTests package"
  }
}
