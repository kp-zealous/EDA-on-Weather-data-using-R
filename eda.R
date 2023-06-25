library(ggplot2)   # For data visualization
library(dplyr)     # For data manipulation
library(caret)     # For machine learning algorithms
dataset <-  read.csv("~/weatherHistory.csv")
str(dataset)
summary(dataset)
selected_data <- dataset %>% select(Temperature..C.,Humidity,Wind.Speed..km.h.)
set.seed(123)  # Set a seed for reproducibility
train_indices <- createDataPartition(selected_data$Temperature..C., p = 0.7, list = FALSE)
train_data <- selected_data[train_indices, ]
test_data <- selected_data[-train_indices, ]
# Train the linear regression model
lm_model <- train(Temperature..C. ~ ., data = train_data, method = "lm")

# Make predictions on the testing set
lm_predictions <- predict(lm_model, newdata = test_data)

# Evaluate the model
lm_metrics <- postResample(lm_predictions, test_data$temperature)
print(lm_metrics)

# Create a scatter plot with a smooth curve
ggplot(data = dataset, aes(x = Humidity, y = Temperature..C.)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
  labs(x = "Humidity", y = "Temperature")

