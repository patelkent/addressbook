pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    environment{
        BUILD_SERVER_IP='ec2-user@172.31.46.107'
    }
  parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'Env to Deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'Decide to run TC')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3','1.4'], description: 'Pick something')
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                git 'https://github.com/patelkent/addressbook.git'
                sh "mvn compile"
                echo "Env to Deploy: ${params.Env}"
            }
            
            }
            stage('UnitTest') {
                agent any
                when{
                    expression{
                        params.executeTests==true
                    }                    
                }
                  steps {
                    sh "mvn test"
            }
            
            }
            stage('package') {
                //agent {label 'slave1'}
                // when{
                //     expression{
                //         BRANCH_NAME = 'dev' || BRANCH_NAME = 'developk'
                //     }
                // }
                
    // some block
                agent any
                  steps {      
                    script {
                        sshagent(['build-server']) {
                            echo "packaging the code on new slave2"
                            sh "scp -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                            sh "ssh ${BUILD_SERVER_IP} 'bash ~/server-config.sh'"
                            //echo "deploying app version: ${params.APPVERSION}"
                    }  
                    
                     }            
                }
            }
            stage('Deploy'){
                agent {label 'slave1'}
                input{
                        message 'Please approve the deployment'
                        ok "yes, to deploy"
                        parameters{
                            choice(name: 'NEWVERSION', choices: ['1.1', '1.2', '1.3','1.4'])
                            }
                        }
                steps{
                    echo "Deploying to Test"
                    }                    
                }
            }
        }
    
