****************************************************
*HBS 514
*Estefany Gordillo-Rivas
*Problem Set 1
****************************************************
*Data & Source 1:
	* S1501 Educational Attainment from the U.S. Census Bureau collected from the American Community Survey and specifically using the 2024: ACS 1-Year Estimates Subject Table

*Why I chose this data:
	*I was interested in seeing if educational attainment and income levels were related through a state by state comparison. It would be interesting to know if states that invest in post-secondary pathways end up having a higher median income level and could support policy choices that leads to further investments in different pathways. There was no particular reason why I chose the year of 2024, I was primarily looking for open datasets to download for income that were not from the U.S. Census Bureau & the one from the U.S. Department of Commerce Bureau of Economic Analysis had a state level dataset from 1929-2024. 

****************************************************
* 0. Preliminaries: Stata Setup
****************************************************
clear
set matsize 800
version 19.5
set more off
set varabbrev off
cd "/Users/estefanygordillo-rivas/Desktop/Problem Set One"
capture log close

log using "/Users/estefanygordillo-rivas/Desktop/Problem Set One", replace

****************************************************
* 1. Data Import
****************************************************
*Uploading data from Google Drive

import delimited "https://drive.google.com/uc?id=15E4ALAilotwjdwoZxvIEU7NwLlkV6uST&export=download", ///
varnames(1) clear

****************************************************
* 2. Data Cleaning for Income Dataset
****************************************************
*Uploading Income Data By State First

import delimited "https://drive.google.com/uc?id=15E4ALAilotwjdwoZxvIEU7NwLlkV6uST&export=download", ///
varnames(1) clear

describe
list in 1/10

*Dropped the following unneeded information:
	*GeoFlip (9 Digit Number per state)
	*Repetitive Table Name
	*Dropped Unneeded Years 1929-2020
	*Industry Classification, it only was a ...
drop geofips
drop tablename
drop v9 v10 v11 v12 v13 v14 v15 v16 v17 v18 v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 v29 v30 v31 v32 v33 v34 v35 v36 v37 v38 v39 v40 v41 v42 v43 v44 v45 v46 v47 v48 v49 v50 v51 v52 v53 v54 v55 v56 v57 v58 v59 v60 v61 v62 v63 v64 v65 v66 v67 v68 v69 v70 v71 v72 v73 v74 v75 v76 v77 v78 v79 v80 v81 v82 v83 v84 v85 v86 v87 v88 v89 v90 v91 v92 v93 v94 v95 v96 v97 v98 v99 v100 v101 v102 v103
drop industryclassification

describe

*Only want to keep Personal Income Per Capita
keep if description == "Per capita personal income (dollars) 4/"

*Saving Cleaned Dataset

save "StateIncomeCleaned.dta", replace

use "StateIncomeCleaned.dta", clear

*GeoName to State
rename geoname State

*Description to Income Type
rename description Income_Type

*v104 into specified year
rename v104 Y_24

*Some states for consistency, this one was tricky because the astriek* was already included in the name, so I had some trial and error to find the correct reference
replace State = "Alaska" if State == "Alaska *"
replace State = "Hawaii" if State == "Hawaii *"
replace State = "Far West" if State == "Far West *"
save "StateIncomeCleaned.dta", replace


****************************************************
* 2. Data Cleaning for Edu.Attainment Dataset
****************************************************
*Uploading data from Google Drive

clear
import delimited "https://drive.google.com/uc?id=17tTGPbG0Z4DfHKzdOpMXphMYT86PKJYB&export=download", ///
varnames(1) rowrange(3) clear

describe
list in 1/10

*Dropped in order to have this information:
	*State Specific Information to only have Total Percent Estimate per education category per state
	
*I did not know that I can individually highlight what I want to keep instead of having a massive block of code dropping what I don't want!

keep labelgrouping alabamapercentestimate alaskapercentestimate arizonapercentestimate arkansaspercentestimate californiapercentestimate coloradopercentestimate connecticutpercentestimate delawarepercentestimate districtofcolumbiapercentestimat floridapercentestimate georgiapercentestimate hawaiipercentestimate idahopercentestimate illinoispercentestimate indianapercentestimate iowapercentestimate kansaspercentestimate kentuckypercentestimate louisianapercentestimate mainepercentestimate marylandpercentestimate massachusettspercentestimate michiganpercentestimate minnesotapercentestimate mississippipercentestimate missouripercentestimate montanapercentestimate nebraskapercentestimate nevadapercentestimate newhampshirepercentestimate newjerseypercentestimate newmexicopercentestimate newyorkpercentestimate northcarolinapercentestimate northdakotapercentestimate ohiopercentestimate oklahomapercentestimate oregonpercentestimate pennsylvaniapercentestimate rhodeislandpercentestimate southcarolinapercentestimate southdakotapercentestimate tennesseepercentestimate texaspercentestimate utahpercentestimate vermontpercentestimate virginiapercentestimate washingtonpercentestimate westvirginiapercentestimate wisconsinpercentestimate wyomingpercentestimate puertoricopercentestimate

*Renaming all of these to match the Income Dataset - is there an easier way to do this? Probably

rename alabamapercentestimate Alabama
rename alaskapercentestimate Alaska
rename arizonapercentestimate Arizona
rename arkansaspercentestimate Arkansas
rename californiapercentestimate California
rename coloradopercentestimate Colorado
rename connecticutpercentestimate Connecticut
rename delawarepercentestimate Delaware
rename districtofcolumbiapercentestimat District_of_Columbia
rename floridapercentestimate Florida
rename georgiapercentestimate Georgia
rename hawaiipercentestimate Hawaii
rename idahopercentestimate Idaho
rename illinoispercentestimate Illinois
rename indianapercentestimate Indiana
rename iowapercentestimate Iowa
rename kansaspercentestimate Kansas
rename kentuckypercentestimate Kentucky
rename louisianapercentestimate Louisiana
rename mainepercentestimate Maine
rename marylandpercentestimate Maryland
rename massachusettspercentestimate Massachusetts
rename michiganpercentestimate Michigan
rename minnesotapercentestimate Minnesota
rename mississippipercentestimate Mississippi
rename missouripercentestimate Missouri
rename montanapercentestimate Montana
rename nebraskapercentestimate Nebraska
rename nevadapercentestimate Nevada
rename newhampshirepercentestimate New_Hampshire
rename newjerseypercentestimate New_Jersey
rename newmexicopercentestimate New_Mexico
rename newyorkpercentestimate New_York
rename northcarolinapercentestimate North_Carolina
rename northdakotapercentestimate North_Dakota
rename ohiopercentestimate Ohio
rename oklahomapercentestimate Oklahoma
rename oregonpercentestimate Oregon
rename pennsylvaniapercentestimate Pennsylvania
rename rhodeislandpercentestimate Rhode_Island
rename southcarolinapercentestimate South_Carolina
rename southdakotapercentestimate South_Dakota
rename tennesseepercentestimate Tennessee
rename texaspercentestimate Texas
rename utahpercentestimate Utah
rename vermontpercentestimate Vermont
rename virginiapercentestimate Virginia
rename washingtonpercentestimate Washington
rename westvirginiapercentestimate West_Virginia
rename wisconsinpercentestimate Wisconsin
rename wyomingpercentestimate Wyoming
rename puertoricopercentestimate Puerto_Rico

*Saving all of this hard work! Took me like 3 different tries to renaming the states with spaces

**I only want information for a bachelor's degree or higher for ages 25+ since it was the closest of what I could have total of the state's population. I originally typed this in and then it erased all of the data. Turns out there is actually an indent that I had to keep. 
replace labelgrouping = "        Bachelor's degree or higher 25, People 25 years and over" in 15

tab labelgrouping

keep if labelgrouping == "        Bachelor's degree or higher 25, People 25 years and over"

*Trying to format between wide & long was not working well for me. I looked at some videos and found the stack command. It ended up giving each state a number and then I went through to rename. Afterwards, I dropped the _stack since I no longer needed it, just the formatting. 
 
stack Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware District_of_Columbia Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada New_Hampshire New_Jersey New_Mexico New_York North_Carolina North_Dakota Ohio Oklahoma Oregon Pennsylvania Rhode_Island South_Carolina South_Dakota Tennessee Texas Utah Vermont Virginia Washington West_Virginia Wisconsin Wyoming Puerto_Rico, into(BachelorsPercent)

*Here is where I did the replacing to have state names again
gen State = ""
replace State = "Alabama"        if _stack == 1
replace State = "Alaska"         if _stack == 2
replace State = "Arizona"        if _stack == 3
replace State = "Arkansas"       if _stack == 4
replace State = "California"     if _stack == 5
replace State = "Colorado"       if _stack == 6
replace State = "Connecticut"    if _stack == 7
replace State = "Delaware"       if _stack == 8
replace State = "District of Columbia" if _stack == 9
replace State = "Florida"        if _stack == 10
replace State = "Georgia"        if _stack == 11
replace State = "Hawaii"         if _stack == 12
replace State = "Idaho"          if _stack == 13
replace State = "Illinois"       if _stack == 14
replace State = "Indiana"        if _stack == 15
replace State = "Iowa"           if _stack == 16
replace State = "Kansas"         if _stack == 17
replace State = "Kentucky"       if _stack == 18
replace State = "Louisiana"      if _stack == 19
replace State = "Maine"          if _stack == 20
replace State = "Maryland"       if _stack == 21
replace State = "Massachusetts"  if _stack == 22
replace State = "Michigan"       if _stack == 23
replace State = "Minnesota"      if _stack == 24
replace State = "Mississippi"    if _stack == 25
replace State = "Missouri"       if _stack == 26
replace State = "Montana"        if _stack == 27
replace State = "Nebraska"       if _stack == 28
replace State = "Nevada"         if _stack == 29
replace State = "New Hampshire"  if _stack == 30
replace State = "New Jersey"     if _stack == 31
replace State = "New Mexico"     if _stack == 32
replace State = "New York"       if _stack == 33
replace State = "North Carolina" if _stack == 34
replace State = "North Dakota"   if _stack == 35
replace State = "Ohio"           if _stack == 36
replace State = "Oklahoma"       if _stack == 37
replace State = "Oregon"         if _stack == 38
replace State = "Pennsylvania"   if _stack == 39
replace State = "Rhode Island"   if _stack == 40
replace State = "South Carolina" if _stack == 41
replace State = "South Dakota"   if _stack == 42
replace State = "Tennessee"      if _stack == 43
replace State = "Texas"          if _stack == 44
replace State = "Utah"           if _stack == 45
replace State = "Vermont"        if _stack == 46
replace State = "Virginia"       if _stack == 47
replace State = "Washington"     if _stack == 48
replace State = "West Virginia"  if _stack == 49
replace State = "Wisconsin"      if _stack == 50
replace State = "Wyoming"        if _stack == 51
replace State = "Puerto Rico"    if _stack == 52

*Now I checked if my work was correct
drop _stack

list

*Figuring out what I needed to do in order to be able to have a merge took me a super long time, but I eventually got it to do so in order for me to run some of the descriptive statistics. One of the challenges I has was that I've only ever worked in stata with datasets that come from the same source, so they were formatted almost exactly the same and I was able to clean them easily for merging. I think in the future I will do a better job at looking what exactly the datasets are made up of and how they are formatted so I can consider how much time it will take me. On the bright side, I found some interesting commands to learn and apply if I were to ever encounter this issue again. 

save "EducationalAttainmentCleaned.dta", replace


****************************************************
* 3. Merging & New Variables! (..finally)
****************************************************
*I've reached the step to merge by state, which is what I've been wanting to do the whole time I was working on cleaning the educational attainment dataset.

use "StateIncomeCleaned.dta", clear

merge 1:1 State using "EducationalAttainmentCleaned.dta"

tab _merge


*Now I went through to create some new variables, I primarily based this on income levels. I didn't do destringing earlier because I was struggling so much to get them reformatted into how I needed it to merge, so I ended up doing it here when my initial commands didn't result in anything

destring BachelorsPercent, replace ignore("%")

*I generated this variable to look at per capita income per percentage point of adults with a bachelor's degree or higher.
gen IncomePerBachRatio = Y_24 / BachelorsPercent

****************************************************
* 4. Looking at the Data
****************************************************

summarize
*Looking at all the information, average state income in 2024 is about $71,927 with a range of $52,074 to $111,185, which is a very large variation. The average percentage of adults above the age of 25 with a bachelor's degree is 36.2% with a range of 24.4% to 65.5%, which shows a significant difference in educational attainment by state. There is an initial correlation between these two factors. Some states have specialized industries, where education is necessary in order to work in those industries, which could be a factor that influences this distribution as well. 


summarize IncomePerBachRatio
*This one measures the per capita income relative to the percentage of adults with a bachelor's degree or higher in each state, so per earned bachelor degree in that state correlates to an increase in income. On average there is a $1,983 in per capita income. There is variation between states with the lowest value being $1,581 and the highest being $2,677. It seems that some states are generating a higher income per educated adult in 2024. 

scatter IncomePerBachRatio BachelorsPercent
*Just for fun! It was a much better looking chart than the line chart that was everywhere. It showed the concentration/correlation in a much better way as well. 

****************************************************
* 5. Saving
****************************************************

save "MergedIncomeEducationalDataset.dta", replace

export excel using "MergedIncomeEducationalDataset.xlsx", firstrow(variables) replace

export delimited using "MergedIncomeEducationalDataset.csv", replace


****************************************************
* 6. Push
****************************************************
