#install.packages("gplots", dependencies = TRUE)
library(gplots)

#install.packages("RColorBrewer", dependencies = TRUE)
library(RColorBrewer)

setwd("C:/Users/yluo/Desktop") #Choose Directory
x <- read.csv("Kim1cor3.csv") #Enter file name of data table

#read in the data:
row.names(x) <- x[,1]
x <- x[,-1]

#transpose the data, depending on if you want to look at correlation of row data or column data:
#y <- t(x)


#find correlation
xy <- cor(x, method="pearson", use="pairwise.complete.obs")

#write a table of the correlation values:
hM <- format(round(xy, 2))
write.csv(hM, "CCTK_PERC_cor.csv", quote=FALSE)

#assign colors for the heatmap:
colours =  colorRampPalette(rev(brewer.pal (9, "RdBu")))(255)
heatmap.2(xy, Rowv=TRUE, symm=TRUE, distfun=function(c) as.dist(1 - c), trace="none", margins=c(8,8), key=TRUE, keysize=2, key.par=list(mar=c(3.5,0,3,0)), col = colours)

#alternately, use a more simple color scheme:
heatmap.2(xy, Rowv=TRUE, symm=TRUE, distfun=function(c) as.dist(1 - c), trace="none", col = redgreen(250))

#make a file of the heatmap:
jpeg("Biological_Data.jpg",    # create PNG for the heat map        
     width = 5*600,        # 5 x 300 pixels
     height = 5*600,
     res = 600,            # 300 pixels per inch
     pointsize = 8)        # smaller font size
heatmap.2(xy, Rowv=TRUE, symm=TRUE, distfun=function(c) as.dist(1 - c), trace="none", col = colours, main="Correlation: chemicals")
dev.off()

