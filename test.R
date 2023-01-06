library(RSelenium)

system("docker pull selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)
system("docker run -d -p 4445:4444 selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)

remDr <- remoteDriver("localhost", 4445L, "chrome")
remDr$open()

url <- "https://www.eccb-centralbank.org/statistics/gdp-datas/comparative-report/1"

remDr$navigate(url)

remDr$findElement(using = "id", value = "categories-ids-ngdp_mc")$clickElement()

remDr$findElement(using = "id", value = "start-date")$sendKeysToElement(list("2019-12-31"))
remDr$findElement(using = "id", value = "end-date")$sendKeysToElement(list(end_date))

remDr$findElement(using = "id", value = "statistics-select-all-countries")$clickElement()

remDr$findElements("css", ".form-buttom")[[1]]$clickElement()
