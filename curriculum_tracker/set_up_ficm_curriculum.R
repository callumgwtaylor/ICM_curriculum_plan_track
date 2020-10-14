library(RSelenium)
library(tidyverse)

remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")
remDr$open()

remDr$navigate("https://www.nhseportfolios.org/Auth/SitePages/Trainee/Default.aspx") #Entering our URL gets the browser to navigate to the page
remDr$screenshot(display = TRUE) #This will take a screenshot and display it in the RStudio viewer


#ePortfolio_username <- rstudioapi::askForPassword("ePortfolio username")
#ePortfolio_password <- rstudioapi::askForPassword("ePortfolio password")

ePortfolio_username <- "taylor3987"
ePortfolio_password <- "Taycafy20"
##

element <- remDr$findElement(using = 'css selector', "#ctl00_ctl00_cph1_BaseMaster_cph2_UserMaster_ucUserLoginBox_ePortfolioLogin_UserName")
element$sendKeysToElement(list(ePortfolio_username)) # What we've done here is load the username box and entered our username



##

element <- remDr$findElement(using = 'css selector', "#Password")
element$sendKeysToElement(list(ePortfolio_password))


##

element <- remDr$findElement(using = 'css selector', "#ctl00_ctl00_cph1_BaseMaster_cph2_UserMaster_ucUserLoginBox_ePortfolioLogin_LoginButton")
element$clickElement()
#remDr$screenshot(display = TRUE)
