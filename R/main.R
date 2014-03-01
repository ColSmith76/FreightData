# FreightData
# Created 3/1/2014
# Author Colin Smith
#
# A repository of functions and scrpts to work  with various public freight data sources
# in R, including producing tabulations, charts, and maps to show and analyze freight 
# flows, the distribution of businesses that generate and attract freights flows, 
# and the movements on the vehicles that carry the freight. 
#
# This is primarily focused on US data sources, but includes global data where those 
# flows are to and from the USA.
#
# main.R controls overall workflow: running the complete script will source all other sciprts

#---------------------------------------------------------------------
# Set up scripts
#---------------------------------------------------------------------

# functions.R - load all the required utility functions for use in the project
source("./R/functions.R")

# load required R packages (download if they do not exist)
loadPackage("data.table")                                        
loadPackage("ggplot2")

# data.R - sources/download code for the datasets available online. Some large files so there are not in the repo
source("./R/data.R")

#---------------------------------------------------------------------
# Scripts for analyzing individual datasets
#---------------------------------------------------------------------

# faf3 data - freight analysis framework
source("./R/faf.R")
