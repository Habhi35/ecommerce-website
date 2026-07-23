pipeline
    {
        agent any

        environment {
            SONARQUBE = credentials('sonarqube')
            ImageName = "mydockerhubusername/myimage:latest"
            ImageTag = "${BUILD_NUMBER}"
            container_name = "mycontainer"
        }


        stages{

            stage("checkout"){
                steps{
                    echo "checking the code from git"
                    git branch : "main", 
                        url : "https://github.com/Habhi35/CICDTAXIBOOKING.git"
                }
            }

            stage("Build"){
                steps{
                    echo "Builiding the maven project"
                    sh 'mvn clean install'
                }
            }

            stage("Test"){
                steps{
                    echo "Running the mvn test cases"
                    sh 'mvn test'
                }
            }

            stage("package"){
                steps{
                    echo "packaging the maven application"
                    sh 'mvn package'
                }
            }

            stage("artifacts"){
                steps{
                    archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true

                }
            }

            stage("Deploy"){
                steps{
                    echo "Deploying the application"
                    sh 'scp target/*.jar user@remote-server:/path/to/deploy'
                }
            }

            stage("sonar scan"){
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn sonar:sonar'
                }
            }

            stage("Docker Build"){
                steps{
                    echo "Builiding the docker image"
                    sh 'docker build -t myimage:latest .'
                }
            }

            stage("Docker Login"){
                steps{
                    echo "Logging into dockerhub"
                    sh 'docker login -u mydockerhubusername -p mydockerhubpassword'
                }
            }

            stage("Docker Push"){
                steps{
                    echo "Pushing the docker image to Docker Hub"
                    sh 'docker tag myimage:latest mydockerhubusername/myimage:latest'
                    sh 'docker push mydockerhubusername/myimage:latest'
                }
            }

            stage("Deploy Docker container"){
                steps{
                    echo "container deployment"
                    sh 'docker compose pull'
                    sh 'docker compose up -d'
                }
            }

        }
    }