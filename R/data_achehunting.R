data_achehunting <- function() {
  data("Achehunting")
  
  DT <- data.table(Achehunting)
  
  DT[, success := kg.meat > 0]
  
  DT[, id := factor(id)]
  DT[, datatype := factor(datatype)]
  
  return(DT)
}
