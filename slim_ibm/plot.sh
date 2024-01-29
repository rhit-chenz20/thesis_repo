#!/bin/bash

declare date='Jan28'
declare outputpath="plots/${date}"
mkdir "plots/${date}"

# # plot signal stop
# Rscript plot_script/plot_col_aga_col.R ${outputpath}/stop_signal_col ../../thesis_result/data_set/${date}/stop_signal_*.csv
# Rscript plot_script/plot_signal.R ${outputpath}/stop_signal_signal ../../thesis_result/data_set/${date}/stop_signal_*.csv
# Rscript plot_script/plot_simple_values.R ${outputpath}/stop_signal_vars ../../thesis_result/data_set/${date}/stop_signal_*.csv

# # plot choosiness stop
# Rscript plot_script/plot_col_aga_col.R ${outputpath}/stop_choosiness_col ../../thesis_result/data_set/${date}/stop_choosiness_*.csv
# Rscript plot_script/plot_signal.R ${outputpath}/stop_choosiness_signal ../../thesis_result/data_set/${date}/stop_choosiness_*.csv
# Rscript plot_script/plot_simple_values.R ${outputpath}/stop_choosiness_vars ../../thesis_result/data_set/${date}/stop_choosiness_*.csv

# # plot signal jump
# Rscript plot_script/plot_col_aga_col.R ${outputpath}/jump_signal_col ../../thesis_result/data_set/${date}/jump_signal_*.csv
# Rscript plot_script/plot_signal.R ${outputpath}/jump_signal_signal ../../thesis_result/data_set/${date}/jump_signal_*.csv
# Rscript plot_script/plot_simple_values.R ${outputpath}/jump_signal_vars ../../thesis_result/data_set/${date}/jump_signal_*.csv

# # plot choosiness jump
# Rscript plot_script/plot_col_aga_col.R ${outputpath}/jump_choosiness_col ../../thesis_result/data_set/${date}/jump_choosiness_*.csv
# Rscript plot_script/plot_signal.R ${outputpath}/jump_choosiness_signal ../../thesis_result/data_set/${date}/jump_choosiness_*.csv
# Rscript plot_script/plot_simple_values.R ${outputpath}/jump_choosiness_vars ../../thesis_result/data_set/${date}/jump_choosiness_*.csv

# plot basic
Rscript plot_script/plot_col_aga_col.R ${outputpath}/basic_col ../../thesis_result/data_set/${date}/basic_*.csv
Rscript plot_script/plot_signal.R ${outputpath}/basic_signal ../../thesis_result/data_set/${date}/basic_*.csv
Rscript plot_script/plot_simple_values.R ${outputpath}/basic_vars ../../thesis_result/data_set/${date}/basic_*.csv




# Rscript plot_script/plot_col_aga_col.R test csv_result/test_run/test.csv

# Rscript plot_script/plot_signal.R test_signal csv_result/test_run/test.csv