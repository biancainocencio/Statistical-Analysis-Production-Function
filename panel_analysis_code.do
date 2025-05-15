
# Preliminary step to set up the model
xtset ivar tvar

# Describing the data panel
xtdescribe

# Fixed effects estimator
xtreg y k l ,fe
predict u, u
corr u y

# Fixed effects estimator with robust variance
xtreg y k l ,fe vce(robust)

# Two-way fixed effects estimator 
quietly tabulate tvar,gen(time_d)
xtreg y k l time_d1-time_d5 ,fe

# Homogeneity test
testparm time_d1-time_d5

# Random effects estimator
xtreg y k l ,re

# Two-way random effects
xtreg y k l ib1.tvar

# Test for presence of latent heterogeneity
xttest0

# POLS
regress y l k ,vce(cluster ivar)

# Test for serial correlation
xtserial y l k 

# First difference estimator
xtserial y l k ,output

# Non-robust Hausman
quietly xtreg y l k ,fe
estimates store fe
quietly xtreg y l k ,re
estimates store re
hausman fe re ,sigmaless

# Robust Hausman
foreach x of varlist l k { 
  bysort ivar: egen gm`x’=(`x`)
}
xtreg y l k gml gmk, re vce(cluster ivar)
testparm gmk gml

# Heteroskedasticity in Fixed effects
quietly xtreg y l k ,fe
xttest3

# Installing packages
ssc install xttest3
net from http://www.stata-journal.com/software/sj3-2/
net describe st0039
net install st0039
