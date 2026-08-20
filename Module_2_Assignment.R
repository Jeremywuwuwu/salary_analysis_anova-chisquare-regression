#ALY 6015
#Jeremy Wu
#04/18/2026

library(tidyverse)
library(dplyr)

salary <- read.csv("Salary.csv")

#Chi-Square test on Education Level & Senior Status 
#Null Hypothesis: there is no statistical significance between education level and senior status 
es <- chisq.test(table(salary$Education.Level, salary$Senior))
print(es)
#Output = reject null hypothesis, p value < sig level and x squared > critical value at df 3

#Chi Square test on Race & Senior Status 
rs <- chisq.test(table(salary$Race, salary$Senior))
print(rs)
#Failed to reject null hypothesis, there is no statistic significance between the two categorical variables

#ANOVA test next on gender vs salary
gs <- aov(Salary ~ Gender, data = salary)
summary(gs)

pay_gap <- salary %>% 
  group_by(Gender) %>% 
  summarise(mean_salary = mean(Salary))


#ANOVA test on Years of experience based on Job Title 
kk <- aov(Years.of.Experience ~ Job.Title, data = salary)
summary(kk)
