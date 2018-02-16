#1

#bugged code

myFunction <- function (doorthing1, doorthing2, x) { #x does not need to be a argument in this function. Also, doorthing should be doorthing1
  doorthing1 <- doorthing2 <- sample(1:3,1) #we are setting doorthing1 and doorthing2 to the same value in the function. Function will always be true
  if (doorthing1==doorthing2) { x<-TRUE } else { x == FALSE } #this is formatted awkwardly. Also, if the function enters the else statement x will not be established as a object. Change x == FALSE to x <- FALSE.
  x
}

myFunction(sample(1:3, 1), sample(1:3,1))

#debugged code

myFunction <- function (doorthing1, doorthing2) { 
  if (doorthing1==doorthing2) { 
    x <-TRUE 
  } 
  else { 
    x <- FALSE 
  }
  return(x)
}

myFunction(sample(1:3, 1), sample(1:3,1))
