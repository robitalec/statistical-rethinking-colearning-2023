library(faux)


within <- list(
  age = seq.int(0, 20, by = 1)
)

between <- list(
  animal = c(''),
  region =

  fruit = c('orange', 'apple', 'banana'),
  bread = c('whole wheat', 'white', 'rye')
)

n <- 100

mu <- rnorm(sum(vapply(within, length, 42)) *
              sum(vapply(between, length, 42)))

sim_design(within, between, n, mu)


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
