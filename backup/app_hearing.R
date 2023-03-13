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
                     rep("mat_aud_spatial_e",12))


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
aud_qual_ids <- c(rep("mat_aud_quality_a", 10*12), 
                  rep("mat_aud_quality_b",12), 
                  rep("mat_aud_quality_c",2*12), 
                  rep("mat_aud_quality_d",12),
                  rep("mat_aud_quality_e",12), 
                  rep("mat_aud_quality_f",2*12),
                  rep("mat_aud_quality_g",12))



# Create the main DF
df <- data.frame(question = c(dem_question, 
                              rep(aud_speech_questions, each = 12), 
                              rep(aud_spatial_questions, each = 12), 
                              rep(aud_qual_questions, each = 12)), 
                 option = c(dem_option,  
                            aud_speech_option, 
                            aud_spatial_option, 
                            aud_qual_option), 
                 input_type = c(dem_type, 
                                aud_speech_type, 
                                aud_spatial_type, 
                                aud_qual_type), 
                 input_id = c(dem_ids, 
                              aud_speech_ids, 
                              aud_spatial_ids, 
                              aud_qual_ids), 
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
    rep(1, 1),
    rep(3, 14),
    rep(4, 17), 
    rep(5, 18))
  )

multiQuestions

multiQuestions <- multiQuestions %>%
  unnest(cols = data)



# Define user interface
ui <- fluidPage(
  surveyOutput(df = multiQuestions,
               survey_title = "Quality of hearing!",
               survey_description = "The following questions inquire about aspects 
                of your ability and experience hearing and listening indifferent situations.
                For each question, put a mark, such as a cross (x), 
                anywhere on the scale shown against each question 
                that runs from 0 through to 10. Putting a mark at 10
                means that you would be perfectly able to do or
                experience what is described in the question. Putting
                a mark at 0 means you would be quite unable to do or
                experience what is described.
                As an example, question 1 asks about having a
                conversation with someone while the TV is on at the
                same time. If you are well able to do this then put a
                mark up toward the right-hand end of the scale. If
                you could follow about half the conversation in this
                situation put the mark around the mid-point, and so
                on.
                We expect that all the questions are relevant to
                your everyday experience, but if a question
                describes a situation that does not apply to you,
                put a cross in the “not applicable” box."))


# Define server
server <- function(input, output, session) {
  renderSurvey()
  
  # Upon submission, show thank you to the participant and print a data frame with participant responses
  observeEvent(input$submit, {
    
    fp <- input$participant_ID
    out_aud <- bind_rows(input$mat_aud_speech, 
                         input$mat_aud_spatial_a, 
                         input$mat_aud_spatial_b, 
                         input$mat_aud_spatial_c, 
                         input$mat_aud_spatial_d, 
                         input$mat_aud_spatial_e, 
                         input$mat_aud_quality_a, 
                         input$mat_aud_quality_b, 
                         input$mat_aud_quality_c, 
                         input$mat_aud_quality_d, 
                         input$mat_aud_quality_e, 
                         input$mat_aud_quality_f, 
                         input$mat_aud_quality_g)
                         
    df_tmp <- data.frame(fp, out_aud)
    
    write.csv(df_tmp, file = paste(fp,"_hearing.csv"))
    
    print(out_aud)
  
  })
}

shinyApp(ui = ui, server = server)






















