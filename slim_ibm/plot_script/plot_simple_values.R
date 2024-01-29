args <- commandArgs(trailingOnly = TRUE)
# print(args)

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
pdf(paste0(fn, ".pdf"))

yrange <- c(-0.007, 0.021)
par(mfrow=c(2,2), mar=c(4.0, 4.0, 1.5, 1.5))
xrange <- c(0, 16000)
ticks<-c(0, 16000, 16)

df_mean <- aggregate(. ~ generation, data = df, FUN = mean)
df_sd <- aggregate(. ~ generation, data = df, FUN = sd)

plot(x=df_mean$generation, y=df_mean$v3, xlim=xrange, 
     # ylim = yrange, 
     type="l",xlab="generation", ylab="v3", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="blue", lwd=2, xaxp=ticks)

polygon(x=c(df_mean$generation, rev(df_mean$generation)), 
        y=c(df_mean$v3 + df_sd$v3, rev(df_mean$v3 - df_sd$v3)), 
        col=adjustcolor("lightblue", alpha.f = 0.50), border = NA)


plot(x=df_mean$generation, y=df_mean$q, xlim=xrange,
     # ylim = yrange,
     type="l",xlab="generation", ylab="q", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="purple", lwd=2, xaxp=ticks)
polygon(x=c(df_mean$generation, rev(df_mean$generation)),
        y=c(df_mean$q + df_sd$q, rev(df_mean$q - df_sd$q)),
        col=adjustcolor("mediumpurple1", alpha.f = 0.10), border = NA)
# 
# 
plot(x=df_mean$generation, y=df_mean$v5, xlim=xrange,
     # ylim = yrange,
     type="l",xlab="generation", ylab="v5", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="orange", lwd=2, xaxp=ticks)
polygon(x=c(df_mean$generation, rev(df_mean$generation)),
        y=c(df_mean$v5 + df_sd$v5, rev(df_mean$v5 - df_sd$v5)),
        col=adjustcolor("navajowhite", alpha.f = 0.50), border = NA)
# 
# 
plot(x=df_mean$generation, y=df_mean$nef, xlim=xrange,
     # ylim = yrange,
     type="l",xlab="generation", ylab="nef", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="maroon1", lwd=2, xaxp=ticks)

polygon(x=c(df_mean$generation, rev(df_mean$generation)),
        y=c(df_mean$nef + df_sd$nef, rev(df_mean$nef - df_sd$nef)),
        col=adjustcolor("mistyrose", alpha.f = 0.50), border = NA)

box()

dev.off()