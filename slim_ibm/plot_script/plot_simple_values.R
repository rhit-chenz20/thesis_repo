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
PlotMean <- function(x, meanMat, xrange, yrange, xlabel, ylabel, col, xaxp){
  plot(x=x, y=meanMat, xlim=xrange, 
       # ylim = yrange, 
       type="l",xlab=xlabel, ylab=ylabel, cex.axis=0.95, cex.lab=1.2,
       mgp=c(2.5, 0.7, 0), col=col, lwd=2, xaxp=xaxp)
}
PlotSD <- function(x, psd, nsd, col, border_enabled = FALSE){
  if(border_enabled){
    lines(x, psd)
    lines(x, nsd)
  }
  polygon(x=c(x, rev(x)), y=c(psd, rev(nsd)), col=col, border = NA)
}

PlotData <- function(x, df, xmax, yrange, xlabel, ylabel, col_mean, col_sd, xaxp){
  mean <-rowMeans(df)
  sd <- apply(df, 1, sd, na.rm=TRUE)
  PlotMean(x, mean, xmax, yrange, xlabel, ylabel, col_mean, xaxp)
  PlotSD(x, mean+sd, mean-sd, col_sd)
}

pdf(paste0("plots/", fn, ".pdf"))

yrange <- c(-0.007, 0.021)
par(mfrow=c(2,2), mar=c(4.0, 4.0, 1.5, 1.5))
xrange <- c(3000, 15000)
ticks<-c(3000, 15000, 4)

df_mean <- aggregate(. ~ generation, data = df, FUN = mean)
df_sd <- aggregate(. ~ generation, data = df, FUN = sd)

plot(x=df_mean$generation, y=df_mean$v3, xlim=xrange, 
     # ylim = yrange, 
     type="l",xlab="generation", ylab="v3", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="blue", lwd=2, xaxp=ticks)

polygon(x=c(df_mean$generation, rev(df_mean$generation)), y=c(df_mean$v3 + df_sd$v3, rev(df_mean$v3 - df_sd$v3)), col=adjustcolor("lightblue", alpha.f = 0.50), border = NA)


plot(x=df_mean$generation, y=df_mean$q, xlim=xrange, 
     # ylim = yrange, 
     type="l",xlab="generation", ylab="q", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="purple", lwd=2, xaxp=ticks)
polygon(x=c(df_mean$generation, rev(df_mean$generation)), y=c(df_mean$q + df_sd$q, rev(df_mean$q - df_sd$q)), col=adjustcolor("mediumpurple1", alpha.f = 0.10), border = NA)


plot(x=df_mean$generation, y=df_mean$v5, xlim=xrange, 
     # ylim = yrange, 
     type="l",xlab="generation", ylab="v5", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="orange", lwd=2, xaxp=ticks)
polygon(x=c(df_mean$generation, rev(df_mean$generation)), y=c(df_mean$v5 + df_sd$v5, rev(df_mean$v5 - df_sd$v5)), col=adjustcolor("navajowhite", alpha.f = 0.50), border = NA)


plot(x=df_mean$generation, y=df_mean$nef, xlim=xrange, 
     # ylim = yrange, 
     type="l",xlab="generation", ylab="nef", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="maroon1", lwd=2, xaxp=ticks)

polygon(x=c(df_mean$generation, rev(df_mean$generation)), y=c(df_mean$nef + df_sd$nef, rev(df_mean$nef - df_sd$nef)), col=adjustcolor("mistyrose", alpha.f = 0.50), border = NA)








# PlotData(x, v1s, xmax, yrange, "", "v1 value", "red", 
#          adjustcolor("salmon", alpha.f = 0.20),ticks)
# PlotData(x, v2s, xmax, yrange, "", "v2 value", "green", 
#          adjustcolor("lightgreen", alpha.f = 0.50), ticks)
# PlotData(df$generation, df$v3, xrange, yrange, "", "v3 value", "blue", 
#          adjustcolor("lightblue", alpha.f = 0.50), ticks)
# PlotData(df$generation, df$q, xrange, yrange, "", "q value", "purple", 
#          adjustcolor("mediumpurple1", alpha.f = 0.10), ticks)
# PlotData(df$generation, df$v5, xrange, yrange, "Generation", "v5 value", "orange",
#          adjustcolor("navajowhite", alpha.f = 0.50), ticks)
# PlotData(df$generation, df$nef, xrange, yrange, "Generation", "Nef value", "maroon1",
#          adjustcolor("mistyrose", alpha.f = 0.50), ticks)
# PlotData(df$generation, df$nes, xrange, yrange, "Generation", "Nes value", "green", 
#         adjustcolor("lightgreen", alpha.f = 0.50), ticks)
box()

dev.off()