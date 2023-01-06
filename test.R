library(RSelenium)

system("docker pull selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)
system("docker run -d --shm-size='2g' -p 4445:4444 selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)

# rD <- rsDriver(browser = "firefox", chromever = NULL, port = netstat::free_port())
# remDr <- rD[["client"]]

remDr <- remoteDriver("localhost", 4445L, "chrome")
remDr$open()

url5 <- "https://www.eccb-centralbank.org/statistics/debt-datas/comparative-report/2"

remDr$navigate(url5)

remDr$findElement(using = "id", value = "categories-ids-dgdpcg")$clickElement()

html <- remDr$getPageSource()

writeChar(html[[1]], "result.html")

