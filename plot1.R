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


# plot1
## select data for 2007-02-01 and 2007-02-02
subdf <- subset(df, df$Date == "1/2/2007" | df$Date == "2/2/2007")

## make a plot
par(mfrow=c(1,1))
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", bg = "transparent")

## copy to file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

