#' Load the R library!
#' @examples library(RIJ1)
#' @import rJava
#' @export
RIJ1 <- function() {
    require(rJava)
    # tempDir <- getwd() Initialize Java!
    .jinit()
    
    # Add the ImageJ *.jar to the classpath! .jaddClassPath('ij.jar')
    
    
}

#' Open an image!
#' 
#' @param path The path argument.
#'
#'
#' @examples imagePlus<-loadImage('http://imagej.nih.gov/ij/images/blobs.gif')
#' @export
loadImage <- function(path) {
    # Open an image with another method (slowlier but easier to read using
    # reflection)! im=IJ$openImage('C:/bilder luft/Capture_00001.JPG');
    # Create a new object!
    IJ <- .jnew("ij/IJ")
    # Open the image! im$show()
    im <- .jcall(IJ, "Lij/ImagePlus;", "openImage", path)
    return(im)
    
}

#'Show the image!
#' 
#' @param im The im argument.
#'
#'
#' @examples showImage(imagePlus)
#' @export
showImage <- function(im) {
    # Call the show method!
    .jcall(im, , "show")
}

# Infos about methods! .jmethods(IJ, 'openImage')

#' Get a reference to the ImageProcessor class!
#' 
#' @param im The im argument.
#'
#' @examples ip<-getImageProcessor(imagePlus)
#' @export
getImageProcessor <- function(im) {
    ip <- .jcall(im, "Lij/process/ImageProcessor;", "getProcessor")
    return(ip)
}


#' Get integer values from the ImageProcessor!
#' 
#' @param ip The ip argument.
#' @examples integerMatrix<-getIntegerMatrix(ip)
#' @export
getIntegerMatrix <- function(ip) {
    intValues <- t(sapply(.jcall(ip, returnSig = "[[I", "getIntArray"), 
        .jevalArray))
    return(intValues)
}


#' Get float values from the ImageProcessor!
#' 
#' @param ip The ip argument.
#'
#'
#' @examples floatMatrix<-getFloatMatrix(ip)
#' @export
getFloatMatrix <- function(ip) {
    floatValues <- t(sapply(.jcall(ip, returnSig = "[[F", "getFloatArray"), 
        .jevalArray))
    return(floatValues)
}

#' Get matrix values.
#' 
#'
#'
getRGBMatrix <- function() {
    mat <- NULL
    r <- .jnew("byte[]")
    g <- .jnew("byte[]")
    b <- .jnew("byte[]")
    ip <- .jcall(ip, "V", "getRGB", r, g, b)
}


#' Transpose the values for the correct image matrix! intValues<-t(intValues)
#' Plot the integer values with origin in the upper left! 
#' @param intValues The values argument.
#'
#'
#' @examples plotIJ1Coords(floatMatrix)
#' @export
plotIJ1Coords <- function(intValues) {
    image(intValues, useRaster = TRUE, ylim = c(1, 0))
}
