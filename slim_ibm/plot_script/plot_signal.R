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

pdf(paste0(fn, ".pdf"))

xrange <- c(0,16000)
xaxp<- c(0, 16000, 16)
par(mfrow=c(3,1), mar=c(4.0, 4.0, 1.5, 1.5))

sd_y_1 <- c(selection_mean$selection_strength + selection_sd$selection_strength, 
            rev(selection_mean$selection_strength - selection_sd$selection_strength))
yrange_1 <- c(min(sd_y_1, na.rm=TRUE), max(sd_y_1, na.rm=TRUE))
# yrange <- c(0,16000)

# plot signal and selection
plot(x=selection_mean$generation, y=selection_mean$selection_strength, xlim=xrange, 
     ylim = yrange_1,
     type="l",xlab="Generation", ylab="value", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="red", lwd=2, xaxp=xaxp)

polygon(x=c(selection_mean$generation, rev(selection_mean$generation)),
        y=sd_y_1,
        col=adjustcolor("salmon", alpha.f = 0.20), border = NA)

sd_y_2 <- c(signals_mean$signal + signals_sd$signal, rev(signals_mean$signal - signals_sd$signal))
yrange <- c(min(sd_y_2, na.rm=TRUE), max(sd_y_2, na.rm=TRUE))

lines(signals_mean$generation, signals_mean$signal, col="green")

polygon(x=c(signals_mean$generation, rev(signals_mean$generation)), 
        y=sd_y_2, 
        col=adjustcolor("lightgreen", alpha.f = 0.20), border = NA)

legend("topright",           # Legend position
              legend = c("choosiness", "signal"),  # Legend labels
              col = c("red", "green"),    # Colors
              pch = 1)

# plot zoomed version of signal and selection (0-5000 5000-16000)
xrange <- c(4500, 7500)
# plot signal and selection
plot(x=selection_mean$generation, y=selection_mean$selection_strength, xlim=xrange, 
     ylim = yrange_1,
     type="l",xlab="Generation", ylab="value", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="red", lwd=2, xaxp=xaxp)

polygon(x=c(selection_sd$generation, rev(selection_sd$generation)),
        y=sd_y_1,
        col=adjustcolor("salmon", alpha.f = 0.20), border = NA)

lines(signals_mean$generation, signals_mean$signal, col="green")

polygon(x=c(signals_mean$generation, rev(signals_mean$generation)), 
        y=sd_y_2, 
        col=adjustcolor("lightgreen", alpha.f = 0.20), border = NA)

legend("topright",           # Legend position
       legend = c("choosiness", "signal"),  # Legend labels
       col = c("red", "green"),    # Colors
       pch = 1)

# plot individual coefficient
df_mean <- aggregate(. ~ generation, data = df, FUN = mean)
df_sd <- aggregate(. ~ generation, data = df, FUN = sd)
x <- c(df_mean$generation, rev(df_mean$generation))
sd_y_3 <- c(df_mean$v3 + df_sd$v3, rev(df_mean$v3 - df_sd$v3))
sd_y_q <- c(df_mean$q + df_sd$q, rev(df_mean$q - df_sd$q))
sd_y_5 <- c(df_mean$v5 + df_sd$v5, rev(df_mean$v5 - df_sd$v5))

yrange <- c(min(sd_y_3, sd_y_q, sd_y_5, na.rm=TRUE), max(sd_y_3, sd_y_q, sd_y_5, na.rm=TRUE))
xrange <- c(0, 16000)

plot(x=df_mean$generation, y=df_mean$v3, xlim=xrange, 
     ylim = yrange,
     type="l",xlab="Generation", ylab="value", cex.axis=0.95, cex.lab=1.2,
     mgp=c(2.5, 0.7, 0), col="blue", lwd=2, xaxp=xaxp)
polygon(x=x,
        y=sd_y_3,
        col=adjustcolor("lightblue", alpha.f = 0.50), border = NA)

lines(df_mean$generation, df_mean$q, col="purple")
polygon(x=x,
        y=sd_y_q,
        col=adjustcolor("mediumpurple1", alpha.f = 0.10), border = NA)

lines(df_mean$generation, df_mean$v5, col="orange")
polygon(x=x,
        y=sd_y_5,
        col=adjustcolor("navajowhite", alpha.f = 0.50), border = NA)

legend("topright",           # Legend position
       legend = c("v3", "q", "v5"),  # Legend labels
       col = c("blue", "purple", "orange"),    # Colors
       pch = 1)

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