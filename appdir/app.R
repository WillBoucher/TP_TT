library(shiny)
library(leaflet)

ui <- fluidPage(
  leafletOutput("mymap")
)

server <- function(input, output, session) {
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(data = data.frame(lng = c(-75.1652), lat = c(39.9526)), radius = 10) %>%
      setView(lng = -75.1652, lat = 39.9526, zoom = 12)
  })
  
  observe({
    invalidateLater(1000) # 1000 milliseconds = 1 second
    
    # Generate a new random latitude and longitude
    new_lat <- runif(1, -90, 90)
    new_lng <- runif(1, -180, 180)
    
    # Update the marker's position
    leafletProxy("mymap") %>%
      clearMarkers() %>%
      addCircleMarkers(data = data.frame(lng = new_lng, lat = new_lat), radius = 10)
  })
}

shinyApp(ui, server)
