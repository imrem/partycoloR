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
gerparties <- data.frame(name=c("AfD","CDU","CSU","FDP","Gruene","Linke","SPD"), 
                        partyfacts_id=c(1976,1375,1731,573,1816,1545,383),
                        lrecon=c(7,5.90,6.38,7.90,3.81,1.29,3.71),
                        galtan=c(9.52,5.86,7.29,3.43,1.10,2.81,3.38))
gerparties$hex <- partycolor(gerparties$partyfacts_id)
```
The code chunk above just adds the hex codes to all parties in the data frame. To add multiple color variables to a data set it's easiest to create a seperate object and merge it to the existing data frame using the Party Facts ID
``` R
colors <- partycolor(gerparties$partyfacts_id, type='all', include_ids = TRUE, include_description = TRUE, include_source = TRUE)
gerparties <- merge(gerparties,colors, all.x=T)
```

### Create a graph using the party colors
Now that the colors are added, one could easily create a graph using the colors that were just added to the data, for example:
``` R
library(ggplot2)
ggplot(gerparties,aes(x=lrecon,y=galtan, label=name)) + 
  theme_classic() + labs(title="", x="LRECON", y="GALTAN") +
  scale_x_continuous(breaks=seq(0,10,1)) +
  scale_y_continuous(breaks=seq(0,10,1)) +
  geom_point(size = 3, color=gerparties$hex)
```

### Access all party color data
If you just want the data set, you can do so by assigning the object 'partycolorsdataset' to any object:
``` R
partycolors <- partycolorsdataset
```

Accessibility
--------------
As it heavily depends on the use case which colors will be displayed in a graph together I, unfortunately, have no way of making this colorblind-friendly. To make more accessible graphics, you might want to consider checking out a package like [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/index.html) or [Viridis](https://cran.r-project.org/web/packages/viridis/index.html), which provide options to make graphs better visible to color blind people, instead of using the real party colors.

