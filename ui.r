library(shiny)

jscode <-
"
$(function() {
setTimeout(function(){
  $('#slider').data('ionRangeSlider').update({
        'prettify': function (num) { 
                if(num<=100) return(num);
                else if(num<200) return( (num-100)*100+100) ;
                else if(num<=249) return ( (num-199)*1000+10000); 
            }
      })

}, 7)})

"

shinyUI(fluidPage(

  tags$head(tags$script(HTML(jscode))),
  
  h3("Chaos Game in 2 Dimensiuni"),
  br(),
  fluidRow(
    column(4,
           # select shape
           selectizeInput('shape', h5(tags$b('Shape')), choices = list(
             "Two Dimensions" = c('Triangle' = 'tri',
                                  'Square' = 'sqr',
                                  'Hexagon' = 'hex',
                                  'Pentagon' = 'ptg',
                                  'Fern' = 'fern'
                                  )
           ), selected = 'tri'),
           
           #buton de randomize 
           div(actionButton("randomize", "Randomize"))
           
    ),    column(4,
                 sliderInput(inputId = "slider",
                             "Number of points (n):",
                             min = 1,
                             max = 249,
                             step = 1,
                             value = 1,
                             animate = animationOptions(interval = 1000))
    ),
    column(4,
           # shape select
           conditionalPanel(
             condition = "input.shape=='tri'",
             sliderInput("dist.tri",
                         label = p("Distance ratio to endpoint:"),
                         min = 0.01, max = .99, value = .50, step=.01),
                         align="left"),
           
           conditionalPanel(
             condition = "input.shape=='sqr'",
             sliderInput("dist.sqr",
                         label = p("Distance ratio to endpoint:"),
                         min = 0.01, max = .99, value = .50, step=.01),
                         align="left"),
           
           conditionalPanel(
             condition = "input.shape=='hex'",
             sliderInput("dist.hex",
                         label = p("Distance ratio to endpoint:"),
                         min = 0.01, max = .99, value = .67, step=.01),
                         align="left"),
           
           conditionalPanel(
             condition = "input.shape=='ptg'",
             sliderInput("dist.ptg",
                         label = p("Distance ratio to endpoint:"),
                         min = 0.01, max = .99, value = .50, step=.01),
             align="left"),
      
    )
  ),
  # plot
  div(
    div(
      plotOutput("plot", height="800px", width="800px"), inline="TRUE"),align="center")
  )
)