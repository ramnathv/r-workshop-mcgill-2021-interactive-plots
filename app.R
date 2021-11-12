## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    fluidRow(box(
      selectInput(
        'cuisine', 
        'Select Cuisine', 
        choices = unique(recipes$cuisine),
        selected = 'greek'
      ),
      
      # CODE BELOW: Add an input named "nb_ingredients" to select # of ingredients
      sliderInput(
        'nb_ingredients',
        'Select Number of Ingredients',
        min = 1,
        max = 20,
        value = 10
      )
    )
  )),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        title = "Table",
        DTOutput('dt_top_ingredients')
      )
    )
  )
)

server <- function(input, output) {
  output$dt_top_ingredients <- renderDT({
    recipes %>% 
      summarize_cuisine(
        selected_cuisine = input$cuisine,
        nb_ingredients = input$nb_ingredients
      )
  })
}

shinyApp(ui, server)
