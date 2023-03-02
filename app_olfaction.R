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
dem_question <- c("Enter participant's ID", "What is your age?", rep("Which best describes your gender?",4))
dem_option <- c("e.g., Study1a_FP00", "", "Female", "Male", "Other", "Prefer not to answer")
dem_type <- c("text","text", "select","select","select","select")
dem_ids <- c("participant_ID", "Age", rep("Gender",4))


## Importance of olfaction----
olf_questions <- rep(c("The smell of a person plays a role in the decision whether I like him/her.", 
               "I smell foods to find out whether it is spoiled or not.",
               "I sniff on food before eating.",
               "Please imagine you visit a museum. There is an offer to get additionally smell-presentations to underline the overall impression for the price of 2 EURO. Would you take this offer?", 
               "When I don't like the smell of a shampoo, I don't buy it.", 
               "When I smell delicious food, I'm getting hungry.",
               "Without my sense of smell, life would be worthless.", 
               "I try to locate the odour when I smell something.",
               "I feel rather quickly disturbed by odours in my environment.",
               "Certain smells immediately activate numerous memories.",
               "Before drinking coffee/tea, I intentionally smell it.",
               "When I buy tomatoes, I pay attention to their odour.",
               "If my partner has a nasty smell, I avoid kissing him/her.",
               "Certain smells immediately activate strong feelings.",
               "I smell my clothes to judge whether I have to wash them or not.",
               "When there is a nasty smell in the office/apartment of a colleague, I leave the room as soon as possible.",
               "Certain odours can stimulate my fantasy.",
               "To me it is more important to be able to smell than to be able to see or hear.",
               "Sometimes I smell a person (e.g., my partner or my child) to judge if he/she has drunken alcohol or smoked.",
               "I cannot pass good smelling candles in a store without buying one."), each = 4)
olf_option <- rep(c("I totally agree", "I mostly agree", "I mostly disagree", "I totally disagree"), 20)
olf_type <- rep("matrix", length(olf_option))
olf_ids <- rep("mat_olf", length(olf_option))



# Create the main DF
df <- data.frame(question = c(dem_question, 
                              olf_questions),
                 option = c(dem_option, 
                            olf_options), 
                 input_type = c(dem_type, 
                                olf_type), 
                 input_id = c(dem_ids, 
                              olf_ids), 
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
    rep(1, 3),
    rep(2, 20))
  )

multiQuestions

multiQuestions <- multiQuestions %>%
  unnest(cols = data)



# Define user interface
ui <- fluidPage(
  surveyOutput(df = multiQuestions,
               survey_title = "Importance of Olfaction survey",
               survey_description = "Welcome! This questionnaire refers to the role your sense of smell plays in your daily life. Please answer all of the questions spontaneously, there are no right or wrong answers.")
)


# Define server
server <- function(input, output, session) {
  renderSurvey()
  
  # Upon submission, show thank you to the participant and print a data frame with participant responses
  observeEvent(input$submit, {
    
    fp <- input$participant_ID
    age <- input$Age 
    gender <- input$Gender
    out_olf <- input$mat_olf 
    df_tmp <- data.frame(fp, age, gender, out_olf)
    
    write.csv(df_tmp, file = paste(fp,"_olfaction.csv"))
    
    print(input)
    
  })
}

shinyApp(ui = ui, server = server)


















