# THIS SKRIPT GENERATES MISSING VALUES IN THE SPECIFIED DATASETS
# THERE ARE FOUR FUNCTIONS: TWO REPLACE VALUES WITH NA, THE OTHERS REPLACE NA WITH MEAN PER CLASS OR MEAN OVERALL
# EACH FUNCTION CREATES A NEW FILE (LIKE THE FILES IN THIS FOLDER) 
# REFER TO THE BOTTOM FOR METHOD CALLS

#replaces "percent" amount of file with NA
replaceRandom <- function(percentMissing, newfilename) {
  # data with unnecessary columns removed (from preprocessing)
  data = read.csv("2cardiotocography_processed.csv");
  rows = dim(data)[1];
  cols = (dim(data)[2]-1);
  numNA = floor(rows*cols*(percentMissing/100));
  index = 0;
  #calculate amount of values to be replaced and then pick randomly values to replace them
  repeat{
    randRow = sample(1:rows, 1);
    randCol = sample(1:cols, 1);
    if(! is.na(data[randRow, randCol])) {
      index = index + 1;
      data[randRow, randCol] = NA;
    }
    if(numNA == index){
      break;
    }
  }
  #write result to a new file
  write.csv(data, newfilename, row.names = FALSE);
  return(data);
}
#replaces certain attributes with missin values
replaceAttributes <- function(percentMissing, attributeNumber, newfilename) {
  # data with unnecessary columns removed (from preprocessing)
  data = read.csv("2cardiotocography_processed.csv");
  rows = dim(data)[1];
  numNA = floor(rows*(percentMissing/100));
  index = 0;
  #calculate amount of values to be replaced and then pick randomly values to replace them
  repeat{
    randRow = sample(1:rows, 1);
    if(! is.na(data[randRow, attributeNumber])) {
      index = index + 1;
      data[randRow, attributeNumber] = NA;
    }
    if(numNA == index){
      break;
    }
  }
  #write result to a new file
  write.csv(data, newfilename, row.names = FALSE);
  return(data);
}

replaceWithMeanByClass <- function(data, newfilename) {
  #iterate through all columns and replace NA by respective column by class mean
  for(i in 1:ncol(data)){
    for(c in 1:10) {
      #this loop iterates through all classes we have
      #this boolean operator subsets columns: select NA and current class, replace with corresponding mean per class
      data[is.na(data[,i]) & data[,22] == c, i] <- mean(data[which(data[,22] == c),i], na.rm = TRUE)
    }
  }
  #write result to a new file
  write.csv(data, newfilename, row.names = FALSE);
  return(data);
}

replaceWithMeanOverall <- function(data, newfilename) {
  #iterate through all columns and replace NA by respective column mean
  for(i in 1:ncol(data)){
    #select NA columns, replace with column mean
    data[is.na(data[,i]), i] <- mean(data[,i], na.rm = TRUE)
  }
  #write result to a new file
  write.csv(data, newfilename, row.names = FALSE);
  return(data);
}

# CREATE THE 

# A CREATE MISSING VALUE DATASETS FOR ASSIGNMENT

# Create missing values for Attributes XX and XX
r1 = replaceAttributes(10, 18, "a_missing_1_1_Attr_Mean_0.1.csv");
r2 = replaceAttributes(50, 18, "a_missing_1_2_Attr_Mean_0.5.csv");
r3 = replaceAttributes(10, 16, "a_missing_1_3_Attr_Nzeros_0.1.csv");
r4 = replaceAttributes(50, 16, "a_missing_1_4_Attr_NZeros_0.5.csv");


#create low missing numbers across all attributes
r5 = replaceRandom(5, "a_missing_2_1_AllAttributes_0.05.csv")
r6 = replaceRandom(33, "a_missing_2_2_AllAttributes_0.33.csv")

# B REPLACE WITH OVERALL MEAN OF COLUMN
replaceWithMeanOverall(r1, "b_overallMean_1_1_Attr_Mean_0.1.csv")
replaceWithMeanOverall(r2, "b_overallMean_1_2_Attr_Mean_0.5.csv")
replaceWithMeanOverall(r3, "b_overallMean_1_3_Attr_Nzeros_0.1.csv")
replaceWithMeanOverall(r4, "b_overallMean_1_4_Attr_NZeros_0.5.csv")
replaceWithMeanOverall(r5, "b_overallMean_2_1_AllAttributes_0.05.csv")
replaceWithMeanOverall(r6, "b_overallMean_2_2_AllAttributes_0.33.csv")

# C REPLACE WITH MEAN OF CLASS IN COLUMN
replaceWithMeanByClass(r1, "c_classMean_1_1_Attr_Mean_0.1.csv")
replaceWithMeanByClass(r2, "c_classMean_1_2_Attr_Mean_0.5.csv")
replaceWithMeanByClass(r3, "c_classMean_1_3_Attr_Nzeros_0.1.csv")
replaceWithMeanByClass(r4, "c_classMean_1_4_Attr_NZeros_0.5.csv")
replaceWithMeanByClass(r5, "c_classMean_2_1_AllAttributes_0.05.csv")
replaceWithMeanByClass(r6, "c_classMean_2_2_AllAttributes_0.33.csv")
