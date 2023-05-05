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


# Targets: homework 3 -----------------------------------------------------
targets_h03 <- c(
	tar_target(
		foxes,
		data_foxes(scale = TRUE)
	),
	tar_target(
		m_h03_q01_prior,
		brm(
			scale_avgfood ~ scale_area,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h03_q01,
		brm(
			scale_avgfood ~ scale_area,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes
		)
	),
	tar_target(
		m_h03_q02_prior,
		brm(
			scale_weight ~ scale_avgfood,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h03_q02,
		brm(
			scale_weight ~ scale_avgfood,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes
		)
	),
	tar_target(
		m_h03_q03_prior,
		brm(
			scale_weight ~ scale_avgfood + scale_groupsize,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h03_q03,
		brm(
			scale_weight ~ scale_avgfood + scale_groupsize,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes
		)
	),
	tar_target(
		m_h03_q03_groupsize_food,
		brm(
			scale_groupsize ~ scale_avgfood,
			prior = c(
				prior(normal(0, 0.25), Intercept),
				prior(normal(0, 0.5), b),
				prior(exponential(1), sigma)
			),
			data = foxes
		)
	)
)

# Targets: homework 5 -----------------------------------------------------
targets_h05 <- c(
	tar_target(
		DT_grants,
		data_grants()
	),
	tar_target(
		m_h05_q01_prior,
		brm(
			awards | trials(applications) ~ gender,
			family = 'binomial',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1), class = Intercept)
			),
			data = DT_grants,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h05_q01,
		brm(
			awards | trials(applications) ~ gender,
			family = 'binomial',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1), class = Intercept)
			),
			data = DT_grants
		)
	),
	tar_target(
		m_h05_q02,
		brm(
			awards | trials(applications) ~ gender * discipline,
			family = 'binomial',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1), class = Intercept)
			),
			data = DT_grants
		)
	)
)


# Targets: homework 6 -----------------------------------------------------
targets_h06 <- c(
	tar_target(
		DT_frogs,
		data_reedfrogs()
	),
	tar_target(
		m_h06_q01_prior_exp_1,
		brm(
			surv | trials(density) ~ (1 | tank),
			family = 'binomial',
			prior = c(
				prior(normal(0, 1), class = Intercept),
				prior(exponential(1), class = sd)
			),
			data = DT_frogs,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h06_q01_prior_exp_0pt1,
		brm(
			surv | trials(density) ~ (1 | tank),
			family = 'binomial',
			prior = c(
				prior(normal(0, 1), class = Intercept),
				prior(exponential(0.1), class = sd)
			),
			data = DT_frogs,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h06_q01_prior_exp_10,
		brm(
			surv | trials(density) ~ (1 | tank),
			family = 'binomial',
			prior = c(
				prior(normal(0, 1), class = Intercept),
				prior(exponential(10), class = sd)
			),
			data = DT_frogs,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h06_q02,
		brm(
			surv | trials(density) ~ pred * size + (1 | tank),
			family = 'binomial',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1), class = Intercept),
				prior(exponential(1), class = sd)
			),
			data = DT_frogs
		)
	),
	tar_target(
		m_h06_q03,
		brm(
			surv | trials(density) ~ pred * density + (1 | tank),
			family = 'binomial',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1), class = Intercept),
				prior(exponential(1), class = sd)
			),
			data = DT_frogs
		)
	)
)

# Targets: homework 9 -----------------------------------------------------
targets_h09 <- c(
	tar_target(
		DT_hunting,
		data_achehunting()
	),
	tar_target(
		m_h09_q01_prior,
		brm(
			success ~ s(age),
			family = 'bernoulli',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1.5), class = Intercept),
				prior(exponential(1), class = sds)
			),
			data = DT_hunting,
			sample_prior = 'only',
			chains = 1
		)
	),
	tar_target(
		m_h09_q01,
		brm(
			success ~ s(age),
			family = 'bernoulli',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1.5), class = Intercept),
				prior(exponential(1), class = sds)
			),
			data = DT_hunting
		)
	),
	tar_target(
		m_h09_q02,
		brm(
			success ~ t2(age, by = id),
			family = 'bernoulli',
			prior = c(
				prior(normal(0, 0.5), class = b),
				prior(normal(0, 1.5), class = Intercept),
				prior(exponential(1), class = sds)
			),
			data = DT_hunting
		)
	),
	tar_target(
		m_h09_q03_complete_cases,
		brm(
			success ~ age + hours + (1 | id),
			family = 'bernoulli',
			prior = c(
				prior(normal(0, 0.1), class = b),
				prior(normal(0, 0.5), class = Intercept),
				prior(exponential(1), class = sd)
			),
			data = na.omit(DT_hunting)
		)
	),
	tar_target(
		DT_hunting_mice,
		mice(DT_hunting)
	),
	tar_target(
		m_h09_q03_mice,
		brm_multiple(
			success ~ age + hours + (1 | id),
			family = 'bernoulli',
			prior = c(
				prior(normal(0, 0.1), class = b),
				prior(normal(0, 0.5), class = Intercept),
				prior(exponential(1), class = sd)
			),
			data = DT_hunting_mice
		)
	)

)

# Quarto ------------------------------------------------------------------
targets_quarto <- c(
	tar_quarto(site, path = '.')#, cue = tar_cue('never'))
)



# Targets: all ------------------------------------------------------------
# Automatically grab all the "targets_*" lists above
lapply(grep('targets', ls(), value = TRUE), get)
