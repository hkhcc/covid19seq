library(gdsfmt)
library(SNPRelate)
library(RColorBrewer)

#biallelic by default
snpgdsVCF2GDS("final.vcf", "dataset1.gds", method="copy.num.of.ref")
snpgdsSummary("dataset1.gds")
genofile = snpgdsOpen("dataset1.gds")

#LD based SNP pruning
set.seed(1000)
snpset = snpgdsLDpruning(genofile,autosome.only=FALSE, ld.threshold = 0.5)
snp.id=unlist(snpset)

# distance matrix - use IBS
dissMatrix  =  snpgdsIBS(genofile , sample.id=NULL, snp.id=snp.id, autosome.only=FALSE,
    remove.monosnp=FALSE,  maf=NaN, missing.rate=NaN, num.thread=2, verbose=TRUE)

snpHCluster =  snpgdsHCluster(dissMatrix, sample.id=NULL, need.mat=TRUE, hang=0.01)

cutTree = snpgdsCutTree(snpHCluster, z.threshold=15, outlier.n=5, n.perm = 5000, samp.group=NULL,
    col.outlier="red", col.list=NULL, pch.outlier=4, pch.list=NULL,label.H=FALSE, label.Z=TRUE,
    verbose=TRUE)

pdf("tree.pdf")
snpgdsDrawTree(cutTree, main = "Dataset 1",edgePar=list(col=rgb(0.5,0.5,0.5,0.75),t.col="black"),
    y.label.kinship=T,leaflab="perpendicular")
dev.off()

#pca
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
pop_code <- read.gdsn(index.gdsn(genofile, "sample.id"))

pca <- snpgdsPCA(genofile, autosome.only=FALSE,)
snpgdsClose(genofile)

tab <- data.frame(sample.id = pca$sample.id,pop = factor(pop_code)[match(pca$sample.id, sample.id)],EV1 = pca$eigenvect[,1],EV2 = pca$eigenvect[,2],stringsAsFactors = FALSE)
pc.percent <- round(pca$varprop*100, 2)

# edit the population column (specific to current analysis)
sample_list <- data.frame("sample"=c("SRR11300652", "SRR11397727", "SRR11393278", "SRR11393277", "SRR11347377", 
                      "SRR11313287", "SRR11313494", 
                      "SRR10902284", "SRR10948474", 
                      "SRR11178057", "SRR11178056", 
                      "SRR11178055", "SRR11178054",
                      "SRR11178053", "SRR11178052",
                      "SRR11178051", "SRR11178050"
                      ), 
           "group"=c("AUS","AUS","USA","USA","USA", 
                     "WUHAN", "WUHAN",
                     "SZ", "SZ", 
                     "HK", "HK",
                     "HK", "HK",
                     "HK", "HK",
                     "HK", "HK"
                     ))

pop_vector <- vector()

for (i in 1:nrow(tab)) {
  lookup_key <- as.character(tab$pop[i])
  lookup_value <- sample_list[sample_list$sample==lookup_key,]$group
  lookup_value <- as.character(lookup_value)
  pop_vector <- c(pop_vector, lookup_value)
}

tab$pop <- pop_vector


#plot(tab$EV2, tab$EV1, col=as.integer(factor(tab$pop)),xlab=paste("Eigenvector 2 (", as.character(pc.percent[2]), "%)", sep=""), ylab=paste("Eigenvector 1 (", as.character(pc.percent[1]), "%)", sep=""))
#legend("bottomleft", legend=factor(tab$sample.id), pch="o", col=1:nlevels(factor(tab$pop)))
library(ggplot2)
library(ggrepel)
info_xlab <- paste("Eigenvector 2 (", as.character(pc.percent[2]), "%)", sep="")
info_ylab <- paste("Eigenvector 1 (", as.character(pc.percent[1]), "%)", sep="")

p <- ggplot(tab, aes(EV2, EV1, label=sample.id))
(p + geom_point() + geom_text_repel(aes(colour=factor(pop))) 
  + xlab(info_xlab) + ylab(info_ylab) 
  + scale_colour_discrete(name="Sample origin\n(country or city)")
)
ggsave("pca.pdf")


