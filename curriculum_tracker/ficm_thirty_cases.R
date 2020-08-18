remDr$navigate("https://www.nhseportfolios.org/Auth/SitePages/Trainee/Curriculum/View.aspx?UserCurriculumId=686498&CurriculumItemId=39662")
Sys.sleep(5)
 


element <- remDr$findElement(using = 'css selector', "#ctl00_ctl00_cph1_BaseMaster_cph2_UserMaster_ucView_buttonsWrapper")
element$clickElement()
Sys.sleep(5)
 


thirtycase_html <- xml2::read_html(remDr$getPageSource()[[1]])

## NODES
thirtycase_items <- thirtycase_html %>%
  rvest::html_nodes(".node-leaf .nodeLayout") %>%
  rvest::html_text() %>%
  as_tibble_col()

circles <- thirtycase_html %>%
  rvest::html_nodes(".node-leaf img") %>%
  rvest::html_attrs() %>%
  flatten() %>%
  as.list() %>%
  as_tibble_col() %>%
  filter(str_detect(value, "Circle"))

thirtycases <- bind_cols(thirtycase_items, circles)

thirtycases <- thirtycases %>%
  rename(case = `value...1`,
         circle = `value...2`)
