#' Compute globe tossing posterior
#'
#' @param x sampled vector
#' @param possibilities vector of possibilities to test
#'
#' @return
#' @export
#'
#' @examples
compute_posterior_globe <- function(x, possibilities = c(0, 0.25, 0.5, 0.75, 1)) {
	DT <- data.table(
		W = sum(x == 'W'),
		L = sum(x == 'L'),
		possibility = possibilities
	)

	f <- function(W, L, possibility) {
		((possibility * 4) ^ W)  * ((1 - possibility) * 4 ^ L)
	}

	DT[, ways := f(W, L, possibility)]
	DT[, post := ways / sum(ways)]

	return(DT)
}
