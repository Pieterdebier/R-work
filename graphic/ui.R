#library(shinythemes)
source('html.R')
shinyUI(navbarPage( 
"Global Temperature Explorer", #theme= shinytheme("cerulean"),
# ----- 1 ---------------------------------------                   
                   
                   tabPanel("Welcome", 
                            mainPanel(
                              HTML(welcome_page)
                            )), 
# ----- 2. 1 ---------------------------------------                                    
tabPanel("Tutorial", 
         navlistPanel(
           id = "SbS",
           "Steps in this Tutorial",
           tabPanel("1. Select the data source",
                    mainPanel(
                      HTML(tutorial1.1)
                      , fluidRow(
                        column(3, wellPanel(
                          selectInput("data.keuze2", 
                                      label = "",
                                      choices = c("GISS", "NOAA",
                                                  "HADcrut", "JMA", "C&W", "Combined", "CRUTEM (land)", "GISS (land)"
                                                  , "RSS (satellite)", "UAH (satellite)", "BEST", "Hadcrut-3"
                                                  ,  "UAH (beta 6.0)"),
                                      selected = "GISS")                                                                              
                          , HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")                                             
                          , sliderInput("x.lim2", "Range of years", 1850, 2016, value = c(1880, 2015), round= TRUE, sep="", step=1, ticks=FALSE)                                
                          , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                          , sliderInput("y.lim2", "Vertical axis", -1.4, 0.8, value = c(-1.1, 0.6), sep=".",step=0.1, ticks=FALSE)                                
                          , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                          , sliderInput("smooth.keuze2", "Show avg.'ed", 0, 120, step=3, value = 0, round=TRUE)
                          , HTML("</div>")
                        )
                        )
                        , column(9 , plotOutput("map2", height = 420, width=640)
                        )
                      )                      
                      , HTML(tutorial1.2)                      
                    )),
# ----- 2. 2a ---------------------------------------                                            
tabPanel("2. Influence of CO2 levels",
         mainPanel(                      
           HTML(tutorial2.1)
           
           , fluidRow(
             column(3, wellPanel(
               HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
                , sliderInput("start.year2", "Regression Period", 1850, 2015, value = c(1850, 2015), round= TRUE, sep="", step=1, ticks=FALSE)                                
                , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                , sliderInput("smooth.keuze.b2", "Smooth Data", 0, 120, value = 0, round=TRUE, step=3)
                , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                , radioButtons("trend2", "Fit with:",
                               c("co2" = "co2", "line" = "linear"), selected="linear")
                , HTML("</div>")
               )
             )
             ,column(9, plotOutput("map3", height = 420, width=640)
             )        
             )                                          
           , HTML(tutorial2.2)
         )),
# ----- 2. 2b ---------------------------------------                                            
# tabPanel("2b. Confidence and predictability",
#          mainPanel( h5("Confidence and predictablitity")
#                     , plotOutput("bmap3", height = 420, width=640)
#                     , fluidRow(
#                       column(4, checkboxInput("bcb3", "Show CO2 levels", value=TRUE)
#                       )
#                       ,column(4, checkboxInput("bcb3b", "Show Confidence Int.", value=TRUE)
#                       )
#                       , column(4, sliderInput("bco3", "Earth Inertia to CO2", 0, 150, value = 0, round=TRUE) 
#                       )
#                     )
#                     , fluidRow(
#                       column(6, sliderInput("bstart.year2", "Regression Period", 1880, 2014, value = c(1880, 2014), format = "####.##", )                                
#                              
#                       )
#                       , column(6, sliderInput("bsmooth.keuze.b2", "Smooth Data", 0, 60, value = 0, round=TRUE)
#                                
#                       )
#                     ), HTML(tutorial2.3)                    
#          )),                     
"-----",
# ----- 2. 3 ----------------------------------------                                            
tabPanel("3. Sunshine and Aerosols"
         ,mainPanel(                                              
           HTML(tutorial3.1)
           , fluidRow( 
             column(3, wellPanel(
               HTML("<h5>Lags in Months</h5><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb31", "Sun", value=FALSE)
               , sliderInput("sl31", "", 0, 12, value=3, round=TRUE, step=1, ticks=FALSE)
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb32", "Volcanoes", value=FALSE)
               , sliderInput("sl32", "", 0, 12, value=8, round=TRUE, step=1, ticks=FALSE)
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb33", "Day Length", value=FALSE)
                , sliderInput("sl33", "", 0, 100, value=78, round=TRUE, step=1) 
                , HTML("</div>")
                
             )
             )
             , column(9 , plotOutput("map4", height = 420, width=640)
             )
           )
           , HTML(tutorial3.2)
         )),
# ----- 2. 4 ----------------------------------------                                            
tabPanel("4. Ocean Oscillations", mainPanel(
  HTML(tutorial4.1)
  , fluidRow( 
    
    column (3, wellPanel(
      HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
      , checkboxInput("cb41", "ENSO", value=FALSE)
      , sliderInput("sl41", "", 0, 12, value=3, round=TRUE, step=1)
      , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
      , checkboxInput("cb42", "AMO", value=FALSE)
      , sliderInput("sl42", "", 0, 12, value=0, round=TRUE, step=1)
      , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
      , checkboxInput("cb43", "PDO", value=FALSE)
      , sliderInput("sl43", "PDO", 0, 12, value=0, round=TRUE, step=1)
      , HTML("</div>")
      
    ))
    , column(9, plotOutput("map5", height = 420, width=640)
    )
  )
  
  ,HTML(tutorial4.2)
)),
# ----- 2. 5 ----------------------------------------                                            
tabPanel("5. Planet System", mainPanel(
  HTML(tutorial5.1)
  
  , fluidRow( 
    column(3, wellPanel(
      checkboxInput("cb52", "Seasons", value=FALSE), 
      h5("Planet Cycles"),
      checkboxGroupInput("boxID2", "", 
                         c("Saros" = "1",                                          
                           "Lunar 1" = "2",
                           "Lunar 2" = "3", 
                           "Jupiter" = "4", 
                           "Tidal" = "5")
                         , inline = FALSE)
      ))
    , column(9, plotOutput("map6", height = 420, width=640))
  ),
  HTML(tutorial5.2)                 
)),
"-----",
# ----- 2. 6 ----------------------------------------                                            
tabPanel("6. All Combined"
         , mainPanel(
           HTML(tutorial6.1)
           , plotOutput("map7", height = 420, width=640)
           , fluidRow(
             column(4, wellPanel(
               selectInput("data.keuze6", 
                           label = "",
                           choices = c("GISS", "NOAA",
                                       "HADcrut", "JMA", "C&W", "Combined", "CRUTEM (land)", "GISS (land)"
                                       , "RSS (satellite)", "UAH (satellite)", "BEST", "Hadcrut-3"
                                       , "UAH (beta 6.0)"),
                           selected = "GISS")                                                                              
               , HTML("<h5>Appearance</h5><div style='border: 1px solid lightgrey; padding:5px;'>")                                             
               , sliderInput("x.lim6", "Range of years", 1850, 2016, value = c(1850, 2015), round= TRUE, sep="", step=1, ticks=FALSE)                                
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , sliderInput("y.lim6", "Vertical axis", -1.4, 0.8, value = c(-1.1, 0.6), sep=".", ticks=FALSE, step=0.1)                                
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , sliderInput("smooth.keuze6", "Show avg.'ed", 0, 120, step=3, value = 0, round=TRUE)
               , HTML("</div>")
               
               ))
             , column(4, wellPanel(
               HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
               , sliderInput("start.year6", "Regression Period", 1850, 2015, value = c(1850, 2015), round= TRUE, sep="", step=1, ticks=FALSE)                                
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , sliderInput("smooth.keuze.b6", "Smooth Data", 0, 120, value = 0, round=TRUE, step=3)
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , radioButtons("trend6", "Fit with:",
                              c("co2" = "co2", "line" = "linear"), selected="co2")
               , HTML("</div>")
               
               ))
             , column(4, wellPanel(
               HTML("<h5>Lags in Months</h5><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb61", "Sun", value=TRUE)
               , sliderInput("sl61", "", 0, 12, value=3, round=TRUE, step=1, ticks=FALSE)
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb62", "Volcanoes", value=TRUE)
               , sliderInput("sl62", "", 0, 12, value=6, round=TRUE, step=1, ticks=FALSE)
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb63", "Day Length", value=TRUE)
               , sliderInput("sl63", "", 0, 100, value=78, round=TRUE, step=1, ticks=FALSE) 
               , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
               , checkboxInput("cb64", "ENSO", value=TRUE)
               , sliderInput("sl64", "", 0, 12, value=3, round=TRUE, step=1, ticks=FALSE)
               , HTML("</div>")
               
               ))
             )
       

           , HTML(tutorial6.2)
         )),
# --- plus the rest -------

well= TRUE, widths = c(3, 9)
         )

),
# ----- 3 ---------------------------------------                   
                   tabPanel("Applet",
                            fluidRow(
                              column(2, wellPanel(
                                HTML("<h5>Data Source:</h5>")                              
                                , selectInput("data.keuze", 
                                              label = "",
                                              choices = c("GISS", "NOAA",
                                                          "HADcrut", "JMA", "C&W", "Combined", "CRUTEM (land)", "GISS (land)"
                                                          , "RSS (satellite)", "UAH (satellite)", "BEST", "Hadcrut-3"
                                                          ,  "UAH (beta 6.0)"),
                                              selected = "GISS") 
                              ), wellPanel(
                                checkboxInput("cbi001", "Viewing Options"),
                                conditionalPanel( condition = "input.cbi001 == true", 
                                                  HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
                                                  , sliderInput("x.lim", "Range of years", 1850, 2016, value = c(1850, 2016), round= TRUE, sep="", step=1, ticks=FALSE)                                
                                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                  , sliderInput("y.lim", "Vertical axis", -1.4, 0.8, value = c(-1.1, 0.6), sep=".", step=0.1, ticks=FALSE)                                
                                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                  , sliderInput("smooth.keuze", "Set Smoothing Span", 0, 120, value = 0, round=TRUE, step=1, ticks=FALSE)
                                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")                                                  
                                                  , checkboxInput("cb00a", "Show Regression Fit", value=TRUE)
                                                  , checkboxInput("cb00b", "Show Confidence Interval", value=TRUE)
                                                  , HTML("</div>")
                                )
                              ), wellPanel(
                                checkboxInput("cbi002", "Regression Options"),
                                conditionalPanel( condition = "input.cbi002 == true" 
                                                  , HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
                                                  , sliderInput("start.year", "Regression Period", 1850, 2016, value = c(1850, 2016), round= TRUE, sep="", step=1, ticks=FALSE)                                
                                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                  , sliderInput("smooth.keuze.b", "Smoothing Span", 0, 120, value = 0, round=TRUE, step=1, ticks=FALSE)
                                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                  , radioButtons("trend", "Trend type:",
                                                                 c("co2 + other ghg" = "co2", "linear" = "linear", "spline" = "spline"), selected="co2")
                                                   , HTML("</div>")
                                ))
                                , wellPanel(
                                   checkboxInput("cbi004", "Options Oceanic influences"),
                                   conditionalPanel( condition = "input.cbi004 == true" 
                                                     , HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
                                                     , checkboxInput("cba001", "ENSO", value=TRUE)
                                                     , sliderInput("ens.lag", "", 0, 12, value=3, round=TRUE, step=1, ticks=FALSE)
                                                     , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                     , checkboxInput("cba002", "AMO", value=TRUE)
                                                     , sliderInput("amo.lag", "", 0, 12, value=6, round=TRUE, step=1, ticks=FALSE)
                                                     , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                     , checkboxInput("cba003", "PDO", value=FALSE)
                                                     , sliderInput("pdo.lag", "", 0, 12, value=1, round=TRUE, step=1, ticks=FALSE)
                                                     , HTML("</div>")
                                   )), wellPanel(
                                      checkboxInput("cbi005", "Options Planetary influences"),
                                      conditionalPanel( condition = "input.cbi005 == true"
                                                        , HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
                                                        , checkboxInput("cb02", "Seasons", value=TRUE)
                                                        , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                        , checkboxGroupInput("boxID", "", 
                                                                             c("Saros" = "1",                                          
                                                                               "Lunar 1" = "2",
                                                                               "Lunar 2" = "3", 
                                                                               "Jupiter" = "4", 
                                                                               "Tidal" = "5")
                                                                             , inline = FALSE)
                                                        , HTML("</div>")                                                               
                                      )
                               #
                              )), column(2
                                         , wellPanel(
                                           checkboxInput("cbi003", "Major options", value=TRUE),
                                           conditionalPanel( condition = "input.cbi003 == true", 
                                                             h5("Set Inertia (lag in months):")
                                                             , HTML("<div style='border: 1px solid lightgrey; padding:5px;'>")
                                                             , sliderInput("co2.lag", "CO2-levels", 0, 140, value=123, round=TRUE, step=1, ticks=FALSE)
                                                             , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                             , checkboxInput("cba004", "Sun Irradiance", value=TRUE)
                                                             , sliderInput("ssp.lag", "", 0, 12, value=3, round=TRUE, step=1, ticks=FALSE)
                                                             , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                             , checkboxInput("cba005", "Volcanic Aerosols", value=TRUE)
                                                             , sliderInput("vol.lag", "", 0, 12, value=6, round=TRUE, step=1, ticks=FALSE)
                                                             , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
                                                             , checkboxInput("cba006", "Lenghts of Day", value=TRUE)
                                                             , sliderInput("lod.lag", "", 0, 120, value=78, round=TRUE, step=1, ticks=FALSE) 
                                                             , HTML("</div>")
                                           )
                                         ), wellPanel(
                                           checkboxInput("cbi006", "Download Settings", value=FALSE),
                                           conditionalPanel( condition = "input.cbi006 == true", 
                                                             h5("Filename (.png):"),
                                                             textInput("fname", "", "ThisGraph"), 
                                                             radioButtons("size006", "Size:",
                                                                            c("450 x 300" = "450 x 300", "800 x 533" = "800 x 533", "1200 x 800" = "1200 x 800"), selected="800 x 533")
                                                             
                                           )                 
                                         ), wellPanel(
                                           checkboxInput("cbi007", "Filter Settings", value=FALSE),
                                           conditionalPanel( condition = "input.cbi007 == true", 
                                                             radioButtons("smoother", "Smoothing algorithm",
                                                                            c("Cubic Savitzky-Golay" = "Golay", "Loess" = "Loess"))
                                                             ,radioButtons("deseas", "De-seasoning algorithm",
                                                                          c("Sine filter" = "sine", "STL filter" = "stl"))
                                                             
                                                             
                                           )                 
                                         ), wellPanel(HTML("<p>To open an options subpanel check its' box.</p>"))
                                         ), 
                              column(8, 
                                     HTML("<h5>Explore the factors that influence the Global Surface Temperature</h5><p>
                                     To instantly change the diagram, use the sliders and buttons from the side bars.
                                     For instructions use the Step by Step Tutorial.</p><hr>")               
                                     , plotOutput("map", height = 533, width=800)
                                     , HTML("<hr>")
                                     , downloadButton(outputId="down", label="Download this graph")
                              )
                            )
                   )
# ----- 4 ---------------------------------------
                   ,tabPanel("Details", 
                             navlistPanel(
                               id = "Details",
                               "Details",
                               tabPanel("1. Sources",
                                        mainPanel(
                                          h5("Sources")
                                          , tableOutput("Sources")
                                          , HTML(details_page1)
                                          
                                        ))
                               , tabPanel("2. Maths",
                                          mainPanel(
                                            HTML(details_page2))
                                          
                               )))
# ----- 5 ---------------------------------------
#                    ,tabPanel("Forecast", 
#                              fluidRow(
#                                column(2, wellPanel(
#                                  selectInput("data.keuze.fc", 
#                                              label = "",
#                                              choices = c("GISS", "NOAA",
#                                                          "HADcrut", "JMA", "C&W", "Combined", "CRUTEM (land)", "GISS (land)"
#                                                          , "RSS (satellite)", "UAH (satellite)", "BEST", "Hadcrut-3"),
#                                              selected = "GISS")                                                                              
#                                  , HTML("<h5>Appearance</h5><div style='border: 1px solid lightgrey; padding:5px;'>")                                             
#                                  , sliderInput("x.lim.fc", "Range of years", 1850, 2100, value = c(1850, 2050), round= TRUE, sep="", step=1, ticks=FALSE )                                
#                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
#                                  , sliderInput("y.lim.fc", "Vertical axis", -1.5, 3, value = c(-1.1, 2), sep=".", step=0.1, ticks=FALSE)                                
#                                  , HTML("</div>")
#                                  , HTML("<h5>Regression</h5><div style='border: 1px solid lightgrey; padding:5px;'>")                                             
#                                  , sliderInput("start.year.fc", "Range of years", 1850, 2016, value = c(1850, 2015), round= TRUE, sep="", step=1, ticks=FALSE)                                
#                                  , HTML("</div><div style='border: 1px solid lightgrey; padding:5px;'>")
#                                  , sliderInput("smooth.keuze.b.fc", "Smoothing factor", 0, 120, , step=1, ticks=FALSE, value = 0, round=TRUE)
#                                  , HTML("</div>")                                 
#                                )
#                                ), column(2, wellPanel(
#                                     HTML("<h5>Note</h5><p>This forecast / prediction page is still under development.
#                                     Basically it just uses the regression slope of the CO2, some of the known data from the time series and some calculated uncertainties.
#                                     </p>
#                                     <p> So it is not very useful yet, but it gives you something to play with. Changing and / or setting
#                                          other options will be added when the full applet is more stable.</p>"))
#                                ), column(8,
#                                       h5("Forecast"),
#                                       HTML("<p>To instantly change the diagram, use the sliders and buttons from the side bars.
#                                            </p><hr>"),               
#                                       plotOutput("map.fc", height = 550, width=800),
#                                       #                 HTML(paste0("<b>TCR = ", textOutput("tcr", inline=TRUE), "</b>")),
#                                       HTML("<hr>")
#                                       , downloadButton(outputId="down2", label="Download this graph")
#                                       
#                                       
#                                )
#                              )
#                    )
                   
))