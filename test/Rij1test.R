#RScript - please enter your code here !

library(RIJ1)
imagePlus<-loadImage("https://imagej.nih.gov/ij/images/blobs.gif")
showImage(imagePlus)
ip<-getImageProcessor(imagePlus)
#intMatrix<-getImageMatrix(ip)
floatMatrix<-getFloatMatrix(ip)
plotIJ1Coords(floatMatrix)