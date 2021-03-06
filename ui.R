# setwd("/Users/weizhen/Desktop/Research/RNA\ methylation\ Target\ Database/5.\ Shiny_complete")
fluidPage(theme = "Yeti.css",
htmltools::div(align = "center",      
htmltools::div(style = "width:80%;", #class = "container"
htmltools::div(align = "left",
navbarPage(id = 'top.navbar',
           title = 'TREW',
  tabPanel('Query',
  h1("TREW: search epitranscriptomic targets of reader, eraser and writer"),
  hr(),
  
  div(
  h1("Gene Query", class = "panel-title") %>% div(class = "panel-heading"),
  div(
  textInput("gene", NULL, width = 600, placeholder = "Please input gene symbol."),
  actionButton("button", "Search",class = ""),
  actionButton("more", "More options"),
  checkboxInput('exact', 'Exact match', FALSE),
  conditionalPanel(
  condition = "input.more % 2 == 1",
  hr(),
  fluidRow(
    #Column 1#####################################
    column(3,
           selectInput("mod",
                       "Marks:",
                       c("All",unique(Table3$Modification)))
    ),
    #Column 2#####################################
    column(3,
           selectInput("pro",
                       "Regulators:",
                       c("All","Reader","Writer","Eraser",unique(Table3$Target)))
    ),
    #Column 3#####################################
    column(3,selectInput("spes",
                         "Species:",
                         c("All",unique(Table3$Species))
    )
    ),
    #Column 4#####################################
    column(3,selectInput("lift",
                         "Include liftover",
                         c("Yes","No")
    )
    )
  ),
  #Fluid row 2#====================================================================================================================================================
  fluidRow(
    #Column 1#####################################
    column(3,
           selectInput("rtyp",
                       "RNA types:",
                       c("All","mRNA","lncRNA","sncRNA","tRNA","miRNA")
           )
    ),
    #Column 2######################################
    column(3,
           selectInput("rreg",
                       "RNA regions:",
                       c("All","5'UTR","CDS","3'UTR","miRNA target sites")
           )
    ),
    #Column 3#####################################
    column(3,
           selectInput("celline",
                       "Cell lines:",
                       c("All","S2","Hek293T","MEF","Mouse 3T3L1","Mouse Mid Brain","A549","Hela Cell","Mouse ESC", "HEF")
           )
    ),
    #Column 4######################################
    column(3,
           selectInput("teq",
                       "Techniques:",
                       c("All",unique(Table3$Technique))
           )
    )
),
  #Fluid row 3#====================================================================================================================================================
  fluidRow(
    #Column 1#####################################
    column(3,
           selectInput("stat_sig",
                       "Statistical significance",
                       c("p < .05","p < .01","fdr < .05","fdr < .01","No filter")
           )
    ),
    #Column 2#####################################
    column(3,
           selectInput("consis",
                       "Consistency",
                       c("No filter","Consistent sites only")
                       
           )
    ),
    #Column 3######################################
    column(3,
           selectInput("motif",
                       "Motif restriction",
                       c("No filter","Motif restriction")
           )
    ),
    #Column 4######################################
    column(3,
           selectInput("stop",
                       "Stop codon restriction",
                       c("No filter","Near stop codon")
           )
    )
  ),
fluidRow(column(12, div(actionButton("reset.default", "Reset to default"),align = "right")))
),
class = "panel-body"
),
class = "panel panel-primary"
),

conditionalPanel(
condition = "input.button >= 1",
hr(),
div(
  h1("Query results", class = "panel-title") %>% div(class = "panel-heading"),
  div(
htmlOutput("Message1"),
htmltools::div(class="well", style = "height: 480px;",
               fluidRow(
                 #Tabel 1
                 column(12,
                        DT::dataTableOutput("table")
              )
       )
),
class = "panel-body"
),
class = "panel panel-primary"
)
),
#  Jbrowse     ============================================

conditionalPanel(
  condition = "input.button >= 1",
div(
  h1("Browser", class = "panel-title") %>% div(class = "panel-heading"),
  div(
  htmlOutput("Message2"),
htmltools::div(class="well",
  fluidRow(
    column(12,
      uiOutput(outputId = 'outJbrowse')
    )
  ),
  br(),
fluidRow(
  column(12,
         DT::dataTableOutput("table2")
  )
)
),
class = "panel-body"
),
class = "panel panel-primary"
)
),


#Fluid row 4#====================================================================================================================================================
conditionalPanel(condition = "input.button >= 1",
fluidRow(
  column(12,
         hr(),
         div(
           downloadButton('downloadData', 'Download all the results returned by the query (including those not selected).')
           ,align = "center")
  )
), 
br(),
HTML("<p align='center'>Xi'an Jiaotong-Liverpool University 2016 &copy; Copyright</p>")
)
),
tabPanel('Browser', includeMarkdown("browser.md")),
tabPanel('Help', includeMarkdown("documentation.md")),
tabPanel(value = 'dld','Download', includeMarkdown("documentation_download.md")),
tabPanel('Contact', includeMarkdown("documentation_contacts.md"))
# #==================================================End fluid Page===============================================================
)
)
)
)
)
