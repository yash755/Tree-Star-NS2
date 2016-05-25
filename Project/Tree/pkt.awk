BEGIN {
number_of_drops=0;
number_of_received=0;
number_of_enqued=0;
number_of_dequeue=0;
}
{
parameter1=$1
paramter2=$2
parameter3=$3
parameter4=$4
parameter5=$5
parameter6=$6
parameter8=$8
parameter9=$9
parameter10=$10
parameter11=$11
parameter12=$12
if (parameter1=="r")
number_of_received++;
if(paramter1=="-")
number_of_dequeue++;
if(parameter1=="d")
number_of_drops++;
if(parameter1=="+")
number_of_enqued++;
}
END {
printf("number of received:%d\nnumber of dequeue:%d\n",number_of_received,number_of_dequeue);
printf("\nnumber of drops:%d\nnumber of enqued:%d",number_of_drops,number_of_enqued);
}
