#' Compute globe tossing posterior
#'
#' @param x sampled vector
#' @param n_possibilities number of possibilities to test
#'
#' @return
#' @export
#'
#' @examples
compute_posterior_globe <- function(x, n_possibilities = 5) {
	DT <- data.table(
		W = sum(x == 'W'),
		L = sum(x == 'L'),
		possibility = seq(0, 1, length.out = n_possibilities)
	)

	f <- function(W, L, possibility) {
		(possibility * 4) ^ W  * ((1 - possibility) * 4) ^ L
	}

	DT[, ways := f(W, L, possibility)]
	DT[, post := ways / sum(ways)]

	return(DT)
}
