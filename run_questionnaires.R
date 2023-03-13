# clear memory 
rm(list = ls()) # clear memory
graphics.off()  # clear all plots
cat("\014")     # clear console (same as Ctrl-L in console)


# Load necessary packages
library(shiny)
library(shinysurveys)
library(tidyverse)


# Set up directories for all questionnaires
olf_dir = "C:\\Users\\masz6827\\Box\\SCI-LAB storage\\Projects storage\\memory and spatial navigation\\Study 1\\questionnaires\\apps\\olfaction"
aud_dir = "C:\\Users\\masz6827\\Box\\SCI-LAB storage\\Projects storage\\memory and spatial navigation\\Study 1\\questionnaires\\apps\\hearing"
mem_dir = "C:\\Users\\masz6827\\Box\\SCI-LAB storage\\Projects storage\\memory and spatial navigation\\Study 1\\questionnaires\\apps\\memory"
spc_dir = "C:\\Users\\masz6827\\Box\\SCI-LAB storage\\Projects storage\\memory and spatial navigation\\Study 1\\questionnaires\\apps\\space"


# Run every questionnaire one by one
# 1. Importance of olfaction: 
runApp(appDir = olf_dir)

# 2. Quality of hearing:
runApp(appDir = aud_dir)

# 3. Subjective memory:
runApp(appDir = mem_dir)

# 4. Subjective spatial skills:
runApp(appDir = spc_dir)
