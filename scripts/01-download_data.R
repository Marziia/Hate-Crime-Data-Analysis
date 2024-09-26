#### Preamble ####
# Purpose: Downloads and saves the data from the Open Data Toronto Database
# Author: Marzia Zaidi
# Date: 26 September 2024
# Contact: Marzia.zaidi@mail.utoronto.ca
# License: MIT
# Pre-requisites: opendatatoronto, tidyverse, dplyr libraries installed
# Any other information needed? Name of the data set to be downloaded


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
nameOfDataSet <- "hate-crimes-open-data"

#### Download data ####
package <- show_package(nameOfDataSet)
package

# get all resources for this package
resources <- list_package_resources(nameOfDataSet)

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources

datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()


#### Save data ####
write_csv(data, "inputs/data/raw_data.csv") 

