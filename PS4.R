myFunction <- function (doorthing, doorthing2, x) {
  doorthing1 <- doorthing2 <- sample(1:3,1)
  if (doorthing1==doorthing2) { x<-TRUE } else { x == FALSE }
  x
}

myFunction(sample(1:3, 1), sample(1:3,1))
