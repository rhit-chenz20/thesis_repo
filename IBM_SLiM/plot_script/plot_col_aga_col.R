library(psych)
args <- commandArgs(trailingOnly = TRUE)
print(args)

fn <- args[1]
args <- args[-1]
pdf(paste0("plots/", fn, "_all.pdf"))

v1s <- c()
v2s <- c()
v3s <- c()
qs <- c()
v4s <- c()
v5s <- c()
ness <- c()
nefs <- c()

PlotMean <- function(x, meanMat, xmax, yrange, xlabel, ylabel, col, xaxp){
  plot(x=x, y=meanMat, xlim=c(0,xmax), 
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

means <- cbind(
  rowMeans(v1s),
               rowMeans(v2s),
               rowMeans(v3s), 
               rowMeans(qs), 
           rowMeans(v4s),
           rowMeans(v5s), 
           rowMeans(nefs) 
           ,rowMeans(ness)
           )
colnames(means) <- c("v1", "v2", "v3", "q", "v4", "v5", "nef", "nes")
# colnames(means) <- c("v3", "q", "v5", "nef", "nes")

pairs(means, panel=panel.smooth)
# box()

pdf(paste0("plots/", fn, "_used_var.pdf"))

means <- cbind(
  # rowMeans(v1s),
  # rowMeans(v2s),
  rowMeans(v3s), 
  rowMeans(qs), 
  # rowMeans(v4s),
  rowMeans(v5s), 
  rowMeans(nefs) 
  ,rowMeans(ness)
)
colnames(means) <- c("v3", "q", "v5", "nef", "nes")
pairs(means, panel=panel.smooth)
# box()

