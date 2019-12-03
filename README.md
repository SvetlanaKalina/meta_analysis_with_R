# Basic meta analysis with metagen (meta package)

This code is an example on how i conducted a simple meta analysis using R. As a demonstration a sample dataset is included in the script. In this case it includes studies with Odds Ratios (OR) as the effect estimates. 

Major steps included:

#### Preparing the dataset
 - Generating the sample dataset(authors/studies, ORs and p-values). 
 - Transforming OR into log values (yi). This is a necessary step to generate the treatment/effect estimate for `metagen`(TE).
 - Calculating z-scores using the p-values. This is a necessary step to generate the standard error for `metagen` (SE).
 - Meta analysis with `metagen`. 
 
 ```r
 y <- metagen(
        TE=dataset$yi,
        seTE=dataset$se, 
        data=dataset, 
        sm="OR",
        subset=NULL, 
        level=0.95,
        comb.fixed=TRUE, 
        comb.random=TRUE,
        print.byvar = TRUE)
  ```
  This code will generate a meta analysis with fixed effect and random effects estimates/ORs and the weights of the respective studies. 

#### Visualisation with forest plots using `forest`. 
 
![alt text](https://github.com/svkal/meta_analysis_with_R/blob/master/forest_plot.png)
 
Some important interpretation points: 
* Heterogeneity (if high use random effects model for interpretation). In this example the heterogeneity is very high (82%), therefore the random effects model needs to be considered. 
* Effect estimate: Here, the estimate is not significant. 
 
#### Exploration of publication bias with linear regression test of funnel plot asymmetry using `metabias`.  
 
 Linear regression test of funnel plot asymmetry

 ```
data:  y
t = -0.66311, df = 8, p-value = 0.5259
```
Test shows no publication bias (p > 0.05). Confirm with funnel plot:

 #### Visualisation with funnel plot using `funnel`.  
 
![alt text](https://github.com/svkal/meta_analysis_with_R/blob/master/funnel_plot.png)

 Check data points for interpretation. Inthis case a data point on the lower left side does not have a corresponding data point on the right, which means there may be a lack of studies with low precision i.e. smaller studies. 
 
 #### Sensitivity analysis with leave-one-out crossvalidation.
 
 This procedure is done to check the robustness of the overall effect estimate. Because one large study may influence the overall effect greatly, it can be beneficial to assess the effect estimate without the study. The leave-one-out cross validation one by one excludes studies to assess the sensitivity. If the effect changes greatly, it may not be robust.  
 




