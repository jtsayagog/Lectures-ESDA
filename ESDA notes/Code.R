\documentclass[]{beamer}
\mode<presentation> 
% Setup appearance:

%\usetheme{Darmstadt}
\usetheme{CambridgeUS}
%\useinnertheme{circles}
%\useinnertheme{triangles}
%\usetheme{Warsaw} 
%\usetheme{crane} 
%\usetheme{WVU}
%\usetheme{JuanLesPins}
%\usetheme{default}
%\beamertemplatenavigationsymbolsempty
%\usetheme{Warsaw} 
%\setbeamerfont*{frametitle}{size=\normalsize,series=\bfseries}
%\setbeamertemplate{navigation symbols}{}
%\usecolortheme{whale} 
%\usecolortheme{seahorse} 
%\usecolortheme{WVU} 
%\setbeamercovered{transparent} 

% Standard packages
%\definecolor{wvublue}{HTML}{003366}
\usepackage[english]{babel}
%\usepackage{times}
%\usepackage[T1]{fontenc}
\usepackage{multirow}
\usepackage{subcaption}
\usepackage{listings}
\usepackage{inconsolata}
\usepackage{amsmath,amsthm}
\usepackage{amssymb}
\usepackage[english]{babel}
\usepackage{latexsym}
\usepackage{amsfonts}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{float}
\usepackage{graphics}
\usepackage{epsfig}
\usepackage{url}
%\usetheme{WVU}
%\usecolortheme{WVU}
\usepackage{multirow}
\usepackage{natbib}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,      
    urlcolor=red,
}
% Setup TikZ
\usepackage[export]{adjustbox}
\usepackage{tikz}
\usetikzlibrary{arrows}
\tikzstyle{block}=[draw opacity=0.5,line width=1.4cm]

% Author, Title, etc.

\title[ESDA Class] {Exploratory Spatial Data Analysis (ESDA) with R } 

\author[Juan Sayago]{Juan Tomas~Sayago Gomez}

\date[RRI WS]
{\scriptsize RRI Workshop \\
Morgantown\\
\today
}

\usepackage{Sweave}
\begin{document}
\input{Code.R-concordance}

\begin{frame}
\titlepage
\end{frame}



\begin{frame}
\tableofcontents
\end{frame}






\section{Introduction to ESDA}


\begin{frame} 
\frametitle{What is Exploratory Spatial Data Analysis?} 

``ESDA is a collection of techniques to describe and visualize spatial distributions, identify atypical locations or spatial outliers, discover patterns of spatial association, clusters or hot-spots, and suggest spatial regimes or other forms of spatial heterogeneity. Central to this conceptualization is the notion of spatial autocorrelation or spatial association, i.e., the phenomenon where locational similarity (observations in spatial proximity) is matched by value similarity (attribute correlation)'' Anselin(1998,79-80)
\end{frame}









\begin{frame} 
\frametitle{Introduction to Exploratory Data Analysis (EDA)} 
Graphical and visual methods or tools that are used to identify data properties for purposes of

\begin{itemize}
\item Detect patterns in the data
\item Formulate hypothesis from the data
\item Assess various aspects of models  (e.g., goodness-of-fit)
\end{itemize}
\end{frame}









\begin{frame} 
\frametitle{Introduction to Exploratory Data Analysis (EDA)} 
EDA emphasizes on the \textbf{interaction} between \textbf{human cognition} and \textbf{computation} in the form of dynamic statistical graphics that allow the user to manipulate ``views'' of the data (via box-plots, scatterplots, etc). \\
\vspace{0.5cm}
EDA also uses statistics to identify outliers and detect patterns and other characteristics in the data. 
\end{frame}









\begin{frame} 
\frametitle{Introduction to Exploratory Spatial Data Analysis (ESDA)} 
It is an extension of EDA to detect spatial properties of data. \\
\vspace{0.5cm}

There is a need for additional techniques to

\begin{itemize}
\item detect spatial patterns in data
\item formulate hypotheses based on the geography of the data 
\item assess spatial models
\end{itemize}
\end{frame}









\begin{frame} 
\frametitle{Introduction to Exploratory Spatial Data Analysis (ESDA)} 


\begin{columns}[T] % align columns
\begin{column}{.48\textwidth}
First example of ESDA by Mark Monmonier (1989) Interactive Spatial Data Analysis\\
\vspace{0.5cm}
With modern graphical interfaces this is often done by ``brushing'' or ``highlighting'' observations
\end{column}%
\hfill%
\begin{column}{.48\textwidth}
\includegraphics[height=0.7\textheight]{Fig1-Monmonier1989.png}
\end{column}%
\end{columns}
\end{frame}



\begin{frame} 
\frametitle{Introduction to Exploratory Spatial Data Analysis (ESDA)} 

\begin{columns}[T] % align columns
\begin{column}{.48\textwidth}
These geographic brushing tools are now found in some GIS packages. \\
In addition to choropleth maps, other displays/views include histograms, box-plots, scatterplots (see GeoDa or the Micromaps package).
\end{column}%
\hfill%
\begin{column}{.48\textwidth}
\includegraphics[height=0.7\textheight]{prueba_micromap.png}
\end{column}%
\end{columns}
\end{frame}



\begin{frame} 
\frametitle{Introduction to Exploratory Spatial Data Analysis (ESDA)} 
\centering
``True ESDA pays attention to both spatial and attribute association'' (Anselin, 1998, p.79).
\end{frame}




\section{Spatial Autocorrelation}


\begin{frame} 
\frametitle{Spatial Autocorrelation} 
Tobler's First Law of Geography\\
\vspace{0.5cm}
``All places are related but nearby places are more related than distant place''\\

Spatial autocorrelation is the formal property that measures the degree to which near and distant things are related\\
\end{frame}


\subsection{Hypothesis}



\begin{frame} 
\frametitle{Spatial Autocorrelation} 
 Statistical test of match between locational similarity and attribute similarity\\
Correlation between 
\begin{itemize}
\item Positive
\item Negative
\item Random (Absense) 
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Let's remember from statistics class. 
\includegraphics[width=0.95\textwidth]{Examples_corr}
\end{frame}


\begin{frame}
\frametitle{Spatial Autocorrelation}
We need to consider how spatially correlated variables can be: 
\centering
\includegraphics[width=0.8\textwidth]{tiposasoc.pdf}

Which is negative? Which is positive? Which is random? 
\end{frame}





\begin{frame} 
\frametitle{Spatial Autocorrelation} 
Let's remember statistics again: \\
\textbf{Null hypothesis:}
\begin{itemize}
\item Spatial randomness
\item Values observed at one location do not depend on values observed at neighboring locations
\item Observed spatial pattern of values is equally likely as any other spatial pattern 
\item The location of values may be altered without affecting the information content of the data
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Positive spatial Autocorrelation
\begin{itemize}
\item Clustering:\\
 like values tend to be in similar locations
\item Neighbors are Similar\\
 more alike than they would be under spatial randomness
\item Compatible with Diffusion:\\
 but not necessarily caused by diffusion
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Positive spatial Autocorrelation
\includegraphics[width=0.8\textwidth]{Positive_Spauto}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Negative spatial Autocorrelation
\begin{itemize}
\item Checkerboard Pattern
\item ``opposite'' of clustering
\item Neighbors are Dissimilar, but more dissimilar than they would be under spatial randomness
\item Compatible with Competition, but not necessarily competition
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Negative spatial Autocorrelation
\includegraphics[width=0.8\textwidth]{Negative_Spauto}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Positive spatial Autocorrelation
\begin{itemize}
\item Positive Spatial Autocorrelation Does Not Imply Diffusion
\item diffusion tends to yield positive spatial autocorrelation, but the reverse is not necessary
\item spatial correlation may be due to structural factors, without contagion or diffusion
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}
Positive spatial Autocorrelation
\begin{itemize}
\item What is the Cause Behind Clustering 
\item True Contagion is the result of a contagious process, social interaction, a dynamic process. 

\item Apparent Contagion could be due to spatial heterogeneity, stratification
\item It Cannot Be Distinguished In a Pure Cross Section
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation}

\end{frame}


\subsection{Tests for the presence of Spatial autocorrelation }

\begin{frame}
\frametitle{Global Spatial Autocorrelation Tests}
Measure Clustering\\
 
 Global Characteristic of Spatial Pattern - NOT Local

\begin{itemize}
\item are like values more grouped in space than random
\item property of overall pattern = all the observations
\item test by means of a global spatial autocorrelation statistic
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Local Spatial Autocorrelation}


Measure Clusters\\

Local Characteristic of Spatial Pattern 
\begin{itemize}
\item where are like values more grouped in space than random
\item property of local pattern = location-specific
\item test by means of a local spatial autocorrelation statistic
\item local clusters may be compatible with global spatial randomness
\end{itemize}
\end{frame}



\begin{frame}
\frametitle{Spatial Autocorrelation Statistic}

\begin{itemize}
\item Formal Test of Match Between Value Similarity and Locational Similarity • 
\item Statistic Summarizes Both Aspects
\item Significance\\
how likely is it (p-value) that the computed statistic would take this (extreme) value in a spatially random pattern
\end{itemize}
\end{frame}

\subsection{Issues to consider}


\begin{frame} 
\frametitle{Issues to consider} 


We remember the types of data
\begin{itemize}
\item Point data:\\
Accuracy of location is very important
\item Area/lattice dat:\\
 Data reported for some regular or irregular areal unit
\end{itemize}
\end{frame}









\begin{frame} 
\frametitle{Issues to consider} 
There are 2 key components of spatial data:
\begin{itemize}
\item Attribute data
\item Spatial data
\end{itemize}

And How you choose to sample, or aggregate, your data is very important\\
\textbf{ Affect spatial relationships in your data}
\end{frame}




\begin{frame} 
\frametitle{Issues to consider}
There are problems/challenges with areal data\\

\begin{itemize}
\item Modifiable areal unit problem (MAUP)
\item Scale effect spatial data analysis at different scales may produce different results
\item Zoning effect regrouping zones at a given scale may produce different results
\end{itemize}

 What are the ?
\begin{itemize}
\item Optimal neighborhood/area size.
\item Alternative zoning schemes.
\end{itemize}
\end{frame}




\begin{frame} 
\frametitle{Issues to consider}
Spatial autocorrelation is Scale-Dependent\\


\includegraphics[width=0.8\textwidth]{Scale_unit}
\end{frame}

















\begin{frame} 
\frametitle{Exploratory Spatial Data Analysis (ESDA)} 
In many instances it is important to be able to link numerical and graphical procedures with a map to answer questions such as "Where are those cases?"


\end{frame}



\section{ESDA using R }


\frame[containsverbatim]{\frametitle{Load required library and Data}
First We need to install the packages \textbf{spdep} and maptools\\
%<<install-libraries>>=
%  install.packages(c('sp','spdep','maptools'))
%@
    
    
After installing the libraries we need to load them up    
\begin{Schunk}
\begin{Sinput}
>   library(spdep)
> library(maptools)
\end{Sinput}
\end{Schunk}
}


\frame[containsverbatim]{\frametitle{Load the Data}
\tiny{
\begin{Schunk}
\begin{Sinput}
> shape <- readShapePoly("Statesmod.shp",IDvar="NAME" )
> summary(shape)
\end{Sinput}
\begin{Soutput}
Object of class SpatialPolygonsDataFrame
Coordinates:
        min       max
x -124.7631 -66.94989
y   24.5231  49.38436
Is projected: NA 
proj4string : [NA]
Data attributes:
         SP_ID       STATEFP       STATENS          AFFGEOID      GEOID        STUSPS            NAME    LSAD        ALAND               AWATER                  State      Violent_Cr         Murder         Forcible_r       Robbery        Aggravated   
 Alabama    : 1   01     : 1   00068085: 1   0400000US01: 1   01     : 1   AL     : 1   Alabama    : 1   00:49   Min.   :1.584e+08   Min.   :1.863e+07   Alabama    : 1   Min.   : 119.4   Min.   : 0.900   Min.   :12.90   Min.   : 12.2   Min.   : 63.0  
 Arizona    : 1   04     : 1   00294478: 1   0400000US04: 1   04     : 1   AR     : 1   Arizona    : 1           1st Qu.:9.279e+10   1st Qu.:1.536e+09   Arizona    : 1   1st Qu.: 299.3   1st Qu.: 3.000   1st Qu.:26.90   1st Qu.: 67.7   1st Qu.:162.7  
 Arkansas   : 1   05     : 1   00448508: 1   0400000US05: 1   05     : 1   AZ     : 1   Arkansas   : 1           Median :1.389e+11   Median :3.543e+09   Arkansas   : 1   Median : 385.1   Median : 4.900   Median :32.70   Median :112.3   Median :227.3  
 California : 1   06     : 1   00481813: 1   0400000US06: 1   06     : 1   CA     : 1   California : 1           Mean   :1.562e+11   Mean   :8.744e+09   California : 1   Mean   : 432.1   Mean   : 5.486   Mean   :33.37   Mean   :127.8   Mean   :267.7  
 Colorado   : 1   08     : 1   00606926: 1   0400000US08: 1   08     : 1   CO     : 1   Colorado   : 1           3rd Qu.:2.062e+11   3rd Qu.:8.504e+09   Colorado   : 1   3rd Qu.: 512.3   3rd Qu.: 6.600   3rd Qu.:38.90   3rd Qu.:165.1   3rd Qu.:344.0  
 Connecticut: 1   09     : 1   00662849: 1   0400000US09: 1   09     : 1   CT     : 1   Connecticut: 1           Max.   :6.766e+11   Max.   :1.040e+11   Connecticut: 1   Max.   :1437.7   Max.   :31.400   Max.   :76.50   Max.   :748.5   Max.   :626.4  
 (Other)    :43   (Other):43   (Other) :43   (Other)    :43   (Other):43   (Other):43   (Other)    :43                                                   (Other)    :43   NA's   :2                         NA's   :2                                      
   Property_C      Burglary        Larceny_th     Motor_vehi          FIPS          FIPS2      X        
 Min.   :1881   Min.   : 334.3   Min.   :1413   Min.   :  89.6   Min.   : 1.0   Min.   : 1.0   \001: 1  
 1st Qu.:2620   1st Qu.: 497.4   1st Qu.:1850   1st Qu.: 184.0   1st Qu.:18.0   1st Qu.:18.0   NA's:48  
 Median :3287   Median : 649.6   Median :2180   Median : 268.8   Median :30.0   Median :30.0            
 Mean   :3186   Mean   : 703.1   Mean   :2190   Mean   : 292.0   Mean   :29.8   Mean   :29.8            
 3rd Qu.:3780   3rd Qu.: 945.2   3rd Qu.:2485   3rd Qu.: 349.6   3rd Qu.:42.0   3rd Qu.:42.0            
 Max.   :5105   Max.   :1231.2   Max.   :3372   Max.   :1092.4   Max.   :56.0   Max.   :56.0            
\end{Soutput}
\end{Schunk}
}
}

\frame[containsverbatim]{\frametitle{Create the Weight matrix- Queen}
\tiny{
\begin{Schunk}
\begin{Sinput}
> nb2=poly2nb(shape, queen=TRUE) 
> nb2 
\end{Sinput}
\begin{Soutput}
Neighbour list object:
Number of regions: 49 
Number of nonzero links: 218 
Percentage nonzero weights: 9.07955 
Average number of links: 4.44898 
\end{Soutput}
\begin{Sinput}
> plot(shape, border="grey60") 
> plot(nb2, coordinates(shape), add=TRUE, pcv=".", lwd=2) 
\end{Sinput}
\end{Schunk}
}
}

\frame[containsverbatim]{\frametitle{Create the Weight matrix- Queen}
\tiny{
 \includegraphics[height=0.8\textheight]{RRIWS_3_ESDA_R-Create-weight-matrixqueen}
}
}

\frame[containsverbatim]{\frametitle{Create the Weight matrix- Rook}
\tiny{
\begin{Schunk}
\begin{Sinput}
> nb2=poly2nb(shape, queen=TRUE) 
> nb2 
\end{Sinput}
\begin{Soutput}
Neighbour list object:
Number of regions: 49 
Number of nonzero links: 218 
Percentage nonzero weights: 9.07955 
Average number of links: 4.44898 
\end{Soutput}
\begin{Sinput}
> plot(shape, border="grey60") 
> plot(nb2, coordinates(shape), add=TRUE, pcv=".", lwd=2) 
\end{Sinput}
\end{Schunk}
}
}

\frame[containsverbatim]{\frametitle{Create the Weight matrix- Rook}
\tiny{
 \includegraphics[height=0.8\textheight]{RRIWS_3_ESDA_R-Create-weight-matrixrook}
}
}


\frame[containsverbatim]{\frametitle{Create the Weight matrix- Rook}
\tiny{
\begin{Schunk}
\begin{Sinput}
> sids <- readShapePoly(system.file("etc/shapes/sids.shp", package="spdep")[1], 
+ ID="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))
> sids_nbr<-poly2nb(sids,queen=F) 
> plot(sids, border="grey60") 
> plot(sids_nbr, coordinates(sids), add=TRUE, pcv=".", lwd=2) 
\end{Sinput}
\end{Schunk}
}
 \includegraphics[height=0.8\textheight]{RRIWS_3_ESDA_R-weight-matrixsidsrook}
}

\frame[containsverbatim]{\frametitle{Create the Weight matrix - Queen}
\tiny{
\begin{Schunk}
\begin{Sinput}
> sids <- readShapePoly(system.file("etc/shapes/sids.shp", package="spdep")[1], 
+   ID="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))
> sids_nbq<-poly2nb(sids,queen=T) 
> plot(sids, border="grey60") 
> plot(sids_nbq, coordinates(sids), add=TRUE, pcv=".", lwd=2) 
\end{Sinput}
\end{Schunk}
 \includegraphics[height=0.8\textheight]{RRIWS_3_ESDA_R-Create-weight-matrixsidsqueen}
}
}


\frame[containsverbatim]{\frametitle{Create the Weight matrix- Comparison}
\begin{figure}
  \centering
  \begin{subfigure}[t]{0.65\textwidth}
   \centering
  \includegraphics[width=\linewidth]{RRIWS_3_ESDA_R-Create-weight-matrixsidsqueen_copy.png}
 \end{subfigure}
 
 \begin{subfigure}[t]{0.65\textwidth}
\centering
 \includegraphics[width=\linewidth]{RRIWS_3_ESDA_R-weight-matrixsidsrook_copy.png}
 \end{subfigure}
\end{figure}
}


\frame[containsverbatim]{\frametitle{Binary W matrix or Weighted W matrix}
\tiny{
\begin{Schunk}
\begin{Sinput}
>  nb2_B=nb2listw(nb2, style="B", zero.policy=TRUE) 
>  nb2_W=nb2listw(nb2, style="W", zero.policy=TRUE) 
\end{Sinput}
\end{Schunk}
 You can save the weights. 
\begin{Schunk}
\begin{Sinput}
>  write.nb.gal(nb2,"pesoscol.GAL")
\end{Sinput}
\end{Schunk}
}
}



\end{document}


