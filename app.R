source('server/index.R', local = TRUE)
source('ui/index.R', local = TRUE)

# Run the app 
shinyApp(ui = ui, server = server)
