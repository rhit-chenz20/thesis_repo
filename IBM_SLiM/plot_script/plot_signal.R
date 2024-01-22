args <- commandArgs(trailingOnly = TRUE)
print(args)

pdf(paste0("plots/", args[1], ".pdf"))
args <- args[-1]

v1s <- c()
v2s <- c()
v3s <- c()
qs <- c()
v4s <- c()
v5s <- c()
nes <- c()

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

PlotData <- function(x, df, xrange, yrange, xlabel, ylabel, col_mean, col_sd, xaxp){
  mean <-rowMeans(df)
  sd <- apply(df, 1, sd, na.rm=TRUE)
  PlotMean(x, mean, xrange, yrange, xlabel, ylabel, col_mean, xaxp)
  PlotSD(x, mean+sd, mean-sd, col_sd)
}

if(length(args) == 0){
  v1s <- read.csv("v1s.csv", header = FALSE)
  v2s <- read.csv("v2s.csv", header = FALSE)
  v3s <- read.csv("v3s.csv", header = FALSE)
  qs <- read.csv("qs.csv", header = FALSE)
  v4s <- read.csv("v4s.csv", header = FALSE)
  v5s <- read.csv("v5s.csv", header = FALSE)
  ness <- read.csv("ness.csv", header = FALSE)
  nefs <- read.csv("nefs.csv", header = FALSE)
}else{
  i <- 1
  for(suffix in args){
    # suffix <- paste("csv_result/",suffix, sep="")
    if(length(v1s) == 0){
      v1s <- read.csv(paste(suffix,"v1s.csv", sep = ""), header = FALSE)
      v2s <- read.csv(paste(suffix,"v2s.csv", sep = ""), header = FALSE)
      v3s <- read.csv(paste(suffix,"v3s.csv", sep = ""), header = FALSE)
      qs <- read.csv(paste(suffix,"qs.csv", sep = ""), header = FALSE)
      v4s <- read.csv(paste(suffix,"v4s.csv", sep = ""), header = FALSE)
      v5s <- read.csv(paste(suffix,"v5s.csv", sep = ""), header = FALSE)
      ness <- read.csv(paste(suffix,"ness.csv", sep = ""), header = FALSE)
      nefs <- read.csv(paste(suffix,"nefs.csv", sep = ""), header = FALSE)
    }
    i<-i+1
  }
}

x <- (1:length(v1s$V1)) * 5
# ymax <- max(v1s, v2s, v3s, qs, v4s, v5s)
yrange <- c(-0.007, 0.021)
# par(mfrow=c(2,3), mar=c(4.0, 4.0, 1.5, 1.5))
xmax<- 12000
xrange <- c(5800,7000)
ticks<-c(0, 12000, 4)


signals <- rowMeans(qs*v3s+1)
selection <- rowMeans(signals*v5s+1)

# signals <- as.data.frame(lapply(signals, function(x) x - mean(x)))
# selection <- as.data.frame(lapply(selection, function(x) x - mean(x)))

# PlotData(x, signals, xmax, yrange, "", "signal", "red", 
#          adjustcolor("salmon", alpha.f = 0.20),ticks)

plot(x=x, y=selection, xlim=xrange, ylim=c(0,1300),
     type="l",xlab="Generation", ylab="", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="salmon", lwd=2, xaxp=ticks)

lines(x, signals, col="green")

lines(x, rowMeans(nefs), col="maroon1")
# lines(x, rowMeans(ness), col="aquamarine3")

# lines(x, rowMeans(v3s), col="blue")
# lines(x, rowMeans(qs), col="purple")
# lines(x, rowMeans(v5s), col="orange")

legend("topright",           # Legend position
       legend = c("selection", "signal", "Ne_family size"),  # Legend labels
       col = c("red", "green", "maroon1"),    # Colors
       pch = 1) 

# PlotData(x, selection, xmax, yrange, "", "selection", "green", 
#          adjustcolor("lightgreen", alpha.f = 0.50), ticks)

# PlotData(x, nefs, xrange, c(0,600), "", "Nef value", "maroon1",
#          adjustcolor("mistyrose", alpha.f = 0.50), ticks)

# PlotData(x, ness, xrange, yrange, "", "Nes value", "aquamarine3",
#          adjustcolor("aquamarine", alpha.f = 0.50), ticks)

PlotData(x, v3s, xrange, yrange, "Generation", "", "blue",
         adjustcolor("lightblue", alpha.f = 0.50), ticks)
# lines(x, rowMeans(v3s), col="blue")
lines(x, rowMeans(qs), col="purple")
lines(x, rowMeans(v5s), col="orange")

legend("topright",           # Legend position
       legend = c("v3", "q", "v5"),  # Legend labels
       col = c("blue", "purple", "orange"),    # Colors
       pch = 1) 
# PlotData(x, qs, xrange, yrange, "Generation", "q value", "purple",
#          adjustcolor("mediumpurple1", alpha.f = 0.10), ticks)
# 
# PlotData(x, v5s, xrange, yrange, "Generation", "v5 value", "orange",
#          adjustcolor("navajowhite", alpha.f = 0.50), ticks)


box()

