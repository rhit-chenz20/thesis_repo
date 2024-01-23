#!/bin/bash
declare c=0
declare max=40
declare date='Jan23'
# current folder is slim_ibm
mkdir "../../thesis_result"
mkdir "../../thesis_result/data_set"
mkdir "../../thesis_result/data_set/${date}"


# jump-signal
for i in {1..50}
do
   let "c+=1"
   slim -d "filename='../../thesis_result/data_set/${date}/jump_signal_${i}'" -d "jump_enabled=1" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# jump-choosiness
for i in {1..50}
do
   let "c+=1"
   slim -d "filename='../../thesis_result/data_set/${date}/jump_choosiness_${i}'" -d "jump_enabled=1" -d "jump_trait='choosiness'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# stop mutation-signal
for i in {1..50}
do
   let "c+=1"
   slim -d "filename='../../thesis_result/data_set/${date}/stop_signal_${i}'" -d "stop_enabled=1" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# stop mutation-choosiness
for i in {1..50}
do
   let "c+=1"
   slim -d "filename='../../thesis_result/data_set/${date}/stop_choosiness_${i}'" -d "stop_enabled=1" -d "stop_trait='choosiness'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# basic
for i in {1..50}
do
   let "c+=1"
   slim -d "filename='../../thesis_result/data_set/${date}/basic_${i}'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done
