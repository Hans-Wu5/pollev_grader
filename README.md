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

-   Canvas gradebook export CSV (course roster)
-   Poll Everywhere report CSV
-   This R script

## Usage

1.  Export the Gradebook CSV file (course roster) from Canvas and place it in the working directory. **DO NOT change the name of the file, the grader handles that automatically.**

    <img src="images/canvas.png" width="500"/>

2.  Go to polleverywhere.com and log in to Ryan's account (note that you need to select "Use password instead", otherwise the website might do something weird).

    <img src="images/pollev_login.png" width="500"/>

3.  Download the PollEv report and place it in the working directory (`Activities` -\> folder for semester -\> polls for both sessions -\> `Create report` -\> `Audience response` -\> `Create report`-\> `Download`). **DO NOT change the name of the file, the grader handles that automatically.**

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

## Special Note for Canvas CSV & Add/Drop Period
During regular part of the semester, there is usually no need to download the course roaster CSV file from Cavas before every grading session. However, during the add/drop period, because the roster may change frequently, you may need to download a fresh roster before each grading run. 

Simply download and drag the CSV file to the working directory. The grader will automatically detect the new Canvas file, rename it, and replace the old roster file.

## Troubleshooting

Note that the code is already fairly robust - the core grading functionality has been used for two semesters without a single issue. In other words, when a student reports a PollEv grading-related problem, it is almost certainly due to user error rather than a bug in the grader. The following guidelines walk through a troubleshooting procedure for identifying the cause of a grading issue:

1.  Double-check that the student has entered their **PennKey** instead of their PennID number. Their PennKey is the first part of their Penn email before the "\@". For example, if their email is: [ryandew01\@wharton.edu](mailto:ryandew01@wharton.edu){.email}, their PennKey is "ryandew01". Capitalization does not matter, but the spelling must be exact - even being off by a single letter will cause the grader to fail. (This causes 99% of the issues).

2.  If grading is failing on a larger scale, double-check that you entered the correct lecture date and number.

3.  Ensure that you are using the correct input files and uploaded the correct output CSV file on Canvas.

4.  Ask the student to send a screenshot of their PollEv history page to check that PollEv correctly recorded their response.

**Do not manually modify the file names or file contents unless you fully understand what you are doing**

## Future Development

Further development of PollEv Grader could consider focusing on the following improvements:

-   Auto-updating the date and lecture number;

-   Using a headless browser to handle the process of downloading the CSV files from Canvas and PollEverywhere, as well as importing the graded CSV file to Canvas;

-   Checking code word of the day.

## Contact

For any questions related to PollEv grader, feel free to contact: zihanw\@sas.upenn.edu
