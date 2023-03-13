#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

# install.packages("shinysurveys")

library(shiny)
library(shinysurveys)
library(tidyverse)


# Create data frames with questions
## Demographic questions
dem_question <- c("Enter participant's ID")
dem_option <- c("e.g., Study1a_FP00")
dem_type <- c("text")
dem_ids <- c("participant_ID")


## Prospective-Retrospective Memory Questionnaire----
mem_questions <- c("Do you decide to do something in a few minutes’ time and then forget to do it?",
                   "Do you fail to recognise a place you have visited before?",
                   "Do you fail to do something you were supposed to do a few minutes later even though it’s there in front of you, like take a pill or turn off the kettle?",
                   "Do you forget something that you were told a few minutes before?",
                   "Do you forget appointments if you are not prompted by someone else or by a reminder such as a calendar or diary?",
                   "Do you fail to recognise a character in a radio or television show from scene to scene?",
                   "Do you forget to buy something you planned to buy, like a birthday card, even when you see the shop?",
                   "Do you fail to recall things that have happened to you in the last few days?",
                   "Do you repeat the same story to the same person on different occasions?",
                   "Do you intend to take something with you, before leaving a room or going out, but minutes later leave it behind, even though it's there in front of you?",
                   "Do you mislay something that you have just put down, like a magazine or glasses?",
                   "Do you fail to mention or give something to a visitor that you were asked to pass on?",
                   "Do you look at something without realizing you have seen it moments before?",
                   "If you tried to contact a friend or relative who was out, would you forget to try again later?",
                   "Do you forget what you watched on television the previous day?",
                   "Do you forget to tell someone something you had meant to mention a few minutes ago?")
mem_option <- rep(c("Very often", "Quite often", "Sometimes", "Rarely", "Never"), length(mem_questions))
mem_type <- rep("matrix", length(mem_option))
mem_ids <- rep("mat_mem", length(mem_option))


# Create the main DF
df <- data.frame(question = c(dem_question, 
                              rep(mem_questions, each = 5)), 
                 option = c(dem_option, 
                            mem_option), 
                 input_type = c(dem_type, 
                                mem_type), 
                 input_id = c(dem_ids, 
                              mem_ids), 
                 dependence = NA, 
                 dependence_value = NA, 
                 required = TRUE)


# In our example, the survey has questions with dependencies (conditionally shown questions), 
# so I want to make sure all the parent and children questions are on the same page. 
# To do this, I’ll group the data frame by each question and nest the other columns for a simpler manipulation:
#   

nested_questions <- df %>%
  group_by(question) %>%
  nest() %>%
  ungroup()

nested_questions

multiQuestions <- nested_questions %>%
  mutate(page = c(
    1,
    rep(6, 16))
  )

multiQuestions

multiQuestions <- multiQuestions %>%
  unnest(cols = data)



# Define user interface
ui <- fluidPage(
  surveyOutput(df = multiQuestions,
               survey_title = "Remembering to do things",
               survey_description = "Prospective-Retrospective Memory Questionnaire as described in:
                      Smith, G., Della Sala, S., Logie, R.H. & Maylor, E.A. (2000). Prospective and Retrospective Memory in
                      Normal Aging and Dementia: A Questionnaire Study. Memory, 8, 311-321.
                      In order to understand why people make memory mistakes, we need to find out about the kinds of mistakes people
                      make, and how often they are made in normal everyday life. We would like you to tell us how often these kind of
                      things happen to you. Please indicate by ticking the appropriate box.
                      Please make sure you answer all of the questions on both sides of the sheet even if they don’t seem entirely
                      applicable to your situation"))


# Define server
server <- function(input, output, session) {
  renderSurvey()
  
  # Upon submission, show thank you to the participant and print a data frame with participant responses
  observeEvent(input$submit, {
    
    fp <- input$participant_ID
    out_mem <- input$mat_mem 
    df_tmp <- data.frame(fp, out_mem)
    
    write.csv(df_tmp, file = paste(fp,"_memory.csv"))
    
    print(out_mem)
    
    stopApp()
    
  })
}

shinyApp(ui = ui, server = server)


