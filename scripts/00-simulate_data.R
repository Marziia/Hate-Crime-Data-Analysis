#### Preamble ####
# Purpose: Simulates the hate crimes data set on Open Data Toronto
# Author: Marzia Zaidi
# Date: 26 September 2024
# Contact: Marzia.zaidi@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse library installed
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)



#### Simulate data ####
## we would imagine that the hate crimes data set would have a year column for when the crime happened and this should probably be higher in latter years. 
## We chose a logarithmic increase pattern, since it might make sense for the rate of the increase itself to decrease
set.seed(300)

n <- 10
x <- 1:n + 2013
trend <- log(x + 1 - 2013) * 100  # Logarithmic trend
noise <- rnorm(n, mean = 0, sd = 10)  # Random noise

y <- trend + noise
plot(x, y, type = "l", col = "green", main = "Expected numer of hate crimes per year", xlab = "Time", ylab = "Value")

## we would also imagine that hate crimes would happen more likely at night
set.seed(300)

# Define the time range in hours (0-23)
hours <- 0:23

# Assign probabilities: Higher probability for night-time (18:00-06:00)
probabilities <- c(rep(0.05, 7),  # 12 AM - 6 AM (higher probability for night)
                   rep(0.02, 11), # 7 AM - 5 PM (lower probability for day)
                   rep(0.05, 6))  # 6 PM - 11 PM (higher probability for night)

# Normalize probabilities so they sum to 1 
probabilities <- probabilities / sum(probabilities)

# Generate random hours based on these probabilities
n <- 1000  # Number of samples
random_hours <- sample(hours, size = n, replace = TRUE, prob = probabilities)

# Convert random hours into times of day (e.g., in HH:MM format)
random_times <- sprintf("%02d:%02d", random_hours, sample(0:59, n, replace = TRUE))

# Print first few random times
head(random_times)

# Histogram to visualize distribution
hist(random_hours, breaks = 0:24, col = "skyblue", main = "Distribution of Random Times of Day", xlab = "Hour of Day")


## since these are crimes that have been reported, we might expect there to be a time reported and a time of occurence. We would expect the difference between these two times to be maybe half an hour, and we would also expect this to be relatively constant.
set.seed(300)

# Number of time differences to simulate
n <- 1000  

# Simulate time differences in minutes, centered at 30 mins with a standard deviation of 30 mins
time_differences <- rnorm(n, mean = 30, sd = 30)

# Ensure no negative time differences - since time reported is always after time of occurence
time_differences <- pmax(time_differences, 0)

# Create a histogram
hist(time_differences, breaks = 30, col = "red",
     main = "Histogram of Time Differences (centered at 30 mins)",
     xlab = "Time Difference (minutes)",
     ylab = "Frequency")
