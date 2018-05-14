
#staring 5 machines for 2 hours in nancy starting now
export JOB_ID=`mcc job add nancy 5 for 2h now`

#wait for the machines to be allocated
mcc job wait $JOB_ID

#deploy the OS on all the target machines
export DEP_ID=`mcc dep add $JOB_ID`

#wait for the deployment to complete
mcc dep wait $DEP_ID

#install salt and antidote receipes from settings.yaml
mcc job install $JOB_ID salt

#create an alias file for direct ssh access
mcc alias list $JOB_ID > alias

