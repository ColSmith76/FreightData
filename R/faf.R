#Script to analyze FAF data

#---------------------------------------------------------------------------------
#Load the data
#---------------------------------------------------------------------------------

#load the previously downloaded faf data from Rdata file -- will show message if not available
load("data/faf3.Rdata")
names(faf3)
# [1] "fr_orig"     "dms_orig"    "dms_dest"    "fr_dest"     "fr_inmode"   "dms_mode"   
# [7] "fr_outmode"  "sctg2"       "trade_type"  "value_2007"  "tons_2007"   "tmiles_2007"
# [13] "value_2015"  "value_2020"  "value_2025"  "value_2030"  "value_2035"  "value_2040" 
# [19] "tons_2015"   "tons_2020"   "tons_2025"   "tons_2030"   "tons_2035"   "tons_2040"  
# [25] "tmiles_2015" "tmiles_2020" "tmiles_2025" "tmiles_2030" "tmiles_2035" "tmiles_2040"

#convert to data.table and setkey
faf3 <- data.table(faf3)
setkey(faf3,dms_orig,dms_dest)

#load the FAF zone polygons for the US
load("data/faf3zone.Rdata")
names(faf3zone)
#[1] "ID" "AREA" "F3Z" "FIRST_F3Q" "F3_NAME" "METRO_REGI"

#zone 441 is coded as 440 in the od data
faf3zone$F3Z[faf3zone$F3Z==441] <- 440
#fortify zone layer so it can be mapped
faf3zonef <- fortify(faf3zone,region="F3Z")

#---------------------------------------------------------------------------------
# Plotting.
#---------------------------------------------------------------------------------

# Function that generates maps of zone to zone FAF flows. 

plotDIST <- function(FAFZone) {
  
  #for now, dms_orig to dms_dest showing tons_2007 hardcoded
  X <- faf3[dms_orig == FAFZone,list(tons_2007=sum(tons_2007)),by=dms_dest]
  m <- match(faf3zonef$id, as.character(X$dms_dest))
  
  faf3zonef$tons_2007 <- X[["tons_2007"]][m]
  faf3zonef$tons_2007[is.na(faf3zonef$tons_2007)] <- 0
  faf3zonef$Tons_2007 <- cut(faf3zonef$tons_2007
                       , breaks= c(0,1,10, 100, 1000, 1000000), 
                       labels = c("0","1 - 10","11 - 100", "101 - 1000", "1,001 or more"))
  
  # Origin FAF Zone. This is what is plotted in red.
  oFAF <- subset(faf3zonef, id == FAFZone)  
  
  # Labels for the title                         
  FAFLabel <- as.character(FAFZone)
  FAFName <- faf3zone$F3_NAME[faf3zone$F3Z==FAFZone]
  
  # Plotting code
  p <- ggplot() +
    #Destination FAF zones colored according to cut of tons
    geom_polygon(data = faf3zonef, aes(long, lat,group = group, fill = Tons_2007)) + 
    #Origin FAF zone colored red
    geom_polygon(data = oFAF, aes(long, lat, group = group), fill = "red") +
    #FAF zone boundaries (could replace with states boundaries)
    geom_path(data = faf3zonef, aes(long, lat, group = group), colour = "white", alpha = .5) +
    #limits for lower 48 states
    xlim(-135,-65) + 
    ylim(25,50) +
    scale_fill_brewer(palette = "Blues") +
    #coord_map(project = "lagrange") +
    labs(title = paste("FAF 3 Commodity Flow: 2007 Tons from", FAFName, "- FAF Zone", FAFLabel)) +
    xlab("Longitude") + ylab("Latitude") +
    theme(legend.position = "bottom", legend.direction = "horizontal")
  print(p)
}


# Plot a single map interactively.
plotDIST(100)
