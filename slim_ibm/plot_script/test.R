# Sample data frame (assuming it's the same as before)
set.seed(123)
df <- data.frame(Group = sample(LETTERS[1:3], 20, replace = TRUE),
                 Col1 = rnorm(20),
                 Col2 = runif(20),
                 Col3 = rnorm(20),
                 Col4 = runif(20),
                 Col5 = rnorm(20),
                 Col6 = runif(20),
                 Col7 = rnorm(20),
                 Col8 = runif(20),
                 Col9 = rnorm(20))

# Aggregating Col1 and Col2 against Group
result <- aggregate(cbind(Col1, Col2) ~ Group, data = df, FUN = sum)

# View the result
print(result)
