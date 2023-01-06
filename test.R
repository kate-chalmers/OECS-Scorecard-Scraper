library(RSelenium)

system("docker pull selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)
system("docker run -d -p 4445:4444 --shm-size='2g' selenium/standalone-chrome", wait=TRUE)
Sys.sleep(5)

# rD <- rsDriver(browser = "firefox", chromever = NULL, port = netstat::free_port())
# remDr <- rD[["client"]]

remDr <- remoteDriver("localhost", 4445L, "chrome")
remDr$open()

url <- "https://www.eccb-centralbank.org/statistics/gdp-datas/comparative-report/1"

remDr$navigate(url)

remDr$findElement(using = "id", value = "categories-ids-ngdp_mc")$clickElement()

