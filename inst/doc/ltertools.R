## ----knitr-mechanics, include = F---------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----pre-setup, echo = FALSE, message = FALSE---------------------------------
# devtools::install_github("lter/ltertools")

## ----setup--------------------------------------------------------------------
# devtools::install_github("lter/ltertools")
library(ltertools)

## ----harmony-prep-1-----------------------------------------------------------
# Generate two simple tables
## Dataframe 1
df1 <- data.frame("xx" = c(1:3),
                  "unwanted" = c("not", "needed", "column"),
                  "yy" = letters[1:3])
## Dataframe 2
df2 <- data.frame("LETTERS" = letters[4:7],
                  "NUMBERS" = c(4:7),
                  "BONUS" = c("plantae", "animalia", "fungi", "protista"))

# Generate a known temporary folder for exporting
temp_folder <- tempdir()

# Export both files to that folder
utils::write.csv(x = df1, file = file.path(temp_folder, "df1.csv"), row.names = FALSE)
utils::write.csv(x = df2, file = file.path(temp_folder, "df2.csv"), row.names = FALSE)

## ----harmony-prep-2-----------------------------------------------------------
# Generate a key that matches the data we created above
key_obj <- data.frame("source" = c(rep("df1.csv", 3), 
                                   rep("df2.csv", 3)),
                      "raw_name" = c("xx", "unwanted", "yy",
                                     "LETTERS", "NUMBERS", "BONUS"),
                      "tidy_name" = c("numbers", NA, "letters",
                                      "letters", "numbers", "kingdom"))
# Check that out
key_obj

## ----harmonize----------------------------------------------------------------
# Use the key to harmonize our example data
harmony <- ltertools::harmonize(key = key_obj, raw_folder = temp_folder, 
                                data_format = "csv", quiet = TRUE)

# Check the structure of that
utils::str(harmony)

## ----begin-key----------------------------------------------------------------
# Generate a column key with "guesses" at tidy column names
test_key <- ltertools::begin_key(raw_folder = temp_folder, data_format = "csv", 
                                 guess_tidy = TRUE)

# Examine what that generated
test_key

## ----expand-key---------------------------------------------------------------
# Make another simple 'raw' file
df3 <- data.frame("xx" = c(10:15),
                  "letters" = letters[10:15])

# Export this locally to the temp folder too
utils::write.csv(x = df3, file = file.path(temp_folder, "df3.csv"), row.names = FALSE)

# Identify what needs to be added to the existing column key
ltertools::expand_key(key = key_obj, raw_folder = temp_folder, harmonized_df = harmony,
                      data_format = "csv", guess_tidy = TRUE)

## ----read---------------------------------------------------------------------
# Read in all of the CSVs that we created above
data_list <- ltertools::read(raw_folder = temp_folder, data_format = "csv")

# Check the structure of that
utils::str(data_list)

## ----solar-day-info-----------------------------------------------------------
# Identify day information in Santa Barbara (California) for one week
solar_day_info(lat = 34.41, lon = -119.71, 
               start_date = "2022-02-07", end_date = "2022-02-12", 
               quiet = TRUE)

## ----cv-----------------------------------------------------------------------
# Calculate CV (excluding missing values)
ltertools::cv(x = c(4, 5, 6, 4, 5, 5), na_rm = TRUE)

## ----convert-temp-------------------------------------------------------------
# Convert some temperatures from F to Kelvin
convert_temp(value = c(0, 32, 110), from = "Fahrenheit", to = "k")

## ----site-timeline-1, fig.align = 'center', fig.height = 3, fig.width = 7-----
# Check the timeline for all grassland or forest LTER sites
ltertools::site_timeline(habitats = c("grassland", "forest"))

## ----site-timeline-2, fig.align = 'center', fig.height = 4, fig.width = 7-----
# Check the timeline for all LTER sites
ltertools::site_timeline()

