set.seed(1)
df <- data.frame(x = c(1, 4, 7),
                 y = c(2, 5, 8),
                 z = c(3, 6, 9))

df2 <- data.frame(x = c(1, 4, 7),
                 y = c(2, 5, 8),
                 z = c(3, 6, 9))

test<-cbind(df,df2)

temp <- cbind(df,df2)
pairs(temp)