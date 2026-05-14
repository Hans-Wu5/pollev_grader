# PollEv Grader

## Overview

This R script automates grading for Poll Everywhere participation by matching PennKeys from a exported PollEv CSV against a Canvas gradebook CSV.

## What the Script Does

-   Finds the Canvas CSV file in the working directory to `canvas.csv`
-   Finds and renames the PollEv CSV file to `pe[date].csv`
-   Cleans PollEv response data
-   Extracts PennKeys from the PollEv file
-   Matches PollEv PennKeys against Canvas SIS Login IDs
-   Assigns participation grades
-   Exports a new graded Canvas CSV file `graded[date].csv`

## Required Files

Place the following files in the working directory:

-   Canvas gradebook export CSV
-   Poll Everywhere report CSV
-   This R script

## Usage

1.  Export the Gradebook CSV file from Canvas and place it in the working directory.

    <img src="images/canvas.png" width="500"/>

2.  Go to polleverywhere.com and log in to Ryan's account (note that you need to select "Use password instead", otherwise the website might do something weird).

    <img src="images/pollev_login.png" width="500"/>

3.  Download the PollEv report and place it in the working directory (`Activities` -\> folder for semester -\> polls for both sessions -\> `Create report` -\> `Audience response` -\> `Create report`-\> `Download`)

    <img src="images/pollev_1.png" width="500"/>

    <img src="images/pollev_2.png" width="500"/>

    <img src="images/pollev_3.png" width="500"/>

    <img src="images/pollev_4.png" width="500"/>

4.  Open the R code and **update the date and lecture number to match the most recent lecture.**

    <img src="images/r.png" width="500"/>

5.  Upload the generated CSV file (`graded[date].csv`) to Canvas (`Grades` -\> `Import` -\> `Select File` -\> `Upload Data` -\> `Choose assignment` [A new assignment] -\> `Continue`)

    <img src="images/canvas_import.png" width="500"/>

    <img src="images/canvas_new_assignment.png" width="500"/>

6.  Post grades

    <img src="images/canvas_post_grades.png" width="500"/>
    
## Special Note for Canvas CSV & Add-Drop Period

## Troubleshooting

## Future Development
