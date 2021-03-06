% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/methylInheritanceSimInternalMethods.R
\name{simEachGeneration}
\alias{simEachGeneration}
\title{Simulate a multigeneration methylation experiment with inheritance}
\usage{
simEachGeneration(simulation, nbCtrl, nbCase, treatment, sample.id, generation,
  stateInfo, minReads, maxPercReads, context, assembly, meanCov, saveGRanges,
  saveMethylKit, runAnalysis)
}
\arguments{
\item{nbCtrl}{a positive \code{integer}, the number of controls.}

\item{nbCase}{a positive \code{integer}, the number of cases.}

\item{treatment}{a numeric vector denoting controls and cases}

\item{sample.id}{a matrix the name of each samples for each generation (row)
and each case and control (column).}

\item{generation}{a positive \code{integer}, the number of generations
simulated.}

\item{stateInfo}{a \code{GRanges} that contains the CpG (or 
methylated sites).
The \code{GRanges} have four metadata from the real dataset:
\itemize{
\item chrOri a \code{numeric}, the chromosome from the real dataset
\item startOri a \code{numeric}, the position of the site in the real dataset
\item meanCTRL a \code{numeric}, the mean of the control in the real dataset
\item varCTRL a \code{numeric}, the variance of the control in the real 
dataset.
}}

\item{minReads}{a positive \code{integer}, sites and regions having lower
coverage than this count are discarded. The parameter
corresponds to the \code{lo.count} parameter in 
the \code{methylKit} package.}

\item{maxPercReads}{a \code{double} between [0,100], the percentile of read
counts that is going to be used as upper cutoff. Sites and regions
having higher
coverage than \code{maxPercReads} are discarded. This parameter is used for 
both CpG sites and tiles analysis. The parameter
correspond to the \code{hi.perc} parameter in the \code{methylKit} package.}

\item{context}{a string of \code{character}, the short description of the 
methylation context, such as "CpG", "CpH", "CHH", etc..}

\item{assembly}{a string of \code{character}, the short description of the 
genome assembly, such as "mm9", "hg18", etc..}

\item{meanCov}{a positive \code{integer}, the mean of the coverage
at the simulated CpG sites.}

\item{saveGRanges}{a \code{logical}, when \code{true}, the package save two 
files type. The first generate for each simulation contains a \code{list}. 
The length of the \code{list} corresponds to the number of generation. 
The generation are stored in order (first entry = first generation, 
second entry = second generation, etc..). All samples related to one 
generations are contained in a \code{GRangesList}. 
The \code{GRangeaList} store a \code{list} of \code{GRanges}. Each 
\code{GRanges} stores the raw mehylation data of one sample.
The second file a numeric \code{vector} denoting controls and cases 
(a file is generates by entry in the \code{vector} parameters 
\code{vNbSample}).}

\item{saveMethylKit}{a \code{logical}, when \code{TRUE}, the package save 
a file contains a \code{list}. The length of the 
\code{list} corresponds to the number of generation. The generation are 
stored in order (first entry = first generation, 
second entry = second generation, etc..). All samples related to one 
generations are contained in a S4 \code{methylRawList} object. The 
\code{methylRawList} object contains two Slots:
1. treatment: A numeric \code{vector} denoting controls and cases.
2. .Data: A \code{list} of \code{methylRaw} objects. Each object stores the 
raw methylation data of one sample.}

\item{runAnalysis}{a \code{logical}, if \code{TRUE}, two files are saved :
\itemize{
\item 1. The first file is the methylObj... file formated 
with the \code{methylkit} package in a S4 \code{methylBase} 
object (with the \code{methylKit} 
functions: \code{filterByCoverage}, \code{normalizeCoverage} and 
\code{unite}).
\item 2. The second file contains a S4 \code{calculateDiffMeth} object 
generated with the \code{methylKit} functions \code{calculateDiffMeth} 
using the first file.
}}
}
\value{
\code{0} indicating that the function has been successful.
}
\description{
Simulate a multigeneration methylation case versus control 
experiment with inheritance relation using a real control dataset. 

The simulation can be parametrized to fit different models. The number of 
cases and controls, the proportion of the case affected 
by the treatment (penetrance), the effect of the treatment on the mean of 
the distribution, the proportion of sites inherited, the proportion of the 
differentially methylated sites from the precedent generation inherited, 
etc..

The function simulates a multigeneration dataset like a bisulfite 
sequencing experiment. The simulation includes the information about 
control and case for each generation.
}
\examples{

## Load dataset
data("samplesForChrSynthetic")
data("dataSimExample")

## Generate a stateInfo object using samples
stateInformation <- methInheritSim:::getSyntheticChr(methInfo = 
    samplesForChrSynthetic, nbBlock = 1, nbCpG = 3)

## Generate a stateDiff and stateInherite objects with length corresponding 
## to nbBlock * nbCpG from stateInformation
stateDiff  <- c(1, 0, 1)
stateInherite <- c(1, 0, 0)

## Create simulation
sim <- methInheritSim:::getSim(nbCtrl = 3, nbCase = 2, 
    generation = 3, stateInfo = stateInformation, stateDiff = stateDiff, 
    stateInherite = stateInherite, diffValue = 10, 
    propDiff = 0.8, propDiffsd = 0.2, propInheritance = 0.8, 
    propHetero = 0.1)

## TODO
methInheritSim:::simEachGeneration(simulation = sim, 
nbCtrl = 3, nbCase = 2, treatment = c(0,0,0,1,1), 
sample.id = dataSimExample$sample.id,
generation = 3, stateInfo = stateInformation, minReads = 10, 
maxPercReads = 99, context = "Cpg", assembly = "RNOR_5.0", meanCov = 80, 
saveGRanges = FALSE, saveMethylKit = FALSE, runAnalysis = FALSE)

}
\author{
Pascal Belleau, Astrid Deschenes
}
\keyword{internal}
