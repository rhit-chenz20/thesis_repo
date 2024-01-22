#!/bin/bash
declare c=0
declare max=40


# basic
for i in {1..100}
do
   let "c+=1"
   /work/williarj/2223_balancing_selection/slimexe -d "suffix='csv_result/data_set/basic_${i}_'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# jump-signal
for i in {1..100}
do
   let "c+=1"
   /work/williarj/2223_balancing_selection/slimexe -d "suffix='csv_result/data_set/jump_signal_${i}_'" -d "jump_enabled=1" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# jump-choosiness
for i in {1..100}
do
   let "c+=1"
   /work/williarj/2223_balancing_selection/slimexe -d "suffix='csv_result/data_set/jump_choosiness_${i}_'" -d "jump_enabled=1" -d "jump_trait='choosiness'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# stop mutation-signal
for i in {1..100}
do
   let "c+=1"
   /work/williarj/2223_balancing_selection/slimexe -d "suffix='csv_result/data_set/stop_signal_${i}_'" -d "stop_enabled=1" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# stop mutation-choosiness
for i in {1..100}
do
   let "c+=1"
   /work/williarj/2223_balancing_selection/slimexe -d "suffix='csv_result/data_set/stop_choosiness_${i}_'" -d "stop_enabled=1" -d "stop_trait='choosiness'" model.slim &
   if ((c>$max))
   then
      wait
      let "c=0"
   fi
done

# Rscript csv_result/plot.R csv_result/*_ 
