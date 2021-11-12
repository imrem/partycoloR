partycoloR
================




About the package
-----------------
This package provides easy access to the official party colors of thousands of parties around the world in hex triplet, RGB or CMYK format. 
IDs from the [Party Facts](https://partyfacts.herokuapp.com) project  are used to identify the parties. Color data were collected on Wikidata and Wikipedia. If available, Wikidata (providing the precise hex triplets of the colors (e.g. #FF0000)) was used, if no data regarding color were available there, Wikipedia (providing color names (e.g. red)) was used as a data source. [Colorhexa](https://www.colorhexa.com) was used to add hex triplets (for colors from wikipedia), color names (for colors from wikidata) as well as RGB and CMYK codes as well as data on websafe versions of all colors. 


How to install
--------------

``` eval
library(devtools)
install_github("imrem/partycoloR")
library(partycoloR)
```


How to use
--------------

This package is only useful if you are working with IDs from the party facts project, which can be used to merge many different data sets

### Looking up color data of a single party
``` R
partycolor(432)
```
In this case, the output is a single number, the hex code for the party color of the US Democratic Party.

``` R
partycolor(809, type="all",include_ids=T,include_description = T)
```
This results in a more detailed output: color codes in three different formats, as well as the partyfacts ID color name of the party color of the US Republican Party.


### Looking up color data of multiple parties
Probably the most useful usecase of this package is quickly merging the colors of multiple parties to a data frame (e.g. for displaying parties using their official colors in graphs).

``` R
austrianparties <- data.frame(names=c("OEVP","SPOE","FPOE","Gruene","Neos"), partyfacts_id=c(1329,1384,463,1659,1970))
austrianparties$color <- partycolor(austrianparties$partyfacts_id)
```
The code chunk above just adds the hex codes to all parties in the data frame. To add multiple color variables to a data set it's easiest to create a seperate object and merge it to the existing data frame using the Party Facts ID
``` R
colors <- partycolor(austrianparties$partyfacts_id, type='all', include_ids = TRUE, include_description = TRUE, include_source = TRUE)
austrianparties <- merge(austrianparties,colors, all.x=T)
```
