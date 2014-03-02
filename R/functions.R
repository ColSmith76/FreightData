#Functions for use in the FreightData project

#Load all the required R libraries
#function to test whether a package is available and install prior to loading	
loadPackage <- function (package) {
	if(!package %in% .packages(all = TRUE)) {
		install.packages(package, repos = "http://cran.r-project.org")
	}
	eval(parse(text=paste0("require(", package, ")")))
}

#Define function to capitalize the first letter of a word
toProperName <- function(X){
  EndX <- nchar(X)
  paste(toupper(substring(X, 1, 1)), tolower(substring(X, 2, EndX)), sep="")
}

#function to capitalize the first letter of words in a multi word string
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), tolower(substring(s, 2)),
        sep="", collapse=" ")
}

#function to download a zip file containing data in csv or shp format from the web to the /data folder, read it into a data frame/spatial format
#save that to an Rdata file for later use and then remove from workspace

#Example call
#2011 Provisional Data -- http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4_prov2011.zip
# downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
#                 zipfilename="faf3_4_prov2011.zip",
#                 datafilename="faf3.4_provisional_2011"
#                 datafiletype="csv",
#                 objectname="faf34p2011",
#                 outfilename="faf34p2011.Rdata",
#                 subfoldername="",
#                 overwrite=TRUE)

downloadsavezip <- function(website,zipfilename,datafilename,datafiletype,objectname,outfilename,subfoldername="",overwrite=FALSE){
  #create the data folder if it doesn't exist -- function hardcoded to download to /data
  if(!file.exists("data")) dir.create("data")
  #check if we already have downloaded and processed this file
  #or if we should download and ovewrite anyway
  if( !file.exists( file.path("data",outfilename)) | overwrite==TRUE ) {
    download.file(paste0(website, zipfilename),file.path("data",zipfilename),"auto")
    if(datafiletype=="csv"){
      #read in data from zip file (slow!) 
      assign(objectname,read.csv(unz(file.path(getwd(),"data",zipfilename),paste(datafilename,datafiletype,sep="."))))
    }
    if(datafiletype=="shp"){
      #upzip date and then read shape file, and save to an Rdata file for future use
      unzip(file.path(getwd(),"data",zipfilename),exdir="data")
      dsnpath <- file.path(getwd(),"data")
      if(subfoldername != "") dsnpath<-file.path(dsnpath,subfoldername)
      assign(objectname,readOGR(dsn=dsnpath,datafilename))
    }
    if(datafiletype %in% c("csv","shp")){
      #save to an Rdata file for future use  
      save(list=objectname,file=file.path("data",outfilename))
      rm(list=objectname)
      print(paste(paste0(website, zipfilename), "saved as", outfilename))
    } else {
      print("Filetypes that are currently support for import from downloaded zip files are csv and shp")
    }  
  } else {
    #if it was already there and told to not overwrite
    print(paste(paste0(website, zipfilename), "was previously downloaded and saved as", outfilename,"- to download again set overwrite=TRUE"))
  }
}

