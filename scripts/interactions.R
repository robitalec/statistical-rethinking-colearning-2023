# === Interactions --------------------------------------------------------
# Alec L. Robitaille



# Packages ----------------------------------------------------------------
library(ggplot2)
library(data.table)
library(palmerpenguins)
library(lme4)


# Data --------------------------------------------------------------------
data("penguins")
setDT(penguins)




# Plot --------------------------------------------------------------------
ggplot(penguins, aes(body_mass_g, bill_length_mm, color = sex)) +
	geom_point() +
	geom_smooth(method = 'glm') +
	theme_bw()




# Model -------------------------------------------------------------------
m <- glm(bill_length_mm ~ body_mass_g * sex, data = penguins)

