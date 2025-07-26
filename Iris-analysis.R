### Project-1
# loading library and dataset

library(datasets)
data("iris")

# head n tail of data
head(iris,4)
tail(iris,4)

#Summary
summary(iris)

#specific column detail and summary
iris$Sepal.Length
summary(iris$Sepal.Length)

## Checking missing data?
sum(is.na(iris))

# skimr() - expands on summary() by providing larger set of statistics
#  install.packages("skimr")
# https://github.com/ropensci/skimr

library(skimr)

skim(iris)

# Group data by Species then perform skim
iris %>% 
  dplyr::group_by(Species) %>% 
  skim() 


## Data Visualization in R

# Panel plots
plot(iris)
plot(iris, col = "steelblue")


##scatter plot

plot(iris$Sepal.Width, iris$Sepal.Length, col = "steelblue",     #Adds x and y axis labels
     xlab = "Sepal width", ylab = "Sepal length")





