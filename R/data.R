#Data Sources

#1. FAF 3 data
#--------------------------------------------------------------------------------------
#Full FAF 3 OD data -- download from http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4.zip
downloadsavezip("http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
                "faf3_4.zip",
                "faf3.4_data.csv",
                "faf3",
                "faf3.Rdata")

#2011 Provisional Data -- http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4_prov2011.zip
downloadsavezip("http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
                "faf3_4_prov2011.zip",
                "faf3.4_provisional_2011.csv",
                "faf34p2011",
                "faf34p2011.Rdata")