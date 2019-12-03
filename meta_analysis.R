'***********************************************************************************************************************'
#How to conduct a basic meta analysis using the meta package.

#Set up work directory

wd <- choose.dir()
setwd(wd)

#Load library

install.packages("meta")
library(meta)

#Build dateset

Author <-c("Author1", 
           "Author2", 
           "Author3", 
           "Author4",
           "Author5", 
           "Author6", 
           "Author7", 
           "Author8", 
           "Author9", 
           "Author10")
OR <-c(1.6, 0.74, 1.62, 0.79, 0.73, 1.43, 0.53, 0.53, 0.52, 1.22)
P <- c(0.0001, 0.04, 0.02, 0.07,0.01, 0.02, 0.06, 0.67, 0.05, 0.12)
dataset <- data.frame(Author, OR, P)

#Transform the OR into logOR

dataset$yi <-log(dataset$OR)

#Calculate the standard error using the z-score

dataset$p2 <- dataset$P/2
dataset$z <- qnorm(dataset$p2, lower.tail = FALSE)
dataset$se <-abs(dataset$yi / dataset$z)

#Meta analysis with calculated values, in this case Odds Ratios

y <- metagen(
        TE=dataset$yi,seTE=dataset$se, 
        data=dataset, sm="OR",
        subset=NULL, 
        level=0.95,
        comb.fixed=TRUE, 
        comb.random=TRUE,
        print.byvar = TRUE)

#Visualisation with forest plot

forest(
        y, 
        studlab = Author,
        comb.fixed = TRUE, 
        comb.random = TRUE)

#Alternatively each Author/study is specified in studlab

forest(y, 
       studlab = c("Study1", 
                   "Study2", 
                   "Study3", 
                   "Study4", 
                   "Study5",
                   "Study6", 
                   "Study7",
                   "Study8", 
                   "Study9",
                   "Study10"),
       comb.fixed = TRUE, 
       comb.random = TRUE)

#Publicationbias assessment

#funnelplot

funnel(
        y$TE, 
        y$seTE, 
        sm = "OR",
        comb.fixed = TRUE, 
        level = 0.95)

#Or just

funnel(y)

#linear regression test

metabias(y, method.bias = "linreg",
         plotit = TRUE, correct = FALSE, k.min=3)
#Check p-value for absense of publication bias and placement of datapoints in the plot 


#**********Sensitivity analysis using the leave-one-out-crossvalidation******************

#First Study excluded

y_sens1 <- metagen(
                TE=dataset$yi,
                seTE=dataset$se, 
                data=dataset, sm="OR",
                subset=c(2,3,4,5,6,7,8,9,10), 
                level=0.95,
                comb.fixed=TRUE, 
                comb.random=TRUE,
                print.byvar = TRUE)

#Visualization with plot

forest(y_sens1)

#Repeat until all studies have been excluded once

#Second study excluded

y_sens2 <- metagen(
        TE=dataset$yi,
        seTE=dataset$se, 
        data=dataset, sm="OR",
        subset=c(1,3,4), 
        level=0.95,
        comb.fixed=TRUE, 
        comb.random=TRUE,
        print.byvar = TRUE)

#Visualization with forestplot

forest(y_sens2)

#Third study excluded

y_sens3 <- metagen(
        TE=dataset$yi,
        seTE=dataset$se, 
        data=dataset, sm="OR",
        subset=c(1,2,4), 
        level=0.95,
        comb.fixed=TRUE, 
        comb.random=TRUE,
        print.byvar = TRUE)

#visualization with forestplot

forest(y_sens3)

#and so on

'***********************************************************************************************************************'
