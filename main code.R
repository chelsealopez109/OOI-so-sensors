# Extracted single wire-following profile from Ocean Observatories Initiative

library(plotly, dplyr)

data <- read.csv(url("https://erddap.dataexplorer.oceanobservatories.org/erddap/tabledap/ooi-gs02hypm-wfp03-01-flordl000.csv?time%2Cflubsct_profiler_depth_enabled%2Cz&time%3E%3D2015-02-20T02%3A02%3A00Z&time%3C%3D2017-11-30T21%3A57%3A00Z&z%3E%3D-4398&z%3C%3D-2201"))[-1,]
colnames(data) <- c("timestamp", "backscatter","depth")

data$year <- format(as.Date(as.Date.character(data[,1]), format = "%Y %m %d"), "%Y")
data$month <- format(as.Date(as.Date.character(data[,1]), format = "%Y %m %d"), "%m")
data$day <- format(as.Date(as.Date.character(data[,1]), format = "%Y %m %d"), "%d")

years <- unique(data$year)


data_by_year <- list()

for (i in 1:length(years)){
  data_by_year[[i]] <- subset(data, data$year == years[i])
}

names(data_by_year) <- years



feb2015 <- subset(data_by_year$`2015`, data_by_year$`2015`$month == "02")

plot_ly() %>%
  layout(
    yaxis = list(autorange = "reversed")
  ) %>%
  add_trace(x = feb2015$day, y = feb2015$backscatter, z = feb2015$depth)










