data_Howell <- function() {
	if (!'rethinking' %in% .packages()) {
		stop('please load the rethinking package')
	}

	data(Howell1)
  DT <- data.table(Howell1)
  DT[, sex := .GRP, by = male]

  return(DT[, .(height, weight, age, sex)])
}
