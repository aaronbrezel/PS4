#Getting Started

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


#1.

setClass(Class="door", representation = representation(chosenDoor = "integer", carDoor = "integer", switch = "logical", winner = "logical"), prototype = prototype(chosenDoor = c(), carDoor = c(), switch = c(), winner = NA))

#this will already throw an error when creating a new object. Why do we need  to set a validity to show that the slots are appropriately structured  

#Is there a way to prevent the user from setting the value in "winner"

setValidity("door", function(object){
  # if(!is.integer(object@chosenDoor)){
  #   return("Chosen Door must be type 'integer'")
  # }
  # else if(!is.integer(object@carDoor)){
  #   return("ChosenDoor must be type 'integer'")
  # }
  # else if(!is.logical(object@switch)){
  #   return("switch must be type 'logical'")
  # }
  # else if(!is.logical(object@winner)){
  #   return("switch must be type 'logical'")
  # }
  if(object@chosenDoor < 1 | object@chosenDoor > 3){
    return("Chosen door must be between 1 and 3")
  }
  else if(object@carDoor < 1 | object@carDoor > 3){
    return("Chosen door must be between 1 and 3")
  }
  else if(identical(object@switch,NA)){
    return("You must pick true or false for 'switch'")
  }
})


setMethod("initialize", "door", function(.Object, ...){
  value = callNextMethod()
  validObject(value)
  return(value)
})

game <- new("door", chosenDoor = as.integer(1), carDoor = as.integer(sample(1:3,1)), switch = TRUE)

setGeneric("PlayGame", function(object){standardGeneric("PlayGame")})

setMethod("PlayGame", "door", function(object){
  unselectedDoor <- c(1,2,3)
  chosenDoor<- sample(1:3, 1)
  object@carDoor <- sample(1:3,1)
  unselectedDoor <- unselectedDoor[-c(object@chosenDoor, object@carDoor)]
  if(identical(object@switch, TRUE)){
    object@
  }
  
})




