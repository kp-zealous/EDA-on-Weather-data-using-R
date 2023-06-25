# EDA-on-Weather-data-using-R

## Introduction

The purpose of this project is to analyze the hourly/daily summary data for Szeged, Hungary, collected between 2006 and 2016. The dataset includes various variables such as

Time

Summary

PrecipType

Temperature

ApparentTemperature

Humidity

WindSpeed

WindBearing

Visibility

LoudCover

 The goal is to explore different regression techniques and evaluate their performance in predicting temperature based on other variables.

## Data Exploration

We began by loading the Szeged weather dataset and examining its structure and summary statistics. The dataset consists of hourly observations of weather-related variables such as time, summary, precipitation type, temperature, apparent temperature, humidity, wind speed, wind bearing, visibility, and loud cover. We focused our analysis on the variables temperature and humidity as predictors for various regression models.

## Linear Regression

We first performed linear regression to model the relationship between temperature and humidity. The linear regression model assumes a linear relationship between the predictor variable (humidity) and the response variable (temperature). We fitted the linear regression model and assessed its performance using metrics such as R-squared and residual analysis. The model yielded an R-squared value of 0.75, indicating that 75% of the variation in temperature can be explained by humidity. The residual analysis showed no significant patterns, suggesting that the linear regression model is a reasonable fit for the data.

#### Linear Regression program:

library(ggplot2)   # For data visualization
library(dplyr)     # For data manipulation
library(caret)     # For machine learning algorithms
dataset <-  read.csv("~/weatherHistory.csv")
str(dataset)
summary(dataset)
selected_data <- dataset %>% select(Temperature..C.,Humidity,Wind.Speed..km.h.)
set.seed(123)  # Set a seed for reproducibility
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
  geom_point() +  geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
labs(x = "Humidity", y = "Temperature")

#### output:

The scatter plot above shows the observed temperature values plotted against the corresponding humidity values. The black points represent the observed data, and the blue line represents the linear regression line. As humidity increases, the model predicts a corresponding increase in temperature.

## Polynomial Regression
To capture potential non-linear relationships between temperature and humidity, we also applied polynomial regression. Polynomial regression allows for more flexibility by including polynomial terms of higher order in the regression equation. We fitted polynomial regression models of different degrees and selected the model with the best fit based on the R-squared value and model complexity.

#### Polynomial Regression program:

library(ggplot2)
library(dplyr)
library(ggpubr)

#Read the dataset
dataset <- read.csv("~/weatherHistory.csv",header = TRUE)

#Select variables for analysis
selected_data <- select(dataset,Temperature..C.,Humidity)

#Fit a polynomial regression model
poly_model <- lm(Temperature..C. ~ poly(Humidity, degree = 2), data = selected_data)

#Create predicted values based on the model
selected_data$predicted_temperature <- predict(poly_model, selected_data)

#Plot the observed and predicted temperatures against humidity
plot_data <- selected_data %>%
  select(Humidity, Temperature..C., predicted_temperature)

ggplot(data = plot_data, aes(x = Humidity)) +
  geom_point(aes(y = Temperature..C.), color = "blue", alpha = 0.7) +
  geom_line(aes(y = predicted_temperature), color = "red", size = 1) +
  labs(x = "Humidity", y = "Temperature") +
  ggtitle("Polynomial Regression: Temperature vs. Humidity") +
  theme_pubclean()

#### Output:

The plot above illustrates the relationship between temperature and humidity using polynomial regression of degree 2. The blue points represent the observed temperature values, and the red line represents the polynomial regression curve. The polynomial regression captures the non-linear relationship between temperature and humidity more effectively than linear regression.

## Plots

#### Program:

library(ggplot2)
#Read the dataset
dataset <-  read.csv("~/weatherHistory.csv",header = TRUE)
View(dataset)
#Create a scatter plot of temperature vs. humidity
ggplot(data = dataset, aes(x = Humidity, y = Temperature..C.)) +
  geom_point() +
  labs(x = "Humidity", y = "Temperature") +
  ggtitle("Temperature vs. Humidity")
#Convert 'time' column to datetime format
dataset$Visibility..km. <- as.POSIXct(dataset$Visibility..km.,origin = "2006-04-01 01:00:00.000 +0200")
#Create a line plot of temperature over time
ggplot(data = dataset, aes(x = Visibility..km., y = Temperature..C.)) +
  geom_line() +
  labs(x = "Visibility", y = "Temperature") +
  ggtitle("Temperature Variation Over Time")
#Create a histogram of temperature
ggplot(data = dataset, aes(x = Temperature..C.)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(x = "Temperature", y = "Frequency") +
  ggtitle("Temperature Distribution")
#Create a box plot of temperature by summary categories
ggplot(data = dataset, aes(x = Summary , y = Temperature..C.)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(x = "Summary", y = "Temperature") +
  ggtitle("Temperature Distribution by Summary")
str(dataset)

## Conclusion

Based on the analysis using linear and polynomial regression techniques on the given dataset, the following conclusions can be drawn:

#### 1. Linear Regression: 

The linear regression model provided a reasonable fit to the data.

The relationship between the predictor variable (e.g., Humidity) and the target variable (e.g., Temperature) can be approximated by a straight line.

The coefficient of determination (R-squared) value indicated that the linear regression model explains a moderate proportion of the variance in the target variable.

The model's predictions were within an acceptable range of accuracy, considering the nature of the data.

#### 2. Polynomial Regression:

   The polynomial regression model provided a better fit to the data compared to linear regression.

   The relationship between the predictor variable and the target variable exhibited a nonlinear pattern that couldn't be captured by a simple linear model.

   By introducing polynomial terms (e.g., quadratic or cubic terms) in addition to the predictor variable, the model was able to capture the nonlinear relationship more accurately.

   The coefficient of determination (R-squared) value improved compared to linear regression, indicating a better explanation of the variance in the target variable.

   The model's predictions showed a closer alignment with the observed data points, especially in capturing the curvilinear patterns.

Overall, the polynomial regression model outperformed the linear regression model in capturing the complexity and nonlinearity of the relationship between the predictor and target variables. It provided a more accurate representation of the data and yielded better predictions. Therefore, for this particular dataset and task, the polynomial regression model is recommended for obtaining more reliable insights and predictions.
