data_achehunting <- function() {
  data("Achehunting")
  
  DT <- data.table(Achehunting)
  
  DT[, success := kg.meat > 0]

  DT[, log10_age := log10(age)]
  
  DT[, id := factor(id)]
  DT[, datatype := factor(datatype)]
  
  return(DT)
}
