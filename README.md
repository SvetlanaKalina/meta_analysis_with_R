# Basic meta analysis with metagen (meta package)

This code is an example on how i conducted a simple meta analysis in R using a dummy dataset. The generated dataset includes dummy 
studies with Odds Ratios (OR) as the effect estimates. 

Major steps included:
 - Generating the dummy dataset(Authors/studies, ORs and p-values). 
 - Transforming Odds Ratios (OR) into log values (yi). This is a necessary step to generate the treatment/effect estimate for `metagen`(TE).
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
 - Visualisation with forest plots using `forest`. 
 
 
 Important interpretation points: Heterogeneity (if high use random effects model for interpretation)
 - Exploration of publication bias with linear regression test of funnel plot asymmetry using `metabias`. Check p-values and plot for interpretation.
 - Visualisation with funnel plot using `funnel`. Check position of the data points for interpretation.
 - Sensitivity analysis with leave-one-out crossvalidation
 
 
 




