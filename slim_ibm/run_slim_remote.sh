#!/bin/bash
declare c=0
declare max=60

# jump-signal
for i in {1..50}
do
   let "c+=1"
   slim -d "filename='csv_result/data_set/jump_signal_${i}.csv'" -d "jump_enabled=1" model.slim &
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
   slim -d "filename='csv_result/data_set/jump_choosiness_${i}.csv'" -d "jump_enabled=1" -d "jump_trait='choosiness'" model.slim &
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
   slim -d "filename='csv_result/data_set/stop_signal_${i}.csv'" -d "stop_enabled=1" model.slim &
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
   slim -d "filename='csv_result/data_set/stop_choosiness_${i}.csv'" -d "stop_enabled=1" -d "stop_trait='choosiness'" model.slim &
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
   slim -d "filename='csv_result/data_set/basic_${i}.csv'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done
