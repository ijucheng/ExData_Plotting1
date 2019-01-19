library(dplyr)

# Get dataset

## download zip file
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata_data_household_power_consumption.zip"
## check file, if not exist tnen download file
if (!file.exists(zipFile)) { download.file(zipUrl, zipFile, mode = "wb") }
## unzip file containing data if data directory doesn't already exist
dataPath <- "exdata_data_household_power_consumption" 
txt_path <- if (!file.exists(dataPath)) { unzip(zipFile) }

## tableau name
df_header <- txt_path %>%
  readLines(n = 1) %>%
  strsplit(split = ";") %>%
  unlist() 

df <- read.table(txt_path, sep = ";", na.strings = "?", skip = 66637, nrows = 2880, stringsAsFactors = FALSE, col.names = df_header)
df$Date <- as.Date(df$Date, format = "%d/%m/%Y") # 轉換為日期型別
df$DateTime <- paste(df$Date, df$Time) %>% as.POSIXct()
household_power_consumption <- df




# plot3
plot(x = df$DateTime, y = df$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", bg = "transparent")
lines(x = df$DateTime, y = df$Sub_metering_2, col = "red")
lines(x = df$DateTime, y = df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.9)
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

