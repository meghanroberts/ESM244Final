# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    http://shiny.rstudio.com/
# #
# 
# library(shiny)
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
# 
#     # Application title
#     titlePanel("Old Faithful Geyser Data"),
# 
#     # Sidebar with a slider input for number of bins 
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#            plotOutput("distPlot")
#         )
#     )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
# 
#     output$distPlot <- renderPlot({
#         # generate bins based on input$bins from ui.R
#         x    <- faithful[, 2]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white',
#              xlab = 'Waiting time to next eruption (in mins)',
#              main = 'Histogram of waiting times')
#     })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)
# 



# Shiny app!

library(shiny)
library(tidyverse)

ui <- fluidPage(theme = "ocean.css",
                navbarPage("Impact of Stressors on Comercially Viable Fish Species",
                           tabPanel("Information on Species and Stressors",
                                    sidebarLayout(
                                      sidebarPanel("Learn more about species here:",
                                                   radioButtons(inputId = "pick_species",
                                                                      label = "Choose species:",
                                                                      choices = unique(starwars$species)
                                                   ),
                                                
                                      ),
                                      #sidebarPanel("Learn more about stressors here:",
                                       #             radioButtons(inputId = "pick_species",
                                        #                              label = "Choose stressor:",
                                         ##        ),
                                      #),
                                      mainPanel("OUTPUT!",
                                                plotOutput("sw_plot")
                                      )
                                    )
                           ),
                           tabPanel("Mapping Pollution Stress on Species"),
                           tabPanel("Summary Table")
                )
)

server <- function(input, output) {
  
  sw_reactive <- reactive({
    starwars %>%
      filter(species %in% input$pick_species)
  })
  
  output$sw_plot <- renderPlot(
    ggplot(data = sw_reactive(), aes(x = mass, y = height)) +
      geom_point(aes(color = species))
  )
  
}

shinyApp(ui = ui, server = server)
