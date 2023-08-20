pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
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
                sshagent(['build-server']) {
    // some block

                  steps {        
                    sh "mvn package"
                    echo "deploying app version: ${params.APPVERSION}"
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
    
