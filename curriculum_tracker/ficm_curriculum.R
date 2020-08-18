element <- remDr$findElement(using = 'css selector', "#navBarContainer > div.navbar-collapse.collapse > ul > li:nth-child(2) > a")
element$clickElement()

 

remDr$navigate("https://www.nhseportfolios.org/Auth/SitePages/Trainee/Curriculum/View.aspx?UserCurriculumId=686497&CurriculumItemId=27605")
 

##

# Now we've got to the curriculum page!
Sys.sleep(5)
 


element <- remDr$findElement(using = 'css selector', "#ctl00_ctl00_cph1_BaseMaster_cph2_UserMaster_ucView_buttonsWrapper")
element$clickElement()

 

Sys.sleep(5)

##

curriculum_html <- xml2::read_html(remDr$getPageSource()[[1]])

## NODES
curriculum_items <- curriculum_html %>%
  rvest::html_nodes(".rateable .nodeLayout") %>%
  rvest::html_text() %>%
  as_tibble_col()

circles <- curriculum_html %>%
  rvest::html_nodes("#mainContainer img") %>%
  rvest::html_attrs() %>%
  flatten() %>%
  as.list() %>%
  as_tibble_col() %>%
  filter(str_detect(value, "Circle"))

curriculum <- bind_cols(curriculum_items, circles)

curriculum <- curriculum %>%
  rename(competency = `value...1`,
         circle = `value...2`)

