
#staring 5 machines for 2 hours in nancy starting now
export JOB_ID=`mcc job add nancy 3 until 12h  now`

echo $JOB_ID > .jobid

#wait for the machines to be allocated
mcc job wait $JOB_ID

#deploy the OS on all the target machines
export DEP_ID=`mcc dep add $JOB_ID`
echo $DEP_ID > .depid

#wait for the deployment to complete
mcc dep wait $DEP_ID

#install salt and antidote receipes from settings.yaml
mcc job install $JOB_ID salt

#create an alias file for direct ssh access
mcc alias list $JOB_ID > alias

exit 0
