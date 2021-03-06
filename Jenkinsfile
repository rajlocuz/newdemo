pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.11.13"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('terraform-0.11.13')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    stages {
            stage('TerraformInit'){
            steps {
                dir('.'){
                    sh "terraform init -input=false"
                }
            }
        }

        stage('TerraformFormat'){
            steps {
                dir('.'){
                    sh "terraform fmt"
                }
            }
        }

        stage('TerraformValidate'){
            steps {
                dir('.'){
                    sh "terraform validate"
                }
            }
        }

        stage('TerraformPlan'){
            steps {
                dir('.'){
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                        sh "echo $AWS_ACCESS_KEY_ID"
                        sh "echo $AWS_SECRET_ACCESS_KEY"
                        sh "terraform plan -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' \
                        -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
                }
            }
        }
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('.'){
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan'
                        }
                    }
                }
            }
        }
    }
}
