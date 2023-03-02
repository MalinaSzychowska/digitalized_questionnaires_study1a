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


## SSQ----
# auditory speech
aud_speech_questions <- c("You are talking with one other person and there is a TV on in the same room. Without turning the TV down, can you follow what the person you’re talking to says?",
                   "You are talking with one other person in a quiet, carpeted lounge-room. Can you follow what the other person says?",
                   "You are in a group of about five people, sitting round a table. It is an otherwise quiet place. You can see everyone else in the group. Can you follow the conversation?",
                   "You are in a group of about five people in a busy restaurant. You can see everyone else in the group. Can you follow the conversation?",
                   "You are talking with one other person. There is continuous background noise, such as a fan or running water. Can you follow what the person says?",
                   "You are in a group of about five people in a busy restaurant. You CANNOT see everyone else in the group. Can you follow the conversation?",
                   "You are talking to someone in a place where there are a lot of echoes, such as a church or railway terminus building. Can you follow what the other person says?",
                   "Can you have a conversation with someone when another person is speaking whose voice is the same pitch as the person you’re talking to?",
                   "Can you have a conversation with someone when another person is speaking whose voice is different in pitch from the person you’re talking to?",
                   "You are listening to someone talking to you, while at the same time trying to follow the news on TV. Can you follow what both people are saying?",
                   "You are in conversation with one person in a room where there are many other people talking. Can you follow what the person you are talking to is saying?",
                   "You are with a group and the conversation switches from one person to another. Can you easily follow the conversation without missing the start of what each new speaker is saying?",
                   "Can you easily have a conversation on the telephone?",
                   "You are listening to someone on the telephone and someone next to you starts talking. Can you follow what’s being said by both speakers?")
aud_speech_option <- rep(c("0: Not at all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Perfectly", "Not applicable"), length(aud_speech_questions))
aud_speech_type <- rep("matrix", length(aud_speech_option))
aud_speech_ids <- rep("mat_aud_speech", length(aud_speech_option))

# Auditory spatial
aud_spatial_questions <- c("You are outdoors in an unfamiliar place. You hear someone using a lawnmower. You can’t see where they are. Can you tell right away where the sound is coming from?",
                           "You are sitting around a table or at a meeting with several people. You can’t see everyone. Can you tell where any person is as soon as they start speaking?",
                           "You are sitting in between two people. One of them starts to speak. Can you tell right away whether it is the person on your left or your right, without having to look?",
                           "You are in an unfamiliar house. It is quiet. You hear a door slam. Can you tell right away where that sound came from?",
                           "You are in the stairwell of a building with floors above and below you. You can hear sounds from another floor. Can you readily tell where the sound is coming from?",
                           "You are outside. A dog barks loudly. Can you tell immediately where it is, without having to look?",
                           "You are standing on the footpath of a busy street. Can you hear right away which direction a bus or truck is coming from before you see it?",
                           "In the street, can you tell how far away someone is, from the sound of their voice or footsteps?",
                           "Can you tell how far away a bus or a truck is, from the sound?",
                           "Can you tell from the sound which direction a bus or truck is moving, for example, from your left to your right or right to left?",
                           "Can you tell from the sound of their voice or footsteps which direction a person is moving, for example, from your left to your right or right to left?",
                           "Can you tell from their voice or footsteps whether the person is coming towards you or going away?",
                           "Can you tell from the sound whether a bus or truck is coming towards you or going away?",
                           "Do the sounds of things you are able to hear seem to be inside your head rather than out there in the world?",
                           "Do the sounds of people or things you hear, but cannot see at first, turn out to be closer than expected when you do see them?",
                           "Do the sounds of people or things you hear, but cannot see at first, turn out to be further away than expected when you do see them?",
                           "Do you have the impression of sounds being exactly where you would expect them to be?")
aud_spatial_option <- c(rep(c("0: Not at all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Perfectly", "Not applicable"), 13),
                       c("0: Inside my head", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Out there", "Not applicable"), 
                       c("0: Much closer", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Not closer", "Not applicable"), 
                       c("0: Much further", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Not further", "Not applicable"), 
                       c("0: Not at all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Perfectly", "Not applicable"))
aud_spatial_type <- rep("matrix", length(aud_spatial_option))
aud_spatial_ids <- c(rep("mat_aud_spatial_a", 13*12), 
                     rep("mat_aud_spatial_b",12), 
                     rep("mat_aud_spatial_c",12), 
                     rep("mat_aud_spatial_d",12),
                     rep("mat_aud_spatial_a",12))


# Auditory qualities of hearing
aud_qual_questions <- c("Think of when you hear two things at once, for example, water running into a basin and, at the same time, a radio playing. Do you have the impression of these as sounding separate from each other?",
                        "When you hear more than one sound at a time, do you have the impression that it seems like a single jumbled sound?",
                        "You are in a room and there is music on the radio. Someone else in the room is talking. Can you hear the voice as something separate from the music?",
                        "Do you find it easy to recognise different people you know by the sound of each one’s voice?",
                        "Do you find it easy to distinguish different pieces of music that you are familiar with?",
                        "Can you tell the difference between different sounds, for example, a car versus a bus; water boiling in a pot versus food cooking in a frypan?",
                        "When you listen to music, can you make out which instruments are playing?",
                        "When you listen to music, does it sound clear and natural?",
                        "Do everyday sounds that you can hear easily seem clear to you (not blurred)?",
                        "Do other people’s voices sound clear and natural?",
                        "Do everyday sounds that you hear seem to have an artificial or unnatural quality?",
                        "Does your own voice sound natural to you?",
                        "Can you easily judge another person’s mood from the sound of their voice?",
                        "Do you have to concentrate very much when listening to someone or something?",
                        "Do you have to put in a lot of effort to hear what is being said in conversation with others?",
                        "When you are the driver in a car can you easily hear what someone is saying who is sitting alongside you?",
                        "When you are a passenger can you easily hear what the driver is saying sitting alongside you?",
                        "Can you easily ignore other sounds when trying to listen to something?")
aud_qual_option <- c(rep(c("0: Not at all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Perfectly", "Not applicable"), 10),
                     c("0: Unnatural", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Out there", "Natural"), 
                     rep(c("0: Not at all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Perfectly", "Not applicable"), 2),
                     c("0: Concentrate hard", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: No need to concentrate", "Not applicable"), 
                     c("0: Lots of effort", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: No effort", "Not applicable"), 
                     rep(c("0: Not at all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Perfectly", "Not applicable"), 2),
                     c("0: Not easily ignore", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10: Easily ignore", "Not applicable"))
aud_qual_type <- rep("matrix", length(aud_qual_option))
aud_qual_ids <- c(rep("mat_aud_spatial_a", 10*12), 
                  rep("mat_aud_spatial_b",12), 
                  rep("mat_aud_spatial_a",2*12), 
                  rep("mat_aud_spatial_c",12),
                  rep("mat_aud_spatial_d",12), 
                  rep("mat_aud_spatial_a",2*12),
                  rep("mat_aud_spatial_d",12))


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
                              olf_questions,
                              rep(aud_speech_questions, each = 12), 
                              rep(aud_spatial_questions, each = 12), 
                              rep(aud_qual_questions, each = 12), 
                              rep(mem_questions, each = 5)), 
                 option = c(dem_option, 
                            olf_options, 
                            aud_speech_option, 
                            aud_spatial_option, 
                            aud_qual_option,
                            mem_option), 
                 input_type = c(dem_type, 
                                olf_type, 
                                aud_speech_type, 
                                aud_spatial_type, 
                                aud_qual_type, 
                                mem_type), 
                 input_id = c(dem_ids, 
                              olf_ids, 
                              aud_speech_ids, 
                              aud_spatial_ids, 
                              aud_qual_ids,
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
    rep(1, 3),
    rep(2, 20),
    rep(3, 14),
    rep(4, 17), 
    rep(5, 18), 
    rep(6, 16))
  )

multiQuestions

multiQuestions <- multiQuestions %>%
  unnest(cols = data)



# Define user interface
ui <- fluidPage(
  surveyOutput(df = multiQuestions,
               survey_title = "Importance of Olfaction, Hearing and Memory!",
               survey_description = "Welcome!")
)


# Define server
server <- function(input, output, session) {
  renderSurvey()
  
  # Upon submission, show thank you to the participant and print a data frame with participant responses
  observeEvent(input$submit, {
    print(input)
    fp <- input$participant_ID
    age <- input$Age 
    gender <- input$Gender
    out_olf <- input$mat_olf 
    #response_data <- getSurveyData()
    #print(response_data)
  })
}

shinyApp(ui = ui, server = server)


























# Define questions in the format of a shinysurvey
dep_questions <- tail(teaching_r_questions, 12)

# Define shiny UI
ui <- fluidPage(
  surveyOutput(dep_questions,
               survey_title = "Hello, World!")
)

# Define shiny server
server <- function(input, output, session) {
  renderSurvey()
  
  observeEvent(input$submit, {
    response_data <- getSurveyData()
    print(response_data)
  })
  
}

# Run the shiny application
shinyApp(ui, server)
