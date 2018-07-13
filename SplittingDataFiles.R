
##ABOUT: 
#This code was written to loop through large datafiles (.CSV in this case, but that can be changed) from a particular directory, split up each datafile according to the phase in the psychology task (specified by a particular column called "Phase" in the dataset), and save the data from each phase in a new folder with a new name. 

#Note that this can be modified to split large datasets up in a variety of ways. 
#I used a for loop here. I would also recommend doing something similar to this with lapply if you prefer lapply. 

#STEP 1- LOADING DATA
datapath <- "/Volumes/Mac HD/Users/hamme/Desktop/Raw Data/" #what folder the data is located in the directory
filenames <- list.files(datapath) #produce a character vector of the names of files in the datapath specified above; note that you can use the argument "pattern" and regular expression language in R to try to pick out files with specific names in the folder you are using. 

##STEP 2 - CREATE A DATAPATH FOR THE NEW, PARSED FILES
savepath.PreACQ <- "/Users/hamme/Desktop/Parsed Data/PreACQ/" #Phase 1 (PreACQ) data being stored here
savepath.ACQ <- "/Users/hamme/Desktop/Parsed Data/ACQ/" #Phase 2 (ACQ) data being stored here
savepath.GEN <- "/Users/hamme/Desktop/Parsed Data/GEN/" #Phase 3 (GEN) data being stored here

#FOR LOOP FOR PARSING OUT DATA FILES

install.packages("WriteXLS") #we will be using this package to write our datafiles
library(WriteXLS) 

for(i in 1:length(filenames)){ #for each data file specified in filenames: 
  dat <- read.csv(file=paste0(datapath,filenames[i]), header=T, sep = ",", row.names = NULL) #read the data file into .CSV, note you might need to change some of the arguments depending on the data you are uploading. Type in ?read.csv in to the console for more info. 
  name <- filenames[i] #assign the value of the current file name to the variable "name"; this will come into play down below
  
  #Parse Data based on the "Phase" column in the dataset; change as you wish. For more complex data parsing, I recommend using the "dplyr" package if you can. 
  dat.PreACQ <- dat[dat$Phase == "PreACQ",] #parse data into Phase 1 (PreACQ) only
  dat.ACQ <- dat[dat$Phase == "ACQ",] #parse data into Phase 2 (ACQ) only
  dat.GEN <- dat[dat$Phase == "Gen",] #parse data into Phase 3 (GEN) only
  
  #SAVING THE PARSED FILES
  #Create a File Name for the Data; we see the "name" object we specified above come into play again
  PreACQname <- paste0(savepath.PreACQ, name, "_PreACQ.csv") #print this out to see what it does with your own data
  ACQname <- paste0(savepath.ACQ, name, "_ACQ.csv")
  GENname <- paste0(savepath.GEN, name, "_GEN.csv")
  
  #Write the Data to a New File in Separate folders for PreACQ, ACQ, and GEN; note that sorting the datasets into separate folders actually comes from the names we gave above (e.g., "ACQname"), which has the file directory in them
  write.csv(dat.PreACQ, file = PreACQname, row.names = FALSE)
  write.csv(dat.ACQ, file = ACQname, row.names = FALSE) 
  write.csv(dat.GEN, file = GENname, row.names = FALSE)
}
