//conditional params test
pipeline {
 agent any

 parameters {
    choice(
        choices: ['apply' , 'destroy'],
        description: 'Deploy/change or destroy TF assets',
        name: 'REQUESTED_ACTION')
}
 
 stages {
 stage('checkout') {
 steps {
 git branch: 'master', url: 'https://github.com/clarksm/ephemeral-instance-test.git'
 
 }
 }

 stage('Build') {
 steps {
    dir('train-app')
    {
    echo 'Running build automation'
    sh './gradlew build --no-daemon'
    archiveArtifacts artifacts: 'dist/trainSchedule.zip'
    }
    }
}
 
 stage('Infrastructure Apply') {
 
 when {
    // Apply TF infrastructure
    expression { params.REQUESTED_ACTION == 'apply' }
}
 steps {

 sh 'terraform init'
 sh 'terraform plan -out=plan'
 sh 'terraform apply plan'
 //create host files
 sh 'echo "[dev]" > ./hosts/devhosts.txt'
 sh 'echo "[prod]" > ./hosts/prodhosts.txt'
 //populate instance ips by tag
 sh 'aws ec2 describe-instances --query "Reservations[*].Instances[*].[PublicIpAddress]" --filters "Name=instance-state-name,Values=running,Name=tag:Environment,Values=Dev" --output=text > ./hosts/devstage.txt'
 //filter out shutdown instances
 sh 'grep -v "None" ./hosts/devstage.txt >> ./hosts/devhosts.txt'
 sh 'aws ec2 describe-instances --query "Reservations[*].Instances[*].[PublicIpAddress]" --filters "Name=instance-state-name,Values=running,Name=tag:Environment,Values=Prod" --output=text > ./hosts/prodstage.txt'
 sh 'grep -v "None" ./hosts/prodstage.txt >> ./hosts/prodhosts.txt'
 //sh 'aws ec2 describe-instances --filter "Name=instance-state-name,Values=running,Name=tag:Environment,Values=Prod" --query "Reservations[].Instances[].[PublicIpAddress]" --output=text > ../../../hosts/prodhosts.txt'
 
 }
 }

stage('Infrastructure Configure') {
 
 when {
    // Destroy TF infrastructure
    expression { params.REQUESTED_ACTION == 'apply' }
}
 steps {
 sh 'sleep 20s'
 sh 'ansible-playbook -i ./hosts/devhosts.txt devplaybook.yml -vvv'
 sh 'ansible-playbook -i ./hosts/prodhosts.txt prodplaybook.yml -vvv'
 
 }
 }

stage('Infrastructure Destroy') {
 
 when {
    // Destroy TF infrastructure
    expression { params.REQUESTED_ACTION == 'destroy' }
}
 steps {
 sh 'terraform destroy -auto-approve'
 
 }
 }

 }
}
