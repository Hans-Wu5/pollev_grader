################################################################################
################################ PollEv Grading ################################
################################################################################

#Author: Hans Wu
#Version: Beta 4.0
#Revision: 01/26/2026

################################## INSTRUCTIONS ################################

#place canvas and pollev files in the working directory
#NOTE: THE CODE OF THE DAY NEEDS TO BE MANUALLY CHECKED

#CHANGE THESE MANUALLY
date = "0422"              ###TODAY'S DATE
name = "PollEv: Lecture 20" ###LECTURE NUMBER

################################################################################

##################################### HELPER ###################################

#shift left partial: shifting non-empty cells starting from 9th column in pe.csv
shift_left_partial <- function(df, start_col = 9) {
  #store the original column names
  original_colnames = colnames(df)
  #separate the fixed and shiftable columns
  fixed_cols = df[, 1:(start_col - 1), drop = FALSE]
  shift_cols = df[, start_col:ncol(df), drop = FALSE]
  #shift the data
  shifted <- t(apply(shift_cols, 1, function(x) {
    x = x[x != "" & !is.na(x)]
    c(x, rep("", ncol(shift_cols) - length(x)))  # Replaced NA with ""
  }))
  # keep the original column names intact
  colnames(shifted) = original_colnames[start_col:ncol(df)]
  #convert the shifted data back to dataframe
  shifted = as.data.frame(shifted, stringsAsFactors = FALSE)
  #combine the fixed columns with the shifted columns
  cbind(fixed_cols, shifted)
}

############################ AUTO_RENAME INPUT FILES ###########################

#list csvs in working directory
csv_files = list.files(pattern = "\\.csv$", ignore.case = TRUE)

#Rule 1: rename the newest csv file that starts with "2026..." to canvas.csv
#fetch all candidate canvas.csv files
candidates = csv_files[
    grepl("^2026.*\\csv$", csv_files, ignore.case = TRUE) |
    tolower(csv_files) == "canvas.csv"
    ]
#if multiple matches, rename the newest one to canvas.csv
if (length(candidates) >= 1) {
  full_paths = file.path(getwd(), candidates)
  newest = candidates[which.max(file.info(full_paths)$mtime)]
  file.rename(newest, "canvas.csv")
}

#refresh file list after possible renaming
csv_files = list.files(pattern = "\\.csv$", ignore.case = TRUE)

#Rule 2: if a csv does not start with "pe0..." OR "graded0..." OR "canvas.csv" 
#         OR a number, rename it to pe[date].csv
target_pe = paste0("pe", date, ".csv")

#check if target file already exists
if (file.exists(target_pe)) {
  stop(paste0("Target file ", target_pe, "already exists. 
                 Did you forget to change today's date? 🤔"))
} else {
  for (f in csv_files) {
    #skip canvas.csv
    if (tolower(f) == "canvas.csv") next
    
    #skip if starts with pe0...
    if (grepl("^pe0", f, ignore.case = TRUE)) next
    #skip if starts with a number
    if (grepl("^[0-9]", f)) next
    #skip if starts with graded0...
    if (grepl("^graded0", f, ignore.case = TRUE)) next
    
    #rename to pe[date].cvs (first match only)
    file.rename(f, target_pe)
    break
  }
}

#safety check
stopifnot("canvas.csv not found. Double check your directory & files 😭" =
            file.exists("canvas.csv"),
          "PollEv file not found. Double check your directory & files 😭" = 
            file.exists(target_pe)
          )

################################################################################

#load csv
pe = read.csv(paste0("pe", date, ".csv"))
canvas = read.csv("canvas.csv")

#keep only the first 6 columns
canvas = canvas [, 1:6]

#change points
canvas[2, 6] = 1

#rename columns
colnames(canvas)[6] = name
colnames(pe)[9] = "PennKey"

#clean pe (shift columnns to the left)
pe <- shift_left_partial(pe, start_col = 9)

#convert all PennKeys to lowercase
pe$PennKey = tolower(pe$PennKey)

#deal with double PennKeys
pe$PennKey = sub(",.*", "", pe$PennKey)

#check pennkey & grade
canvas[[name]][3:nrow(canvas)] = ifelse(canvas$SIS.Login.ID[3:nrow(canvas)] 
                                         %in% pe$PennKey, 1, 0)

#change column names
colnames(canvas)[3] = "SIS User ID"
colnames(canvas)[4] = "SIS Login ID"

#replace NAs with empty cells
canvas[1:3, ][is.na(canvas[1:3, ])] = ""



#final output
write.csv(canvas, file = paste0("graded", date, ".csv"), row.names = FALSE)

################################# for debugging ################################
#View(canvas)
#View(pe)
#write.csv(pe, file = "pe_test", row.names = FALSE)

