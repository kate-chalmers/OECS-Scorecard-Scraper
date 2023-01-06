library(RSelenium)

system("docker pull selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)
system("docker run -d -p 4445:4444 --shm-size='2g' selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)

# rD <- rsDriver(browser = "firefox", chromever = NULL, port = netstat::free_port())
# remDr <- rD[["client"]]


remDr <- remoteDriver("localhost", 4445L, "chrome")
remDr$open()
print('line 14')
url5 <- "https://www.eccb-centralbank.org/statistics/debt-datas/comparative-report/2"
remDr$navigate(url5)
print('line 17')
remDr$findElement(using = "id", value = "categories-ids-dgdpcg")$clickElement()

# html <- remDr$getPageSource()
# 
# writeChar(html[[1]], "result.html")

