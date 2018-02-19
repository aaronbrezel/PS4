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

setClass(Class="door", representation = representation(chosenDoor = "integer", carDoor = "integer", switch = "logical", winner = "logical"), prototype = prototype(chosenDoor = c(), carDoor = c(), switch = c(), winner = NA)) #Standard S4 set class method

#this will already throw an error when creating a new object. Why do we need  to set a validity to show that the slots are appropriately structured  

#Is there a way to prevent the user from setting the value in "winner"?
#What about setting the standard value of carDoor and chosenDoor to null first? Because right now my Monty Method simply replaces the value

setValidity("door", function(object){ #Validity function
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


setMethod("initialize", "door", function(.Object, ...){ #Initialize function
  value = callNextMethod()
  validObject(value)
  return(value)
})


setGeneric("PlayGame", function(object){standardGeneric("PlayGame")}) #Setting generic function for later door-specific method


setMethod("PlayGame", "door", function(object){ #door-specific method for Playgame function
  doorList <- c(1,2,3) 
  revealedDoor <- c(1,2,3)
  object@chosenDoor<- sample(1:3, 1)
  object@carDoor <- sample(1:3,1)
  
  revealedDoor <- revealedDoor[-c(object@chosenDoor, object@carDoor)] #"revealed door" if the contestant picks a door with a goat behind it, this line "reveals" the other door with the goat behind it. If the contestant picks the door with the car behind it, the "if" statement below chooses randomly to "reveal" one of the two doors with a goat behind it. 
  if(length(revealedDoor) == 2){ 
    revealedDoor <- sample(revealedDoor,1)
  }
  print(paste("Chosen Door:", object@chosenDoor, "Car Door:", object@carDoor, "Revealed door:", revealedDoor, sep = " "))
  
  if(identical(object@switch, TRUE)){ #If the contestant will switch
    print("Door Switched!")
    object@chosenDoor <- as.integer(doorList[-c(object@chosenDoor,revealedDoor)]) #select the one door left that has not been chosen or revealed
    print(paste("Chosen Door:", object@chosenDoor, "Car Door:", object@carDoor, "Revealed door:", revealedDoor, sep = " "))
    if(identical(object@chosenDoor, object@carDoor)){ #checks to see if the newly selected door is the same as the car door
      print("You won! Enjoy your brand new car!")
      object@winner <- TRUE
      return(object)
    } 
    else{
      print("You lost! Enjoy your goat!")  
      object@winner <- FALSE
      return(object)
    }
  }
  else{
    if(identical(object@chosenDoor, object@carDoor)){
      print("You won! Enjoy your brand new car!")
      object@winner <- TRUE
      return(object)
    } 
    else{
      print("Door did not Switch!")
      print("You lost! Enjoy your goat!")  
      object@winner <- FALSE
      return(object)
    }
  }
})

game <- new("door", chosenDoor = as.integer(sample(1:3,1)), carDoor = as.integer(sample(1:3,1)), switch = FALSE)
#is this acceptable? Also, I tried having Playgame simply return "4" and it did set game to "4" how can i prevent the method from doing that?
game <- PlayGame(game)

#Simulations

#If the user switches
game <- new("door", chosenDoor = as.integer(sample(1:3,1)), carDoor = as.integer(sample(1:3,1)), switch = TRUE)
gameList <- replicate(1000, PlayGame(game)) #reruns the PlayGame function 1000 times. Produces a list
results <- sapply(gameList, function(x){ #creates a vector of true and false values to indicate winners and losers 
  if (x@winner == TRUE){
    counter <- counter + 1
    return(TRUE)
  }
  return(FALSE)
})
(length(results[results==TRUE])/1000)*100
#64.7% success rate

#If the contestant does not switch
game <- new("door", chosenDoor = as.integer(sample(1:3,1)), carDoor = as.integer(sample(1:3,1)), switch = FALSE)
gameList <- replicate(1000, PlayGame(game)) #reruns the PlayGame function 1000 times. Produces a list
results <- sapply(gameList, function(x){ #creates a vector of true and false values to indicate winners and losers 
  if (x@winner == TRUE){
    counter <- counter + 1
    return(TRUE)
  }
  return(FALSE)
})
(length(results[results==TRUE])/1000)*100 #Calculates the number of winners via the number of true values 
#34.5% of the time, contestants won while switching

#Switching doors is nearly twice as successful as sticking with the same door

game@chosenDoor <- as.integer(10)
game
