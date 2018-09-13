node{
  def mvnHome
  stage('Preparation'){
    echo "Preparation"
    def mvnHome = tools M3
  }
  stage('Create Package'){
    ${mvnHome}/bin mvn -D skipTests package
  }
}
