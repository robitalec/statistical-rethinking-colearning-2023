#' Simulate globe tossing data
#'
#' @param p proportion of tosses that are water ('W')
#' @param N number of simulated tosses
#'
#' @return
#' @export
#'
#' @examples
sim_globe <- function(p = 0.7, N = 9) {
	sample(
		c('W', 'L'),
		size  = N,
		prob = c(p, 1 - p),
		replace = TRUE
	)
}
