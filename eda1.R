library(ggplot2)
library(dplyr)
library(ggpubr)

# Read the dataset
dataset <- read.csv("~/weatherHistory.csv",header = TRUE)

# Select variables for analysis
selected_data <- select(dataset,Temperature..C.,Humidity)

# Fit a polynomial regression model
poly_model <- lm(Temperature..C. ~ poly(Humidity, degree = 2), data = selected_data)

# Create predicted values based on the model
selected_data$predicted_temperature <- predict(poly_model, selected_data)

# Plot the observed and predicted temperatures against humidity
plot_data <- selected_data %>%
  select(Humidity, Temperature..C., predicted_temperature)

ggplot(data = plot_data, aes(x = Humidity)) +
  geom_point(aes(y = Temperature..C.), color = "blue", alpha = 0.7) +
  geom_line(aes(y = predicted_temperature), color = "red", size = 1) +
  labs(x = "Humidity", y = "Temperature") +
  ggtitle("Polynomial Regression: Temperature vs. Humidity") +
  theme_pubclean()
