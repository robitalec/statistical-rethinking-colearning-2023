data_Howell <- function() {
	if (!'rethinking' %in% .packages()) {
		stop('please load the rethinking package')
	}

	data(Howell1)
  DT <- data.table(Howell1)
  DT[, sex := .GRP, by = male]

  DT[, scale_height := scale(height)]
  DT[, scale_weight := scale(weight)]
  DT[, scale_age := scale(age)]

  return(DT)
}
