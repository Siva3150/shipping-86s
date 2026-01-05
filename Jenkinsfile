@Library('jenkins-shared-library') _ 

def configMap = [

    project: "roboshop",
    component: "shipping"

]

// if branch is not equal to main, then run CI pipeline
if ( ! env.BRANCH_NAME.equalsIgnoreCase('main') ){
    javaEKSPipeline(configMap) // by default it will call, call function inside this pipeline

}

else{
 
 echo "Please follow the PROD process"

}