# qplot.R
# -------
# Produce a quantile plot of the bandfees data.
#

require(RColorBrewer)

palette(brewer.pal(6, "Set1"))
data <- read.csv("bandfees.csv", header=TRUE, stringsAsFactors=FALSE)
data <- subset(data, upper < 10 * lower)  # filter out probable coding errors

#fee <- with(data, 0.5 * (lower + upper))
fee <- with(data, sqrt(lower * upper))
o <- order(fee)
r <- rank(fee, ties.method="first")
f <- (r + 0.5) / (length(r) + 1)
p <- f * 100
n <- length(fee)

png("bandfees-qplot.png")
par(las=1, mar=c(5, 5, 2, 2) + .1, xpd=FALSE)
plot(range(p), range(log10(fee)), t="n", axes=FALSE,
     xlab="Relative Rank (%)",
     ylab="Booking Fee ($1K)")
axis(1)
axis(3, labels=FALSE)
axis(2, at=c(0, 1, 2, 3), labels=c(1, 10, 100, 1000))
axis(4, at=c(0, 1, 2, 3), labels=FALSE)
usr <- par("usr")
abline(v=seq(usr[1], usr[2], length.out=4)[2:3], col="gray")
abline(h=seq(usr[3], usr[4], length.out=4)[2:3], col="gray")
box()

ix <- match(c("Lady Gaga", "One Direction", "BB King", "Selena Gomez",
              "Creedence Clearwater", "Ice Cube", "Smash Mouth", "Sugar Ray",
              "Ben Folds", "The Wallflowers", "Coolio", "Solange Knowles",
              "Biz Markie", "Nelly's Echo"), data$name)
ix <- ix[order(fee[ix])]
points(p[-ix], log10(fee[-ix]), col=2, cex=.5, pch=16)
points(p[ix], log10(fee[ix]), cex=.75, pch=16)

adjx <- rep(c(0, 1), length(ix))[seq_along(ix)]
adjx[fee[ix] < 10] <- 0
adjx[fee[ix] > 100] <- 1

for (i in seq_along(ix)) {
    text(p[ix[i]], log10(fee[ix[i]]),
         paste(" ", data$name[ix[i]], " "),
         adj=c(adjx[i], 0.5),
         cex=.75)
}

dev.off()
