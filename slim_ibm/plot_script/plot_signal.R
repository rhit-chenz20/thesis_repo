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

signals <- cbind(df$generation, df$v3 * df$q + 1)
colnames(signals)<-c("generation","signal")

selection <- cbind(df$generation, (df$v3 * df$q + 1) * df$v5 + 1)
colnames(selection)<-c("generation","selection_strength")

signals_mean <- aggregate(signal ~ generation, signals, mean)
colnames(signals_mean)<-c("generation","signal")

selection_mean <- aggregate(selection_strength ~ generation, selection, mean)
colnames(selection_mean)<-c("generation","selection_strength")

signals_sd <- aggregate(signal ~ generation, signals, sd)
colnames(signals_sd)<-c("generation","signal")

selection_sd <- aggregate(selection_strength ~ generation, selection, sd)
colnames(selection_sd)<-c("generation","selection_strength")

norm_signal <- signals_mean
norm_signal$signal <- norm_signal$signal - mean(norm_signal$signal)

norm_selection <- selection_mean
norm_selection$selection_strength <- norm_selection$selection_strength - mean(norm_selection$selection_strength)

pdf(paste0("plots/", fn, ".pdf"))

xrange <- c(0,1000)
xaxp<- c(0, 1000, 4)
par(mfrow=c(2,1), mar=c(4.0, 4.0, 1.5, 1.5))

sd_y_1 <- c(signals_mean$signal + signals_sd$signal, rev(signals_mean$signal - signals_sd$signal))
sd_unlist <- unlist(sd_y_1)
yrange <- c(min(sd_y_1), max(sd_y_1))
yrange <- c(0,1500)

plot(x=selection_mean$generation, y=selection_mean$selection_strength, xlim=xrange, 
     ylim = yrange,
     type="l",xlab="Generation", ylab="value", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="red", lwd=2, xaxp=xaxp)

# polygon(x=c(signals_mean$generation, rev(signals_mean$generation)), 
#         y=sd_y_1, 
#         col=adjustcolor("salmon", alpha.f = 0.20), border = NA)

sd_y_2 <- c(selection_mean$selection_strength + selection_sd$selection_strength, rev(selection_mean$selection_strength - selection_sd$selection_strength))
sd_unlist <- unlist(sd_y_2)
yrange <- c(min(sd_y_2), max(sd_y_2))

lines(signals_mean$generation, signals_mean$signal, col="green")

# plot(x=selection_mean$generation, y=selection_mean$selection_strength, xlim=xrange, 
#      ylim = yrange,
#      type="l",xlab="Generation", ylab="choosiness", cex.axis=0.95, cex.lab=1.2,
#      mgp=c(2.5, 0.7, 0), col="green", lwd=2, xaxp=xaxp)

# polygon(x=c(selection_mean$generation, rev(selection_mean$generation)), 
#         y=sd_y_2, 
#         col=adjustcolor("lightgreen", alpha.f = 0.20), border = NA)

legend("topright",           # Legend position
              legend = c("choosiness", "signal"),  # Legend labels
              col = c("red", "green"),    # Colors
              pch = 1)

xrange <- c(8800,9500)
plot(x=signals_mean$generation, y=signals_mean$signal, xlim=xrange, 
     # ylim = yrange,
     type="l",xlab="Generation", ylab="value", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="red", lwd=2, xaxp=xaxp)

# polygon(x=c(signals_mean$generation, rev(signals_mean$generation)), 
#         y=sd_y_1, 
#         col=adjustcolor("salmon", alpha.f = 0.20), border = NA)
lines(selection_mean$generation, selection_mean$selection_strength, col="green")

# polygon(x=c(selection_mean$generation, rev(selection_mean$generation)), 
#         y=sd_y_2, 
#         col=adjustcolor("lightgreen", alpha.f = 0.20), border = NA)



# # PlotData(x, signals, xmax, yrange, "", "signal", "red", 
# #          adjustcolor("salmon", alpha.f = 0.20),ticks)
# 
# plot(x=x, y=selection, xlim=xrange, ylim=c(0,1300),
#      type="l",xlab="Generation", ylab="", cex.axis=0.95, cex.lab=1.2,
#      mgp=c(2.5, 0.7, 0), col="salmon", lwd=2, xaxp=ticks)
# 
# lines(x, signals, col="green")
# 
# lines(x, rowMeans(nefs), col="maroon1")
# # lines(x, rowMeans(ness), col="aquamarine3")
# 
# # lines(x, rowMeans(v3s), col="blue")
# # lines(x, rowMeans(qs), col="purple")
# # lines(x, rowMeans(v5s), col="orange")
# 
# legend("topright",           # Legend position
#        legend = c("selection", "signal", "Ne_family size"),  # Legend labels
#        col = c("red", "green", "maroon1"),    # Colors
#        pch = 1) 
# 
# # PlotData(x, selection, xmax, yrange, "", "selection", "green", 
# #          adjustcolor("lightgreen", alpha.f = 0.50), ticks)
# 
# # PlotData(x, nefs, xrange, c(0,600), "", "Nef value", "maroon1",
# #          adjustcolor("mistyrose", alpha.f = 0.50), ticks)
# 
# # PlotData(x, ness, xrange, yrange, "", "Nes value", "aquamarine3",
# #          adjustcolor("aquamarine", alpha.f = 0.50), ticks)
# 
# PlotData(x, v3s, xrange, yrange, "Generation", "", "blue",
#          adjustcolor("lightblue", alpha.f = 0.50), ticks)
# # lines(x, rowMeans(v3s), col="blue")
# lines(x, rowMeans(qs), col="purple")
# lines(x, rowMeans(v5s), col="orange")
# 
# legend("topright",           # Legend position
#        legend = c("v3", "q", "v5"),  # Legend labels
#        col = c("blue", "purple", "orange"),    # Colors
#        pch = 1) 
# # PlotData(x, qs, xrange, yrange, "Generation", "q value", "purple",
# #          adjustcolor("mediumpurple1", alpha.f = 0.10), ticks)
# # 
# # PlotData(x, v5s, xrange, yrange, "Generation", "v5 value", "orange",
# #          adjustcolor("navajowhite", alpha.f = 0.50), ticks)
# box()
# 
# pdf(paste0("plots/", fn, "_zoomed.pdf"))
# xrange <- c(5900,7500)
# 

# 
# lines(x, signals, col="green")
# 
# lines(x, rowMeans(nefs), col="maroon1")
# legend("topright",           # Legend position
#        legend = c("selection", "signal", "Ne_family size"),  # Legend labels
#        col = c("red", "green", "maroon1"),    # Colors
#        pch = 1) 
# 
# PlotData(x, v3s, xrange, yrange, "Generation", "", "blue",
#          adjustcolor("lightblue", alpha.f = 0.50), ticks)
# 
# lines(x, rowMeans(qs), col="purple")
# lines(x, rowMeans(v5s), col="orange")
# 
# legend("topright",           # Legend position
#        legend = c("v3", "q", "v5"),  # Legend labels
#        col = c("blue", "purple", "orange"),    # Colors
#        pch = 1) 
# 
# 
# box()
# 
dev.off()