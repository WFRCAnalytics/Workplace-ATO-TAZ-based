#ATO Script Python 2.7
#Updated 20191112

import arcpy
import math

#######################
#Define Input Variables

#Location of TAZ polygons
TAZ = r"Geodatabase\TAZ2017\TAZ.shp"

#Location of Socioeconomic table with job count and household count for each TAZ
SE = "SE_File_v83_SE23_Net23.dbf"

#Location of TAZ to TAZ travel time matrix (skim) for morning peak commute window
TRAVELTIME_AM = "autoskim_TIP_AM.dbf"
#Location of TAZ to TAZ travel time matrix (skim) for afternoon peak commute window
TRAVELTIME_PM = "autoskim_TIP_PM.dbf"

#End Input Variables
######################


print "Reading Travel Time..."
#Build empty array for loading and storing travel times in memory
AUTOTIME_AM = [[0.0 for x in range(2882)] for y in range(2882)]
AUTOTIME_PM = [[0.0 for x in range(2882)] for y in range(2882)]
#TRANSITTIME = [[0.0 for x in range(2882)] for y in range(2882)]

#load travel times into matrices
with arcpy.da.SearchCursor(TRAVELTIME_AM,"*") as cur:
    for row in cur:
        AUTOTIME_AM[int(row[1])][int(row[2])] = row[3]
        #TRANSITTIME[int(row[1])][int(row[2])] = row[4]

with arcpy.da.SearchCursor(TRAVELTIME_PM,"*") as cur:
    for row in cur:
        AUTOTIME_PM[int(row[1])][int(row[2])] = row[3]

#Build empty array for loading and storing TAZ socioeconomic characteristics into memory
HH = [0.0 for x in range(2882)]
JOB = [0.0 for x in range(2882)]


print "Reading Household and Jobs SE data..."
#load SE data into into array
with arcpy.da.SearchCursor(SE,["Z","TOTHH","ALLEMP"]) as cur:
    for row in cur:
        HH[int(row[0])] = row[1]
        JOB[int(row[0])] = row[2]

#calculate JHB, the jobs per household across the region
SUMHH = sum(HH)
SUMJOB = sum(JOB)
JHB = SUMJOB/SUMHH
print "Job/Housing Balance is ", JHB


#workplace accessibility calculations       
print "Calculating Accessibility..."
JOBAUTOACC_AM = [0.0 for x in range(2882)]
JOBAUTOACC_PM = [0.0 for x in range(2882)]
HHAUTOACC_AM = [0.0 for x in range(2882)]
HHAUTOACC_PM = [0.0 for x in range(2882)]
for i in range(1,2882):
    JOBAUTOACC_AM[i] = 0.0
    JOBAUTOACC_PM[i] = 0.0
    HHAUTOACC_AM[i] = 0.0
    HHAUTOACC_PM[i] = 0.0
    for j in range(1,2882):
        JOBAUTOACC_AM[i] = JOBAUTOACC_AM[i] + JOB[j]*survey_weight(AUTOTIME_AM[i][j])
        JOBAUTOACC_PM[i] = JOBAUTOACC_PM[i] + JOB[j]*survey_weight(AUTOTIME_PM[j][i])
        HHAUTOACC_PM[i] = HHAUTOACC_PM[i] + HH[j]*survey_weight(AUTOTIME_PM[i][j])
        HHAUTOACC_AM[i] = HHAUTOACC_AM[i] + HH[j]*survey_weight(AUTOTIME_AM[j][i])

#write household accessibilty to workplace AND
#workplace/business accessibility to households AND
#composite accessibility - combined score for household and workplace/business, 
#weighted by presence of hh's and jobs within TAZ and overall ratio of jobs to households across the region

f = open(outputTAZ, 'w')
f.write('Z,JOBAUTOACC_AM,JOBAUTOACC_PM,HHAUTOACC_AM,HHAUTOACC_PM,COM_AM,COMP_PM,COM_AVG\n')
for i in range(1,2882):
    f.write(str(i) + ",")
    f.write(str(JOBAUTOACC_AM[i]) + "," + str(JOBAUTOACC_PM[i]) + "," )
    f.write(str(HHAUTOACC_AM[i]) + "," + str(HHAUTOACC_PM[i]) + ",")
    if (HH[i] + JOB[i]) == 0:
        f.write("0,0,0\n")
    else:
        f.write(str((HHAUTOACC_AM[i]*JOB[i] + JOBAUTOACC_AM[i]*HH[i])/(HH[i]*JHB + JOB[i])) + ",")
        f.write(str((HHAUTOACC_PM[i]*JOB[i] + JOBAUTOACC_PM[i]*HH[i])/(HH[i]*JHB + JOB[i])) + ",")
        f.write(str((HHAUTOACC_AM[i]*JOB[i] + JOBAUTOACC_AM[i]*HH[i] + HHAUTOACC_PM[i]*JOB[i] + JOBAUTOACC_PM[i]*HH[i])/(2*(HH[i]*JHB + JOB[i]))) + "\n")
f.close()


#define decay function for autos - this best fits household travel survey trip length curve
def survey_weight(t):
    if t <= 3:
        return 1
    elif (t > 3) & (t <= 20):
        return -0.0382 * t + 1.1293
    elif t > 20:
        return 1/(1 + math.exp(0.1092 * t - 1.5604))
    else:
        return 0
