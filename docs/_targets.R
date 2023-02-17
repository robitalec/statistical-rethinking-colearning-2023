# === Targets -------------------------------------------------------------
# Alec L. Robitaille



# Source ------------------------------------------------------------------
lapply(dir('R', '*.R', full.names = TRUE), source)



# Options -----------------------------------------------------------------
# Targets
tar_option_set(format = 'qs')

# Stan
options(mc.cores = 2,
				scipen = 999,
				digits = 2)


# Targets: homework 2 -----------------------------------------------------
targets_h02 <- c(
	tar_target(
		Howell_lt_12,
		data_Howell()[age < 12]
	),
	tar_target(
		m_h02_q02,
		brm(
			weight ~ age,
			prior = c(
				prior(normal(4, 0.5), Intercept),
				prior(normal(4, 1), b),
				prior(exponential(1), sigma)
			),
			data = Howell_lt_12
		)
	),
	tar_target(
		m_h02_q03,
		brm(
			weight ~ age + sex,
			prior = c(
				prior(normal(4, 0.5), Intercept),
				prior(normal(4, 1), b),
				prior(exponential(1), sigma)
			),
			data = Howell_lt_12
		)
	)
)




# Quarto ------------------------------------------------------------------
targets_quarto <- c(
	tar_quarto(site, path = '.')
)



# Targets: all ------------------------------------------------------------
# Automatically grab all the "targets_*" lists above
lapply(grep('targets', ls(), value = TRUE), get)