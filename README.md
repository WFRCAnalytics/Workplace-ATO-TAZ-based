# Workplace-ATO-TAZ-based
Code base for calculating traffic analysis zone (TAZ) based workplace Access To Opportunities metrics

This repo will contain the code used to calc regional workplace ATO ([GIS dataset](http://data.wfrc.org/datasets/access-to-opportunity-work-related-taz-based)) and produce local area calculations like these:

-[Household Access to Jobs, Mode = Auto](http://wfrc.org/MapsData/GeneralPlanResources/PT2019SWSL_JOBAUTONew.pdf)

-[Household Access to Jobs, Mode = Transit](http://wfrc.org/MapsData/GeneralPlanResources/PT2019SWSL_JOBTRANSITNew.pdf)

-[Employer/Business Access to Households, Mode = Auto](http://wfrc.org/MapsData/GeneralPlanResources/PT2019SWSL_HHAUTONew.pdf)

-[Employer/Business Access to Households, Mode = Transit](http://wfrc.org/MapsData/GeneralPlanResources/PT2019SWSL_HHTRANSITNew.pdf)

-[Composite Household-Job Accessibility, Mode = Auto](http://wfrc.org/MapsData/GeneralPlanResources/PT2019SWSL_COMPAUTONew.pdf)

-[Composite Household-Job Accessibility, Mode = Transit](http://wfrc.org/MapsData/GeneralPlanResources/PT2019SWSL_COMPTRANSITNew.pdf)


There's some complexity behind the term 'typical commute"...I'll try to unpack that complexity a bit below. 

In years past we would establish a hard cut off ("jobs within 20 minute commute") but that hard cut off threshold, doesn't reflect the full range of how people value jobs differently depending on how close they are. 

We use what's called a distance decay curve to fully count jobs closest to a household and then we start discount jobs the further away they are. That discounting curve reflects the trip length pattern reported by Wasatch Front commuters from the most recent household survey.

Examples, jobs within 3 minutes are fully counted, if 85% of work trips are 10 minutes or longer, then a job 10 minutes away gets counted as 0.85 of a job; if 40% of work trips in the region are 20 minutes or longer, then a job 20 minutes away gets counted as 0.4 of a job. If 15% of work trips are work trips are 40 minutes or than a job 40 minutes away gets counted as 0.15 jobs. 

So 'within a typical commute' is our term to quickly describe how we are using current work commute length (in time) to scale the value of jobs according to how quickly they can be reached.
