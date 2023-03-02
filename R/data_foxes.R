data_foxes <- function(scale = FALSE) {
	if (!'rethinking' %in% .packages()) {
		stop('please load the rethinking package')
	}

	data(foxes)
  DT <- data.table(foxes)

  if (scale) {
    message('Scaling numeric variables: avgfood, groupsize, area, weight')
    DT[, scale_avgfood := scale(avgfood)]
    DT[, scale_groupsize := scale(groupsize)]
    DT[, scale_area := scale(area)]
    DT[, scale_weight := scale(weight)]
  }

  return(DT)
}
