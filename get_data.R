# Checking for and if needed creating the data folder
if(!dir.exists("./data")){
    dir.create("./data")
}    

# Checking for and if needed downloading the data,unzipping 548 MB
if(!file.exists("./data/Coursera_Swiftkey.zip")){
    print("No data present. Downloading datasets")
    
   get_url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
   download.file(get_url, "./data/Coursera_Swiftkey.zip")
   unzip("./data/Coursera_Swiftkey.zip", exdir = "./data")
} else{
    print("Data present")
}