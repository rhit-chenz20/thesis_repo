args <- commandArgs(trailingOnly = TRUE)
print(args)

v1s <- c()
v2s <- c()
v3s <- c()
qs <- c()
v4s <- c()
v5s <- c()


PlotMean <- function(x, meanMat, xmax, yrange, xlabel, ylabel, col, xaxp){
  plot(x=x, y=meanMat, xlim=c(0,xmax), ylim = yrange, type="l",
       xlab=xlabel, ylab=ylabel, cex.axis=0.95, cex.lab=1.2,
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

if(length(args) == 0){
  v1s <- read.csv("v1s.csv", header = FALSE)
  v2s <- read.csv("v2s.csv", header = FALSE)
  v3s <- read.csv("v3s.csv", header = FALSE)
  qs <- read.csv("qs.csv", header = FALSE)
  v4s <- read.csv("v4s.csv", header = FALSE)
  v5s <- read.csv("v5s.csv", header = FALSE)
}else{
  i <- 1
  for(suffix in args){
    if(length(v1s) == 0){
      v1s <- read.csv(paste(suffix,"v1s.csv", sep = ""), header = FALSE)
      v2s <- read.csv(paste(suffix,"v2s.csv", sep = ""), header = FALSE)
      v3s <- read.csv(paste(suffix,"v3s.csv", sep = ""), header = FALSE)
      qs <- read.csv(paste(suffix,"qs.csv", sep = ""), header = FALSE)
      v4s <- read.csv(paste(suffix,"v4s.csv", sep = ""), header = FALSE)
      v5s <- read.csv(paste(suffix,"v5s.csv", sep = ""), header = FALSE)
    }else {
      col_name <- paste("V", i, sep = "")
      v1s <- cbind(v1s,col_name= read.csv(paste(suffix,"v1s.csv", sep = ""), header = FALSE))
      v2s <- cbind(v2s,col_name= read.csv(paste(suffix, "v2s.csv", sep = ""), header = FALSE))
      v3s <- cbind(v3s,col_name= read.csv(paste(suffix, "v3s.csv", sep = ""), header = FALSE))
      qs <- cbind(qs,col_name= read.csv(paste(suffix, "qs.csv", sep = ""), header = FALSE))
      v4s <- cbind(v4s,col_name= read.csv(paste(suffix, "v4s.csv", sep = ""), header = FALSE))
      v5s <- cbind(v5s,col_name= read.csv(paste(suffix, "v5s.csv", sep = ""), header = FALSE))
    }
    i<-i+1
  }
}

x <- (1:length(v1s$V1)) * 5
# ymax <- max(v1s, v2s, v3s, qs, v4s, v5s)
yrange <- c(-0.007, 0.021)
par(mfrow=c(2,3), mar=c(4.0, 4.0, 1.5, 1.5))
xmax<- 12000
ticks<-c(0, 12000, 4)

PlotData(x, v1s, xmax, yrange, "", "v1 value", "red", 
         adjustcolor("salmon", alpha.f = 0.20),ticks)
PlotData(x, v2s, xmax, yrange, "", "v2 value", "green", 
         adjustcolor("lightgreen", alpha.f = 0.50), ticks)
PlotData(x, v3s, xmax, yrange, "", "v3 value", "blue", 
         adjustcolor("lightblue", alpha.f = 0.50), ticks)
PlotData(x, qs, xmax, yrange, "Generation", "q value", "purple", 
         adjustcolor("mediumpurple1", alpha.f = 0.10), ticks)
PlotData(x, v4s, xmax, yrange, "Generation", "v4 value", "maroon1", 
         adjustcolor("mistyrose", alpha.f = 0.50), ticks)
PlotData(x, v5s, xmax, yrange, "Generation", "v5 value", "orange", 
         adjustcolor("navajowhite", alpha.f = 0.50), ticks)

box()
# dev.off()