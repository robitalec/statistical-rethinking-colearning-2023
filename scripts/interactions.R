# === Interactions --------------------------------------------------------
# Alec L. Robitaille



# Packages ----------------------------------------------------------------
library(ggplot2)
library(data.table)
library(palmerpenguins)
library(lme4)
library(brms)
library(rethinking)


# Data --------------------------------------------------------------------
data("penguins")
setDT(penguins)




# Plot --------------------------------------------------------------------
ggplot(penguins, aes(body_mass_g, bill_length_mm, color = sex)) +
	geom_point() +
	geom_smooth(method = 'glm') +
	theme_bw()





# Model -------------------------------------------------------------------
complete_penguins <- penguins[complete.cases(penguins)]

m_glm <- glm(bill_length_mm ~ body_mass_g * sex, data = complete_penguins)

m_brm <- brm(bill_length_mm ~ body_mass_g * sex, data = complete_penguins)

m_rethink <- ulam(
	alist(
		bill_length_mm ~ dnorm(mu, sigma),
		mu <- alpha + beta[sex] * body_mass_g,
		alpha ~ dnorm(0, 10),
		beta[sex] ~ dnorm(0, 1),
		sigma ~ dexp(1)
	),
	data = complete_penguins
)

