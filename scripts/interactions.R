# === Interactions --------------------------------------------------------
# Alec L. Robitaille



# Packages ----------------------------------------------------------------
library(ggplot2)
library(data.table)
library(palmerpenguins)
library(lme4)
library(brms)
library(rethinking)
library(tidybayes)
library(ggdist)



# Data --------------------------------------------------------------------
data("penguins")
setDT(penguins)

penguins[, index_sex := .GRP, sex]

complete_penguins <- penguins[complete.cases(penguins)]



# Plot --------------------------------------------------------------------
ggplot(penguins, aes(body_mass_g, bill_length_mm, color = sex)) +
	geom_point() +
	geom_smooth(method = 'glm') +
	theme_bw()





# Model -------------------------------------------------------------------
m_glm <- glm(bill_length_mm ~ body_mass_g * sex, data = complete_penguins)
precis(m_glm)

m_brm <- brm(bill_length_mm ~ body_mass_g * sex, data = complete_penguins)
conditional_effects(m_brm, effects = 'body_mass_g:sex')
precis(m_brm$fit)

m_rethink <- ulam(
	alist(
		bill_length_mm ~ dnorm(mu, sigma),
		mu <- alpha + beta_sex[index_sex] + beta_body * body_mass_g + beta_body_sex[index_sex] * beta_body,
		alpha ~ dnorm(0, 10),
		beta_sex[index_sex] ~ dnorm(0, 1),
		beta_body ~ dnorm(0, 1),
		beta_body_sex[index_sex] ~ dnorm(0, 1),
		sigma ~ dexp(1)
	),
	chains = 4,
	data = complete_penguins
)
plot(m_rethink, depth = 2)
precis(m_rethink, depth = 2)



m_rethink <- ulam(
	alist(
		bill_length_mm ~ dnorm(mu, sigma),
		mu <- alpha[index_sex] + beta[index_sex] * body_mass_g,
		alpha[index_sex] ~ dnorm(0, 10),
		beta[index_sex] ~ dnorm(0, 1),
		sigma ~ dexp(1)
	),
	chains = 4,
	data = complete_penguins
)

plot(m_rethink, depth = 2)
precis(m_rethink, depth = 2)




# Tidy posterior ----------------------------------------------------------
get_variables(m_brm)

# Spread posterior draws, but note easier if goal is conditional effects
#   to just use functions based on brms::fitted below
draws_spread <- spread_draws(
	m_brm,
	b_body_mass_g,
	b_sexmale
)

# Note fitted_draws deprecated for clarity
#  in favor for predicted_draws, epred_draws, linpred_draws
draws_predicted <- predicted_draws(
	m_brm,
	newdata = unique(complete_penguins[, .(sex, body_mass_g)])
)

ggplot(draws_predicted, aes(body_mass_g, .prediction, color = sex, fill = sex)) +
	stat_lineribbon(.width = .76, alpha = 0.5) +
	labs(y = 'Posterior predicted bill length mm') +
	scale_color_scico_d() +
	scale_fill_scico_d() +
	theme_bw()

# Epred
draws_epred <- epred_draws(
	m_brm,
	newdata = unique(complete_penguins[, .(sex, body_mass_g)])
)

ggplot(draws_epred, aes(body_mass_g, .epred, color = sex, fill = sex)) +
	stat_lineribbon(.width = .76, alpha = 0.5) +
	labs(y = 'Expectation of the posterior predictive bill length mm') +
	scale_color_scico_d() +
	scale_fill_scico_d() +
	theme_bw()
