library(psych)
args <- commandArgs(trailingOnly = TRUE)
print(args)

fn <- args[1]
args <- args[-1]
df <- data.frame()

if(length(args) == 0){
  df <- read.csv("csv_result/test_run/test.csv")
}else{
  for(filename in args){
    df <- rbind(df, read.csv(filename))
  }
}

pdf(paste0("plots/", fn, "_all.pdf"))
df_mean <- aggregate(. ~ generation, data = df, FUN = mean)
pairs(df_mean, panel=panel.smooth)
dev.off()

pdf(paste0("plots/", fn, "_used_var.pdf"))
df_var_mean <- aggregate(cbind(v3, q, v5, nef, nes) ~ generation, data = df, FUN = mean)
pairs(df_var_mean, panel=panel.smooth)
dev.off()