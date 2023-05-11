n <- 100
x <- runif(n, 1, 2)
z <- runif(n, -2, -1)
y <- (x * 0.9) + (z * -0.9)

plot(x)
plot(z)
plot(y)

plot(y ~ x * z)

corrplot::corrplot(cor(data.frame(x, y, z)), diag = FALSE)






add_random(subj = 4, item = 2) %>%
  add_between("subj", version = 1:2) %>%
  # add by-subject random intercept
  add_ranef("subj", u0s = 1.3) %>%
  # add by-item random intercept and slope
  add_ranef("item", u0i = 1.5, u1i = 1.5, .cors = 0.3) %>%
  # add by-subject:item random intercept
  add_ranef(c("subj", "item"), u0si = 1.7) %>%
  # add error term (by observation)
  add_ranef(sigma = 2.2)
