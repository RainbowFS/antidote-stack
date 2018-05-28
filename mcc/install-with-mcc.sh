
#staring 5 machines for 2 hours in nancy starting now
export JOB_ID=`mcc job add nancy 8 for 2h  now`

echo $JOB_ID > .jobid

echo "job creation: "
#wait for the machines to be allocated
mcc job wait $JOB_ID

echo "**************"

#deploy the OS on all the target machines
export DEP_ID=`mcc dep add $JOB_ID`
echo $DEP_ID > .depid

echo "deployment creation: "
#wait for the deployment to complete
mcc dep wait $DEP_ID
echo "**************"

echo "nodes installation: "
#install salt and antidote receipes from settings.yaml
mcc job install $JOB_ID salt

#create an alias file for direct ssh access
mcc alias list $JOB_ID > alias

exit 0
