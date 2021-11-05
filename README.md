partycoloR
================




About the package
-----------------
This package provides easy access to the official party colors of thousands of parties around the world in hex triplet, RGB or CMYK format. 
IDs from the [Party Facts](https://partyfacts.herokuapp.com) project  are used to identify the parties, data was collected on Wikidata, Wikipedia, and supplemented by own research.
[Colorhexa](https://www.colorhexa.com) was used to add color codes (e.g. ff0000) if only color names (e.g. red) were available and vice versa.


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

### Access all party color data
If you just want the data set, you can do so by assigning the object 'partycolorsdataset' to any object:
``` R
partycolors <- partycolorsdataset
```

Accessibility
--------------
As it heavily depends on the use case which colors will be displayed in a graph together I, unfortunately, have no way of making this colorblind-friendly. To make more accessible graphics, you might want to consider checking out a package like [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/index.html) or [Viridis](https://cran.r-project.org/web/packages/viridis/index.html), which provide options to make graphs better visible to color blind people, instead of using the real party colors.

