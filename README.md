# 📊 Econometric Panel Data Analysis

This project presents a comprehensive econometric analysis of panel data using multiple estimation techniques. The focus is on modeling the relationship between output (`y`), capital (`k`), and labor (`l`) across entities over time, using a balanced panel dataset.

## 👩🏻‍💻 Authors
- Bianca Inocencio  
- Glebs Solovjovs  
- Rhita Sqalli

---

## 🧠 Objective

Estimate a production function using panel data and determine the most appropriate econometric model to explain the relationship between output and input variables. We explore and test various estimators including:

- Fixed Effects (FE)
- Random Effects (RE)
- Pooled OLS (POLS)
- First Differences (FD)
- Two-way FE and RE
- Hausman tests for model selection

---

## 📂 Dataset & Setup

The dataset is panel-structured and includes repeated observations over time for each entity. Setup is done using:

```stata
xtset ivar tvar
xtdescribe
````

This confirms a balanced panel suitable for panel data techniques.

---

## 🔧 Methods Used

### ✅ Fixed Effects Estimation

```stata
xtreg y k l ,fe
predict u, u
corr u y
```

* Captures entity-specific unobserved heterogeneity.
* High explanatory power with significant coefficients for both labor and capital.
* FE model was validated using both standard and robust standard errors.

### 📉 Two-Way Fixed Effects

```stata
tabulate tvar, gen(time_d)
xtreg y k l time_d1-time_d5 ,fe
testparm time_d1-time_d5
```

* Controls for both individual and time effects.
* Rejected the homogeneity assumption using `testparm`.

### ⚙️ Random Effects & Hausman Tests

```stata
xtreg y k l ,re
xttest0
hausman fe re ,sigmaless
```

* RE model assumptions rejected based on Hausman test.
* The RE estimator was inconsistent due to correlation between unobserved effects and regressors.

### 🔁 First Difference Estimator

```stata
xtserial y l k ,output
```

* Eliminated due to presence of serial correlation and violation of time-invariance assumptions.

### 🛡️ Robust Hausman & Heteroskedasticity Handling

```stata
foreach x of varlist l k { bysort ivar: egen gm`x’=(`x)}
xtreg y l k gml gmk, re vce(cluster ivar)
testparm gmk gml
xttest3
```

* Applied robust variance to correct for heteroskedasticity.
* Robust Hausman confirmed FE over RE even under relaxed assumptions.

---

## 🔬 Findings

* **Capital (`k`)** and **labor (`l`)** are both positively and significantly associated with output (`y`).
* **Capital has a stronger effect** than labor on output.
* The **Fixed Effects model with robust standard errors** is the most accurate and consistent estimator for this dataset.
* **POLS, RE, FD, and Two-Way FE** were all discarded due to the presence of latent heterogeneity, serial correlation, or failure to meet underlying assumptions.

---

## 📈 Key Stata Commands Summary

```stata
xtset ivar tvar
xtdescribe
xtreg y k l ,fe vce(robust)
xtreg y k l time_d1-time_d5 ,fe
testparm time_d1-time_d5
xtreg y k l ,re
xttest0
regress y l k ,vce(cluster ivar)
xtserial y l k 
hausman fe re ,sigmaless
xttest3
```

---

## 📦 Requirements

Ensure you have the following Stata packages installed:

```stata
ssc install xttest3
net from http://www.stata-journal.com/software/sj3-2/
net describe st0039
net install st0039
```

---

## 📝 Conclusion

This project demonstrates the importance of model selection in panel data econometrics. By rigorously testing for heteroskedasticity, autocorrelation, and unobserved effects, we identified the **Fixed Effects model with robust variance** as the best fit—offering meaningful and reliable insights into the relationship between production inputs and output.

---

## 📫 Contact

Feel free to reach out for questions or collaborations:

* [LinkedIn](https://www.linkedin.com/in/biancainocencio/)
* [GitHub](https://github.com/biancainocencio)
* Email: [contactbiancainocencio@gmail.com](mailto:contactbiancainocencio@gmail.com)

```
---
