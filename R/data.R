#Data Sources

#1. FAF 3 data
#--------------------------------------------------------------------------------------
#Full FAF 3 OD data -- download from http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4.zip
downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
                zipfilename="faf3_4.zip",
                datafilename="faf3.4_data",
                datafiletype="csv",
                objectname="faf3",
                outfilename="faf3.Rdata")

#2011 Provisional Data -- http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4_prov2011.zip
downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
                zipfilename="faf3_4_prov2011.zip",
                datafilename="faf3.4_provisional_2011",
                datafiletype="csv",
                objectname="faf34p2011",
                outfilename="faf34p2011.Rdata")

#FAF 3 Network, ESRI Format (shapefile)
downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/netwkdbflow/network/esri/",
                zipfilename="faf3_4_esri.zip",
                subfoldername="faf3_4_esri",
                datafilename="FAF3.4_Network",
                datafiletype="shp",
                objectname="faf3net",
                outfilename="faf3net.Rdata")

#FAF3 Regions Boundary Layer, ESRI Format (shapefile)
downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/netwkdbflow/regboundary/",
                zipfilename="faf3_zone_esri.zip",
                datafilename="FAF3-Zone",
                datafiletype="shp",
                objectname="faf3zone",
                outfilename="faf3zone.Rdata")
