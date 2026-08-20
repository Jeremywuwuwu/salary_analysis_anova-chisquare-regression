#Jeremy Wu 
#ALY 6015 
#04/13/2026

library(tidyverse)
library(dplyr)
library(ggplot2)
library(reshape)

salary <- read_csv("Salary.csv")

#correlation coefficient for salary
numerical <- salary %>% select(Age, `Education Level`, `Years of Experience`, Senior)

pearson_corr <- round(cor(numerical, salary$Salary, use = "complete.obs"), 1)
print(pearson_corr)

#Correlation matrix
matrix <- salary %>% select(Age, `Salary`,`Education Level`, `Years of Experience`, Senior)
corr_matrix <- round(cor(matrix, use = "complete.obs"), 1)

melt <- melt(corr_matrix)

ggplot(melt, aes(x = X1, y = X2, fill = value))+
  geom_tile(color = "black")+
  geom_text(aes(label = value, fontface = "bold"),size = 5)+
  scale_fill_gradient2(low = "beige", mid = "tan", high = "brown",
                       midpoint = 0, limit = c(-1, 1),
                       name = "Correlation Coefficient") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  
        axis.title.x = element_blank(),
        axis.title.y = element_blank())+
  labs(title = "Correlation Matrix for US Jobs")

#non numerical variables to salary using ANOVA testing 
combined <- aov(Salary ~ Gender + Country + Race + `Job Title`, data = salary)
summary(combined)

#Muliple Linear Regression
linear <- lm(Salary ~ Age + `Years of Experience` + `Education Level` 
             + Gender + Country + Race, data = salary)
summary(linear)

#Linear Regression Model for Years of experience and salary per education level
ggplot(salary, aes(x = `Years of Experience`, y = Salary, color = factor(`Education Level`))) +
  geom_point(alpha = 0.2, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.5) +
  scale_y_continuous(labels = scales::dollar_format())+
  scale_color_discrete(labels = c("0" = "High School", 
                                  "1" = "Bachelor's", 
                                  "2" = "Master's", 
                                  "3" = "PhD"))+
  labs(title = "Years of Experience vs Salary by Education Level",
       x = "Years of Experience",
       y = "Salary",
       color = "Education Level") +
  theme_minimal()

#Linear Regression Model for age & salary per Country
ggplot(salary, aes(x = Age, y = Salary, color = factor(Country)))+
  geom_point(alpha = 0.2, size = 1.2)+
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.5)+
  scale_y_continuous(labels = scales::dollar_format())+
  labs(title = "Age vs Salary by Country",
       x = "Age",
       y = "Salary",
       color = "Country") +
  theme_minimal()
