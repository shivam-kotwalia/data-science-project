#Get the first argument passed to the Script
PID=$1
#Change below to you Assingment name & number
echo "Assingment Number"

#This tells the PID which is entered
echo "The entered PID :" $PID

#This command calculate the child of the supplied pid
PCHILD=`ps -o ppid= -o pid= -A | awk '$1 == "'"$PID"'"{print $2}'`

#This prints all the child of the pid
echo "The Child processes are "$PCHILD

#Get Parent of the PID 
PARENT1=`ps -o ppid= -p $PID`
PARENT2=`ps -o ppid= -p $PARENT1`
PARENT3=`ps -o ppid= -p $PARENT2`

#This adds the supplied Pid with child and parent PID
PCHILD="$PARENT3 $PARENT2 $PARENT1 $PID $PCHILD"

#looping over the PCHID variable
for P in $PCHILD;
do 
	#This command will give the name of the process for the PID 
	PROCESS_NAME=`ps -p $P -o comm=`

	echo "The process name for "$P" is "$PROCESS_NAME"."
	#echo "The Network Connection for $P are"
	#lsof -i -a -p $P
	#echo "Second Method of getting Network connection "
	#ss -nap | grep $P
	#echo "Third Method"
	#netstat -p | grep $P
	#echo "For just TCP"
	
	#this command will check for Network connection
	netstat -tp $P
done
