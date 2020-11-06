### R code from vignette source 'RRIWS_3_ESDA_R.Rnw'

###################################################
### code chunk number 1: install-libraries
###################################################
install.packages(c('sp','spdep','maptools'))


###################################################
### code chunk number 2: library
###################################################
  library(spdep)
library(maptools)


###################################################
### code chunk number 3: data01
###################################################
shape <- readShapePoly("Statesmod.shp",IDvar="NAME" )
summary(shape)


###################################################
### code chunk number 4: Create-weight-matrixdataqueen
###################################################
nb2=poly2nb(shape, queen=TRUE) 
nb2 
plot(shape, border="grey60") 
plot(nb2, coordinates(shape), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 5: Create-weight-matrixqueen1
###################################################
nb2=poly2nb(shape, queen=TRUE) 
plot(shape, border="grey60") 
plot(nb2, coordinates(shape), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 6: Create-weight-matrixdatarook
###################################################
nb2=poly2nb(shape, queen=FALSE) 
nb2 
plot(shape, border="grey60") 
plot(nb2, coordinates(shape), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 7: Create-weight-matrixrook
###################################################
nb2=poly2nb(shape, queen=F) 
plot(shape, border="grey60") 
plot(nb2, coordinates(shape), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 8: weight-matrixsidsrook
###################################################
sids <- readShapePoly("sids.shp", ID="FIPSNO")
sids_nbr<-poly2nb(sids,queen=F) 
plot(sids, border="grey60") 
plot(sids_nbr, coordinates(sids), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 9: Create-weight-matrixsidsqueen
###################################################
sids_nbq<-poly2nb(sids,queen=T) 
 
plot(sids, border="grey60") 
plot(sids_nbq, coordinates(sids), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 10: Compare-weight-matrixsidsqueen
###################################################
sids_nbq<-poly2nb(sids,queen=T) 
 sids_nbr<-poly2nb(sids,queen=F) 
plot(sids, border="grey60") 
plot(sids_nbq, coordinates(sids), add=TRUE, pcv=".",col="red", lwd=2) 
plot(sids_nbr, coordinates(sids), add=TRUE, pcv=".",col="blue", lwd=2) 


###################################################
### code chunk number 11: matrixstatesK4
###################################################
coords <- coordinates(shape)
states.knn <- knearneigh(coords, k=4)
 
plot(shape, border="grey60") 
plot(knn2nb(states.knn), coordinates(shape), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 12: matrixstatesK3
###################################################
coords <- coordinates(shape)
states.knn <- knearneigh(coords, k=3)
 
plot(shape, border="grey60") 
plot(knn2nb(states.knn), coordinates(shape), add=TRUE, pcv=".", lwd=2) 


###################################################
### code chunk number 13: listw-weightmatrixdata
###################################################
 nb2_B=nb2listw(nb2, style="B", zero.policy=TRUE) 
 nb2_W=nb2listw(nb2, style="W", zero.policy=TRUE) 


###################################################
### code chunk number 14: save-weightmatrixdata
###################################################
 write.nb.gal(nb2,"pesoscol.GAL")


###################################################
### code chunk number 15: Moran1
###################################################
moran.test(shape$Murder, listw=nb2_W,alternative="two.sided")


###################################################
### code chunk number 16: Moran1
###################################################
moran=moran.test(shape$Murder, listw=nb2_B)
moran


###################################################
### code chunk number 17: Moran1
###################################################
set.seed(1234)
bperm=moran.mc(shape$Murder, listw=nb2_W, nsim=999)
bperm


###################################################
### code chunk number 18: Moran1
###################################################
gearyR=geary.test(shape$Murder, listw=nb2_W)
gearyR


###################################################
### code chunk number 19: Moran1
###################################################
moran.plot(shape$Murder, listw=nb2_W,label=as.character(shape$STUSPS),xlab="Murder Rate", ylab="Spatially Lagged Murder Rate")



###################################################
### code chunk number 20: Moran_scatter1
###################################################
moran.plot2 <- function(x,wfile) 
{ 
xname <- deparse(substitute(x)) # get name of variable 
zx <- (x - mean(x))/sd(x) 
wzx <- lag.listw(wfile,zx, zero.policy=TRUE) 
morlm <- lm(wzx ~ zx) 
aa <- morlm$coefficients[1] 
mori <- morlm$coefficients[2] 
par(pty="s") 
plot(zx,wzx,xlab=xname,ylab=paste("Spatial Lag of ",xname)) 
abline(aa,mori,col=2) 
abline(h=0,lty=2,col=4) 
abline(v=0,lty=2,col=4) 
title(paste("Moran Scatterplot I= ",format(round(mori,4)))) 
} 

moran.plot2(shape$Murder, nb2_W)


###################################################
### code chunk number 21: Moran_scatter2
###################################################
moran.plot2(shape$Murder, nb2_W)


###################################################
### code chunk number 22: Moran_scatter3
###################################################
moran.plot3 <- function(x,y,wfile) 
{ 
xname <- deparse(substitute(x)) # get name of variable 
yname =deparse(substitute(y))
zx <- (x - mean(x))/sd(x) 
zy =(y - mean(y))/sd(y)
wzy <- lag.listw(wfile,zy, zero.policy=TRUE) 
morlm <- lm(wzy ~ zx) 
aa <- morlm$coefficients[1] 
mori <- morlm$coefficients[2] 
par(pty="s") 
plot(zx,wzy,xlab=xname,ylab=paste("Spatial Lag of ",yname)) 
abline(aa,mori,col=2) 
abline(h=0,lty=2,col=4) 
abline(v=0,lty=2,col=4) 
title(paste("Moran Scatterplot I= ",format(round(mori,4)))) 
} 

moran.plot3(shape$Murder,shape$Robbery, nb2_W)


###################################################
### code chunk number 23: Moran_scatter4
###################################################
moran.plot3(shape$Murder,shape$Robbery, nb2_W)


###################################################
### code chunk number 24: LMoran0
###################################################
LISA.plot <- function(var,listw,signif,mapa) {
  mI.loc <- localmoran(var,listw, zero.policy=T)
  c.var <- var - mean(var)
  c.mI <- mI.loc[,1] - mean(mI.loc[,1])
  quadrant <- vector(mode="numeric",length=nrow(mI.loc))
wzx <- lag.listw(listw,var, zero.policy=TRUE) 
  c.mI1 <- wzx - mean(wzx)
  quadrant[c.var>0 & c.mI1>0] <- 4
  quadrant[c.var<0 & c.mI1<0] <- 1
  quadrant[c.var<0 & c.mI1>0] <- 2
  quadrant[c.var>0 & c.mI1<0] <- 3
  quadrant[mI.loc[,5]>signif] <- 0
  brks <- c(0,1,2,3,4)
  colors <- c("white","blue",rgb(0,0,1,alpha=0.4),rgb(1,0,0,alpha=0.4),"red")
  plot(mapa,border="gray90",col=colors[findInterval(quadrant,brks,all.inside=FALSE)])
  box()
   legend("bottomright",legend=c("not significant","low-low","low-high","high-low","high-high"), fill=colors,bty="n", cex=0.7,y.intersp=1,x.intersp=1)
   title("LISA Mapa de Clusters")
  }


###################################################
### code chunk number 25: LMoran_scatter1
###################################################
LISA.plot(shape$Murder, nb2_W,0.1, shape) 


###################################################
### code chunk number 26: LMoran_scatter2
###################################################
LISA.plot(shape$Murder, nb2_W,0.05, shape) 


###################################################
### code chunk number 27: datacounties
###################################################
shapec <- readShapePoly("countiesmod.shp",IDvar="GEOID" )
summary(shapec)


###################################################
### code chunk number 28: county-matrixdataqueen
###################################################
nb2c=poly2nb(shapec, queen=TRUE) 
nb2c 
plot(shapec, border="grey60") 
plot(nb2c, coordinates(shapec), add=TRUE, pcv=".", lwd=2) 
 nb2_Wc=nb2listw(nb2c, style="W", zero.policy=TRUE)


###################################################
### code chunk number 29: Moran_scattercounty1
###################################################

moran.plot2(shapec$Bachelor, nb2_Wc)


###################################################
### code chunk number 30: LMoran_county1
###################################################
LISA.plot(shapec$Bachelor, nb2_Wc,0.05, shapec) 


