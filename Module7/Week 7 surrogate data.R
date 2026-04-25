#set working directory
setwd('/Users/sterrevanderjagt/Documents/Data_Science/DSS blok 3/Complex systems/Complex_systems_group1-main/Module7')

#packages
library(dplyr)
library(pracma)

# Turn off scientific notation
options(scipen = 999)

#data 
df <- read.csv("etmgeg_260.txt", skip = 51, sep = ",")
df <- df[, c("YYYYMMDD", "TG", "TX", "TN")]
df$TG <- df$TG / 10
df$TX <- df$TX / 10
df$TN <- df$TN / 10
df$YYYYMMDD <- as.Date(as.character(df$YYYYMMDD), format = "%Y%m%d")

df <- df[df$YYYYMMDD >= as.Date("1980-01-01") &
           df$YYYYMMDD <= as.Date("2000-01-01"), ]

#basic plot
plot(df$YYYYMMDD, df$TG, type = "l",
     xlab = "Time (years)", ylab = "Temperature",
     main = "Daily average temperature")

# surrogate testing
monthly_mean <- ave(df$TG, format(df$YYYYMMDD, "%m"))
df$tg_detrended <- df$TG - monthly_mean # no missings

plot(df$tg_detrended, type = "l",
     xlab = "Time (days)",
     ylab = "Standardized temperature anomaly",
     main = "Detrended Temperature")

df$tg_station <- (df$tg_detrended - mean(df$tg_detrended)) / sd(df$tg_detrended)

plot(df$tg_station, type = "l",
     xlab = "Time (days)",
     ylab = "Standardized temperature anomaly",
     main = "Z-scored detrended temperature")

TG_SampEn <- sample_entropy(df$tg_station, edim = 2, r = 0.2 * sd(df$tg_station), tau = 1)
TG_SampEn

set.seed(240426)
rand_surr_tg_station_20 <- replicate(50, sample(df$tg_station, replace = FALSE))
rand_surr_tg_station_SampEn_20 <- apply(rand_surr_tg_station_20, MARGIN=2, 
                                        FUN = pracma::sample_entropy, 
                                        edim=2,r=0.2*sd(rand_surr_tg_station_20[,1]),tau=1)


mean_surr <- mean(rand_surr_tg_station_SampEn_20)
n_surr <- length(rand_surr_tg_station_SampEn_20)
sd_surr <- sd(rand_surr_tg_station_SampEn_20)
error <- qt(.975, df = n_surr - 1) * sd_surr/sqrt(n_surr)
CI <- c(lower = mean_surr - error, mean = mean_surr, upper = mean_surr + error)
CI 

acf(df$tg_station,
    main = "Autocorrelation of Detrended Temperature",
    xlab = "Lag (days)",
    ylab = "Autocorrelation")

#block shuffel
block_shuffle <- function(x, block_size = 14) {
  n <- length(x)
  n_blocks <- floor(n / block_size)
  blocks <- split(x[1:(n_blocks * block_size)],
                  rep(1:n_blocks, each = block_size))
  shuffled_blocks <- sample(blocks)
  shuffled <- unlist(shuffled_blocks)
  return(shuffled)
}

block_surr <- replicate(50, block_shuffle(df$tg_station, block_size = 14))
block_sampen <- apply(block_surr, MARGIN=2, 
                      FUN = pracma::sample_entropy, 
                      edim=2,r=0.2*sd(block_surr[,1]),tau=1)

mean_surr_block <- mean(block_sampen)
n_surr_block <- length(block_sampen)
sd_surr_block <- sd(block_sampen)
error_block <- qt(.975, df = n_surr_block - 1) * sd_surr_block/sqrt(n_surr_block)
CI_block <- c(lower = mean_surr_block - error_block, mean = mean_surr_block, upper = mean_surr_block + error_block)
CI_block

