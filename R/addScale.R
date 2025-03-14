#' @title Add Map Scalebar
#' Adds a scalebar onto a map
#' @author Thomas Bryce Kelly
#' @param basemap a basemap list object
#' @param scale the length of the scale bar added (km)
#' @param col color
#' @param cex the size
#' @param pos position 1:4 of the scale bar
#' @export
addScale = function(basemap,
                    pos = 1,
                    scale = NULL,
                    col = 'black',
                    cex = 1) {
  ## Get plotting window
  usr = par('usr')
  
  if (is.null(scale)) {
    scale = (usr[2] - usr[1]) #km
    scale = 10^(round(log10(scale)-1))
  }
  
  sign = 1
  if (pos == 1) {
    x.origin = 0.95 * (usr[2] - usr[1]) + usr[1]
    y.origin = 0.05 * (usr[4] - usr[3]) + usr[3]
  } else if (pos == 2) {
    x.origin = 0.05 * (usr[2] - usr[1]) + usr[1]
    y.origin = 0.05 * (usr[4] - usr[3]) + usr[3]
    sign = -1
  } else if (pos == 3) {
    x.origin = 0.05 * (usr[2] - usr[1]) + usr[1]
    y.origin = 0.925 * (usr[4] - usr[3]) + usr[3]
    sign = -1
  } else if (pos == 4) {
    x.origin = 0.95 * (usr[2] - usr[1]) + usr[1]
    y.origin = 0.925 * (usr[4] - usr[3]) + usr[3]
  } else {
    stop ('pos should be 1, 2, 3, or 4!')
  }
  
  lines(x = c(x.origin, x.origin - sign*scale), y = rep(y.origin,2), lwd = 3*cex, col = col)
  points(x = c(x.origin, x.origin - sign*scale), y = rep(y.origin,2), pch = '|', cex = cex, col = col)
  text(x.origin - sign * scale * 0.5, y = y.origin, pos = 3, paste0(scale, ' km'), col = col, cex = cex)
  
  basemap$history[[length(basemap$history) + 1]] = list(func = 'addScale',
                                                        arguments = list(
                                                          pos = pos, scale = scale, col = col, cex = cex
                                                        )
  )
  
  invisible(basemap)
}
