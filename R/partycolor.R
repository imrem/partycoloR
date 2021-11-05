#' Get colors of parties
#'
#' Returns the colors of parties
#' @param ids A single id or vector of ids from the Party Facts data set.
#' @param type The color model the colors should be in, can be hex, rgb, cmyk, or all (if all three types should be returned).
#' Default is hex.
#' @param websafe logical: should web safe colors be returned instead? Old browsers were not able to display
#' other colors than these, with current browsers this option should not be necessary, default is FALSE.
#' @param include_ids logical: should party facts ids be included in the output? If the colors get added to an existing data
#' frame that already has the ids this is usually not helpful, default is FALSE.
#' @param include_description logical: should the name of the color (e.g. "Dark blue") be included in the output? 
#' Default is FALSE.
#' @param include_source logical: should the data source of the color be included in the output? Can be wikidata,
#' wikipedia and manually added by the package creator, default is FALSE.
#' 
#' @keywords parties colors party colors 
#' @export
#' @examples
#' austrianparties <- data.frame(names=c("OEVP","SPOE","FPOE","Gruene","Neos"), partyfacts_id=c(1329,1384,463,1659,1970))
#' ## this returns a simple vector of all hex triplets
#' austrianparties$color <- partycolor(austrianparties$partyfacts_id)
#' ## this returns a data frame consisting of colors in all three color models, party facts ids, 
#' color descriptions and color source.
#' austriancolors <- partycolor(austrianparties$partyfacts_id, 
#' type='all', include_ids = TRUE, 
#' include_description = TRUE, include_source = TRUE)
#' 
partycolor <- function(ids, 
                    type = c("hex","rgb","cmyk","all"),
                    websafe=FALSE,
                    include_ids=FALSE,
                    include_description=FALSE,
                    include_source=FALSE) {
  if(missing(type)) {
    type <- "hex"
  }
  # check if correct argument was used for type- option
  type <- match.arg(type,several.ok=T)
  
  if(type=="all") {
    type <- c("hex","rgb","cmyk")
  }
  if(include_ids==TRUE) {
    type <- c("partyfacts_id",type)
  }
  if(include_description==TRUE) {
    type <- c(type,"description")
  }
  if(websafe==TRUE) {
    type <- paste0("ws",type)
  }
  if(include_source==TRUE) {
    type <- c(type,"source")
  }
  partyfacts_id <- data.frame(ids)
  names(partyfacts_id)[1] <- "partyfacts_id"
  merged <- merge(partyfacts_id,partycolorsdataset,all.x=T)
  requestedvars <- merged[,type]
  
  return(requestedvars)
}
