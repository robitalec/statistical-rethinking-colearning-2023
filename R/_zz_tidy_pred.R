tidy_pred <- function(model, newdata, key) {
	newdata[, row_id := paste0('V', .I)]

	pred <- link(model, newdata)
	melt_pred <- melt(as.data.table(pred))
	DT <- melt_pred[newdata, on = .(variable == row_id)]

	DT[, sex := factor(sex, levels = key$sex, labels = key$sex_char)]
	return(DT)
}
