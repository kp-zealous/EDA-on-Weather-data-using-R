library(ggplot2)

# Read the dataset
dataset <-  read.csv("~/weatherHistory.csv",header = TRUE)

# Create a scatter plot of temperature vs. humidity
ggplot(data = dataset, aes(x = humidity, y = Temperature..C.)) +
  geom_point() +
  labs(x = "Humidity", y = "Temperature") +
  ggtitle("Temperature vs. Humidity")
# Convert 'time' column to datetime format
dataset$time <- as.POSIXct(dataset$time)

# Create a line plot of temperature over time
ggplot(data = dataset, aes(x = time, y = Temperature..C.)) +
  geom_line() +
  labs(x = "Time", y = "Temperature") +
  ggtitle("Temperature Variation Over Time")

# Create a histogram of temperature
ggplot(data = dataset, aes(x = Temperature..C.)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(x = "Temperature", y = "Frequency") +
  ggtitle("Temperature Distribution")

# Create a box plot of temperature by summary categories
ggplot(data = dataset, aes(x = summary, y = v)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(x = "Summary", y = "Temperature") +
  ggtitle("Temperature Distribution by Summary")

