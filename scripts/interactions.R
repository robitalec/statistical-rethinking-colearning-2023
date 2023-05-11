n <- 100
x <- runif(n, 1, 2)
z <- runif(n, -2, -1)
y <- (x * 0.9) + (z * -0.9)

plot(x)
plot(z)
plot(y)

plot(y ~ x * z)

corrplot::corrplot(cor(data.frame(x, y, z)), diag = FALSE)




library(ggplot2)
data("penguins")
setDT(penguins)

ggplot(penguins, aes(body_mass_g, bill_length_mm, color = sex)) +
	geom_point() +
	geom_smooth(method = 'glm') +
	theme_bw()


library(lme4)

m <- glm(bill_length_mm ~ body_mass_g * sex, data = penguins)

