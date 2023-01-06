library(RSelenium)
library(tidyverse)
library(rvest)
library(janitor)
library(countrycode)
library(netstat)

# Country filter lists
clist_avail <- c("Antigua and Barbuda","Dominica","Grenada", "St. Kitts & Nevis", "St. Lucia","St. Vincent and the Grenadines", "Montserrat", "Anguilla")
clist_iso2c <- countrycode(clist_avail, "country.name", "iso2c")

current_year <- as.numeric(format(Sys.Date(), format="%Y")) - 1
end_date <- paste0(current_year, "-12-31")

# -----------

system("docker pull selenium/standalone-firefox", wait=TRUE)
Sys.sleep(5)
system("docker run -d --shm-size='2g' -p 4445:4444 selenium/standalone-firefox", wait=TRUE)
Sys.sleep(5)

# remDr <- remoteDriver("localhost", 4445L, "firefox")
remDr <- rsDriver(browser = "firefox", chromever = NULL, port = netstat::free_port())
remDr <- remDr[["client"]]

# remDr$open()
remDr$navigate("https://phptravels.com/demo")
remDr$navigate("https://www.eccb-centralbank.org/statistics/gdp-datas/comparative-report/1")
remDr$findElement(using = "xpath", value = "/html/body/div[2]/div[3]/div/div/div[2]/div[2]/div[2]/form/div[2]/div/div/div/div[3]/label")$clickElement()

remDr$findElement(using = "id", value = "start-date")$sendKeysToElement(list("2019-12-31"))
remDr$findElement(using = "id", value = "end-date")$sendKeysToElement(list(end_date))

remDr$findElement(using = "id", value = "statistics-select-all-countries")$clickElement()

remDr$findElements("css", ".form-buttom")[[1]]$clickElement()

# Give the page time to fully load
Sys.sleep(5)

html <- remDr$getPageSource()[[1]]

writeChar(html[[1]], "result.html")

# r <- read_html(html) %>% # parse HTML
#   html_nodes("body") %>%
#   html_text() %>%
#   toString()
# 
# data <- str_match_all(r,'td')
# data <- data[[1]]
# 
# gdp_dat <- gdp_dat %>% as.data.frame()
# 
# gdp_dat_tidy <- gdp_dat %>%
#   clean_names() %>%
#   .[-1,] %>%
#   mutate_if(is.numeric, as.character) %>%
#   pivot_longer(!c(country, category, units), names_to="year") %>%
#   mutate(year = parse_number(year),
#          country = countrycode(country, "country.name", "country.name"),
#          category = paste0("GDP in market prices (current EC$) (millions)"),
#          value = parse_number(value)) %>%
#   select(-units) %>%
#   drop_na()
# 
# 
# 
# # html <- remDr$getPageSource()
# 
# remDr$close()
# 
# writeChar(html[[1]], "result.html")
# 
# # url <- "https://www.eccb-centralbank.org/statistics/gdp-datas/comparative-report/1"
# # 
# # remDr$navigate(url)
# # 
# # remDr$findElement(using = "id", value = "categories-ids-ngdp_mc")$clickElement()
# # 
# # remDr$findElement(using = "id", value = "start-date")$sendKeysToElement(list("2019-12-31"))
# # remDr$findElement(using = "id", value = "end-date")$sendKeysToElement(list(end_date))
# # 
# # remDr$findElement(using = "id", value = "statistics-select-all-countries")$clickElement()
# # 
# # remDr$findElements("css", ".form-buttom")[[1]]$clickElement()