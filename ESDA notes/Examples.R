###examples
library(maptools)
library(spdep)
fn <- system.file("etc/shapes/eire.shp", package = "spdep")
fn <- system.file("etc/shapes/eire.shp", package = "spdep")[1]
 prj <- CRS("+proj=utm +zone=30 +units=km +ellps=mod_airy")
 eire <- readShapeSpatial(fn, ID = "names", proj4string = prj)
plot(eire)

nbrook=poly2nb(eire, queen=F) 
nbqueen=poly2nb(eire, queen=TRUE) 

###
nbqueen
nbrook

library(rgdal)
sids<-readOGR(dsn="shapefiles",layer="sids2")
sids <- readShapePoly(system.file("etc/shapes/sids.shp", package="spdep")[1],  ID="FIPSNO", proj4string=CRS("+proj=longlat +ellps=clrk66"))

sids_nbq<-poly2nb(sids)

plot(sids)

\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}
  <<optionsset,echo=FALSE>>=
    options(prompt = "R> ", continue = "+  ", width = 120, useFancyQuotes = TRUE)
  @
    
    <<install-libraries>>=
    install.packages(c('sp','maptools','classInt','RColorBrewer'))
  install.packages(c('maps','loa','RgoogleMaps'))
  @
    
    
    <<library>>=
    library(sp)
  library(maptools)
  @
}


\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}
  \tiny{
    <<data01>>=
      shape <- readShapePoly("States_shapefile.shp",IDvar="NAME" )
      summary(shape)
      @
  }
}

\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}
  \tiny{
    <<data01>>=
      tab=read.csv("crime_Rates_States_2.csv")
      names(tab)
      @
  }
}

\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}
  Join the data to the shapefile
  make the ID variable from the data table into class ``character''
  \tiny{
    <<Make-the-join1>>=
      shpID <- sapply(slot(shape,"polygons"),function(x) slot(x,"ID"))
      tabID <- as.character(tab$State)
      @
  }
}

\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}
  match the two unique identifiers\\
  match() needs both its arguments to be of the same class. Here: ``character''\\
  
  if you want to keep all polygons\\
  matches both IDs and replaces nomatch values by NA\\
  <<Make-the-join2>>=
    tab <- tab[match(shpID,tabID),]
  rownames(tab) <- shpID
  shape.mod <- spCbind(shape,tab)
  @
    
    Save a new shapefile in the current working directory    
  <<Make-the-join3>>=
    writePolyShape(shape.mod,"statesmod")
  @
}

\frame[containsverbatim]{\frametitle{Make the map}
  <<library2>>=
    library(classInt)
  library(RColorBrewer)
  @
}


\frame[containsverbatim]{\frametitle{Make the map}
  loads the new shapefile with the counties
  \tiny{
    <<data2>>=
      shape <- shape.mod
      summary(shape)
      names(shape)
      @
  }}

\frame[containsverbatim]{\frametitle{Make the map}
  Defines the color palette, you can find more codes in http://colorbrewer2.com
  <<color2>>=
    pal <- brewer.pal(6, "Reds")[0:6]
  @
    
    creates the intervals
  <<interval2>>=
    q7 <- classIntervals(shape$Murder, n = 6, style = "quantile")
  @
    
    joins the colors and the rates to have a database for all the counties. 
  <<color-interval2>>=
    q7Colours <- findColours(q7, pal)
  @
}

\frame[containsverbatim]{\frametitle{Make the map}
  <<figure-saving-state1,fig=T>>=
    plot(shape, col = q7Colours, pch = 21)
  box()
  title(main = "Murder Rate by State")
  legend("topleft", fill = attr(q7Colours, "palette"), legend =names(attr(q7Colours,  "table")), bty = "n", cex = 0.8, y.intersp = 0.8)
  @
}

\frame[containsverbatim]{\frametitle{Make the map}
  <<figure-saving-state2,fig=T,echo=F>>=
    plot(shape, col = q7Colours, pch = 21)
  box()
  title(main = "Murder Rate by State")
  legend("topleft", fill = attr(q7Colours, "palette"), legend =names(attr(q7Colours,  "table")), bty = "n", cex = 0.8, y.intersp = 0.8)
  @
}

\frame[containsverbatim]{\frametitle{Make the map}
  with the png and the dev.off() it will save the file after creating the map,
  <<figure-saving>>=
    png("Murder-rate.png",width=600,height=600)
  plot(shape, col = q7Colours, pch = 21)
  box()
  title(main = "Murder Rate by State")
  legend("topleft", fill = attr(q7Colours, "palette"), legend =names(attr(q7Colours,  "table")), bty = "n", cex = 0.8, y.intersp = 0.8)
  dev.off()
  @
}

\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}
  Load the shapefile and the data
  \tiny{
    <<data>>=
      shape2 <- readShapePoly("tl_2016_us_county.shp",IDvar="GEOID" )
      names(shape2)
      tab=read.csv("Education.csv")
      names(tab)
      @
  }
  
  Join the data to the shapefile
  make the ID variable from the data table into class ``character''
  \tiny{
    <<Make-the-join1>>=
      shpID <- sapply(slot(shape2,"polygons"),function(x) slot(x,"ID"))
      summary(shpID)
      tabID <- as.character(tab$Id2)
      @
  }
}



\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}  
  match the two unique identifiers\\
  match() needs both its arguments to be of the same class. Here: ``character''\\
  
  if you want to delete polygons with no matching data in the table\\
  
  matches both IDs and replaces nomatch values by NA\\
  matches and removes the non-matching locations from the table and the original shapefile\\
  <<Make-the-join2>>=
    tab <- tab[match(shpID,tabID),]
  rownames(tab) <- shpID
  tab <- tab[shpID%in%tabID,]
  shape.mod2 <- shape2[shpID%in%tabID,]
  shape.mod2 <- spCbind(shape.mod2,tab)
  @
}

\frame[containsverbatim]{\frametitle{Load required library, Data, and Make the Join}  
  Writes a new shapefile in the current working directory\\
  <<Make-the-join3>>=
    writePolyShape(shape.mod2,"countiesmod")
  @
}



\frame[containsverbatim]{\frametitle{Make the map}
  loads the new shapefile with the counties\\
  \tiny{
    <<data2>>=
      shape2 <- shape.mod2
      names(shape2)
      summary(shape2)
      @
  }
}


\frame[containsverbatim]{\frametitle{Make the map}
  loads the shapefile with the states\\
  <<data2>>=
    shape1 <- readShapePoly("tl_2016_us_state.shp")
  @
}


\frame[containsverbatim]{\frametitle{Make the map}
  Defines the color palette, you can find more codes in \href{http://colorbrewer2.com}{http://colorbrewer2.com}\\
  <<color>>=
    pal <- brewer.pal(6, "RdYlBu")[0:6]
  @
    creates the intervals
  <<interval>>=
    q7 <- classIntervals(shape2$Bachelor, n = 6, style = "quantile")
  @
    
    joins the colors and the rates to have a database for all the counties. 
  <<color-interval>>=
    q7Colours <- findColours(q7, pal)
  @
}

\frame[containsverbatim]{\frametitle{Make the map}
  \tiny{
    <<figure-saving-bachelor1,fig=T>>=
      plot(shape2)
    plot(shape1,add=T)
    plot(shape2, col = q7Colours,add=T, pch = 21)
    box()
    title(main = "Percentage of Population with Bachelor")
    legend("topleft", fill = attr(q7Colours, "palette"), legend =names(attr(q7Colours,  "table")), bty = "n", cex = 0.8, y.intersp = 0.8)
    @
  }
}



\frame[containsverbatim]{\frametitle{Make the map}
  <<figure-saving-bachelor2,fig=T,echo=F>>=
    plot(shape2)
  plot(shape1,add=T)
  plot(shape2, col = q7Colours,add=T, pch = 21)
  box()
  title(main = "Percentage of Population with Bachelor")
  legend("topleft", fill = attr(q7Colours, "palette"), legend =names(attr(q7Colours,  "table")), bty = "n", cex = 0.8, y.intersp = 0.8)
  @
}



\frame[containsverbatim]{\frametitle{Make the map}
  with the png and the dev.off() it will save the file after creating the map,
  <<figure-saving,fig=F>>=
    png("Bachelor.png",width=600,height=600)
  plot(shape2)
  plot(shape1,add=T)
  plot(shape2, col = q7Colours,add=T, pch = 21)
  box()
  title(main = "Percentage of Population with Bachelor")
  legend("topleft", fill = attr(q7Colours, "palette"), legend =names(attr(q7Colours,  "table")), bty = "n", cex = 0.8, y.intersp = 0.8)
  dev.off()
  @
}


\frame[containsverbatim]{\frametitle{Make the map}
  \tiny{
    <<map-spplot1-bachelor1,fig=T,echo=F>>=
      at <- pretty(shape2$Bachelor, n=10)
      cols <- colorRampPalette(brewer.pal(9, "PiYG"))(length(at)-1)
      print(spplot(shape2, "Bachelor", col.regions=cols, at=at, main="Percentage of Population with Bachelor"))
      @
  }
}

\frame[containsverbatim]{\frametitle{Make the map}
  <<map-spplot1-bachelor,fig=T>>=
    at <- pretty(shape2$Bachelor, n=10)
    cols <- colorRampPalette(brewer.pal(9, "PiYG"))(length(at)-1)
    print(spplot(shape2, "Bachelor", col.regions=cols, at=at, main="Percentage of Population with Bachelor"))
    @
}


\frame[containsverbatim]{\frametitle{Make a loop to create the data map}
  We need to load the data
  \tiny{
    <<Load-the-data1>>=
      cigar <- read.table("Cigar.txt", header=TRUE)
      sn <- read.table("States.txt", header=TRUE)
      cigar$state <- factor(cigar$state, levels=sn$state, labels=as.character(sn$name))
      dim(cigar)
      @
  }
}

\frame[containsverbatim]{\frametitle{Make a loop to create the data map}
  \tiny{
    <<Reformat-the-data1>>=
      yrs <- as.character(unique(cigar$year))
      (ly <- length(yrs))
      (lo <- length(unique(cigar$state)))
      cigar1 <- reshape(cigar, timevar="year", idvar="state", direction="wide")
      dim(cigar1)
      @
  }
}

\frame[containsverbatim]{\frametitle{Make a loop to create the data map}
  <<Reformat-the-data3>>=
    row.names(cigar1) <- tolower(as.character(cigar1$state))
    row.names(cigar1)[7] <- "district of columbia"
    @
}

\frame[containsverbatim]{\frametitle{Make a loop to create the data map}
  \tiny{
    <<Attachdata-map>>=
      library(maps)
    US <- map("state", row.names(cigar1), fill=TRUE, plot=FALSE)
    IDs <- sapply(strsplit(US$names, ":"), function(x) x[[1]])
    Cigar_sp <- map2SpatialPolygons(US, IDs, proj4string=CRS("+proj=longlat"))
    Cigar <- SpatialPolygonsDataFrame(Cigar_sp, data=cigar1)
    @
  }
}


\frame[containsverbatim]{\frametitle{Make a loop to create the data map}
  \tiny{
    <<createmaps>>=
      dir.create("movie")
    library(RColorBrewer)
    at <- pretty(cigar$sales_pc, n=10)
    cols <- colorRampPalette(brewer.pal(9, "PiYG"))(length(at)-1)
    for (i in yrs) {
      png(file=paste("movie/pic", i, ".png", sep=""), width=960, height=600)
      print(spplot(Cigar, paste("sales_pc", i, sep="."), col.regions=cols, at=at, main=paste("Sales per capita 19", i, sep="")))
      dev.off()
    }
    @
  }
}

\section{Points maps}

\frame[containsverbatim]{\frametitle{Make a map with point data}
  <<Load-the-data4>>=
    require(sp)
  require(RgoogleMaps)
  data("meuse", package = "sp", envir = environment())
  data(lat.lon.meuse, package="loa")
  @
}




\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<createmaps202,fig=F>>=
      data(meuse)
    coordinates(meuse) <- c("x", "y")
    par(cex.main=2,cex.lab=2)
    bubble(meuse, "zinc", main = "zinc concentrations (ppm)",
           key.entries =  100+ 100 * 2^(0:4),key.space = "inside")
    @
  }
}

\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<label=createmaps201, fig=TRUE, echo=FALSE, include=FALSE>>=
      data(meuse)
    coordinates(meuse) <- c("x", "y")
    par(cex.main=2,cex.lab=2)
    bubble(meuse, "zinc", main = "zinc concentrations (ppm)",key.entries =  100+ 100 * 2^(0:4),key.space = "inside")
    @
      \includegraphics[height=0.8\textheight]{RRIWS_2_maps_R-createmaps201}
  }
}

\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<createmaps20>>=
      data(meuse)
    coordinates(meuse) <- c("x", "y")
    png("meuseBubble1.png", width=480, height=480)
    par(cex.main=2,cex.lab=2)
    bubble(meuse, "zinc", main = "zinc concentrations (ppm)",
           key.entries =  100+ 100 * 2^(0:4),key.space = "inside")
    dev.off()
    @
  }
}



\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<createmaps21,fig=F>>=
      map <- GetMap(center=c(lat=50.97494,lon=5.743606), zoom=13,size=c(480,480),destfile = paste0(tempdir(),"\\meuse.png"), maptype="mobile", SCALE = 1);
      bubbleMap(lat.lon.meuse, coords = c("longitude","latitude"),
                map=map,zcol='zinc', key.entries = 100+ 100 * 2^(0:4));
      @
  }
}

\frame[containsverbatim]{\frametitle{Make a map with point data}
  <<label=createmaps22, fig=TRUE, echo=FALSE, include=FALSE>>=
    map <- GetMap(center=c(lat=50.97494,lon=5.743606), zoom=13,size=c(480,480),destfile = paste0(tempdir(),"\\meuse.png"), maptype="mobile", SCALE = 1);
    bubbleMap(lat.lon.meuse, coords = c("longitude","latitude"), 
              map=map,zcol='zinc', key.entries = 100+ 100 * 2^(0:4));
    @
      \includegraphics[height=0.8\textheight]{RRIWS_2_maps_R-createmaps22}
}

\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<createmaps23>>=
      png("meuseBubble2.png", width=480, height=480)
    par(cex=1.5)
    bubbleMap(lat.lon.meuse, coords = c("longitude","latitude"),
              map=map,zcol='zinc',  key.entries = 100+ 100 * 2^(0:4));
    dev.off()
    @
  }
}

\section{Rgooglemaps with polygons}
\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<createmaps24f,fig=T>>=
      coords=coordinates(shape)
      mapshape <- GetMap(center=c(lat=mean(coords[,2]),
                                  lon=mean(coords[,1])), destfile = "statesimage.png", 
                         maptype = "mobile", zoom=3)
      Murderdata=shape$Murder
      ColorMap(Murderdata, mapshape, shape, add = FALSE,alpha = 0.35, log = TRUE, location = "bottomleft")
      @
  }
}


\frame[containsverbatim]{\frametitle{Make a map with point data}
  <<label=createmaps25f, fig=TRUE, echo=FALSE, include=FALSE>>=
    coords=coordinates(shape)
    mapshape <- GetMap(center=c(lat=mean(coords[,2]),
                                lon=mean(coords[,1])), destfile = "statesimage.png", 
                       maptype = "mobile", zoom=3)
    Murderdata=shape$Murder
    ColorMap(Murderdata, mapshape, shape, add = FALSE,alpha = 0.35, log = TRUE, location = "bottomleft")
    @
      \includegraphics[height=0.8\textheight]{RRIWS_2_maps_R-createmaps25f}
}


\frame[containsverbatim]{\frametitle{Make a map with point data}
  \tiny{
    <<createmaps26f,fig=T>>=
      coords=coordinates(shape2)
      mapshape <- GetMap(center=c(lat=mean(coords[,2]),
                                  lon=mean(coords[,1])), destfile = "contiesimage.png", 
                         maptype = "mobile", zoom=6)
      Murderdata=shape2$Bachelor
      ColorMap(Murderdata, mapshape, shape2, add = FALSE,alpha = 0.35, log = TRUE, location = "topleft")
      @
  }
}


\frame[containsverbatim]{\frametitle{Make a map with point data}
  <<label=createmaps27f, fig=TRUE, echo=FALSE, include=FALSE>>=
    coords=coordinates(shape2)
    mapshape <- GetMap(center=c(lat=mean(coords[,2]),
                                lon=mean(coords[,1])), destfile = "countiesimage.png", 
                       maptype = "mobile", zoom=6)
    Murderdata=shape2$Bachelor
    ColorMap(Murderdata, mapshape, shape2, add = FALSE,alpha = 0.35, log = TRUE, location = "bottomright")
    @
      \includegraphics[height=0.8\textheight]{RRIWS_2_maps_R-createmaps27f}
}

