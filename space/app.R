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
spc_questions <- c("01. I am very good at giving directions.",
                   "02. I have a poor memory for where I left things",
                   "03. I am very good at judging distances.",
                   "04. My 'sense of direction' is very good.",
                   "05. I tend to think of my environment in terms of cardinal directions (N, S, E, W).",
                   "06. I very easily get lost in a new city.",
                   "07. I enjoy reading maps",
                   "08. I have trouble understanding directions.",
                   "09. I am very good at reading maps",
                   "10. I don’t remember routes very well while riding as a passenger in a car.",
                   "11. I don’t enjoy giving directions.",
                   "12. It’s not important to me to know where I am.",
                   "13. I usually let someone else do the navigational planning for long trips",
                   "14. I can usually remember a new route after I have traveled it only once",
                   "15. I don’t have a very good “mental map” of my environment.")
spc_option <- rep(c("1: strongly agree", "2", "3", "4", "5", "6", "7: strongly disagree"), length(spc_questions))
spc_type <- rep("matrix", length(spc_option))
spc_ids <- rep("mat_spc", length(spc_option))


# Create the main DF
df <- data.frame(question = c(dem_question, 
                              rep(spc_questions, each = 7)), 
                 option = c(dem_option, 
                            spc_option), 
                 input_type = c(dem_type, 
                                spc_type), 
                 input_id = c(dem_ids, 
                              spc_ids), 
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
    rep(2, 15))
  )

multiQuestions

multiQuestions <- multiQuestions %>%
  unnest(cols = data)



# Define user interface
ui <- fluidPage(
  surveyOutput(df = multiQuestions,
               survey_title = "SANTA BARBARA SENSE-OF-DIRECTION SCALE",
               survey_description = "The following statements ask you about your spatial and navigational abilities, preferences, and
experiences. After each statement, you should select a number to indicate your level of
agreement with the statement. Select “1” if you strongly agree that the statement applies to you,
“7” if you strongly disagree, or some number in between if your agreement is intermediate.
Select “4” if you neither agree nor disagree"))


# Define server
server <- function(input, output, session) {
  renderSurvey()
  
  # Upon submission, show thank you to the participant and print a data frame with participant responses
  observeEvent(input$submit, {
    
    fp <- input$participant_ID
    out_spc <- input$mat_spc 
    df_tmp <- data.frame(fp, out_spc)
    
    write.csv(df_tmp, file = paste(fp,"_space.csv"))
    
    print(out_spc)
    
    stopApp()
    
  })
}

shinyApp(ui = ui, server = server)


