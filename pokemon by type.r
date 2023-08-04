library(tidyverse)

# default theme settings
theme_set(theme_classic() +
            theme(
              plot.title = element_text(size = 12),
              plot.subtitle = element_text(size = 8, face = "italic"),
              plot.caption = element_text(size = 8, face = "italic"),
              plot.title.position = "plot",
              legend.text = element_text(size = 8)
            ))

# load pokemon data
pokemon <- read_csv("pokemon.csv")

# clean data
pokemon <- pokemon |>
  rename(classification = classfication) |>
  mutate(capture_rate = as.numeric(capture_rate))

# count pokemon by class
pokemon_by_class <- pokemon |>
  group_by(type1) |>
  tally() |>
  arrange(n)

# plot colours
pokemon_text <- "#2a75bb"
pokemon_fill <- "#ffcb05"


# formatted bar plot example
ggplot(pokemon_by_class, aes(x = n, y = reorder(type1, n), width = 0.8)) +
  geom_bar(stat = "identity", fill = pokemon_fill, colour = pokemon_text) + 
  labs(
    title = "Pokemon by type",
    subtitle = "Count of 801 pokemon by type 1"
  ) +
  theme(axis.title = element_blank()) +
  geom_text(aes(label = n), colour = pokemon_text, hjust = -0.2) +
  theme(
    axis.line.x = element_blank(), 
    axis.ticks.x = element_blank(), 
    axis.text.x = element_blank(),
    axis.line.y = element_blank(), 
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(hjust = 1, face = "bold", colour = pokemon_text),
    plot.title = element_text(face = "bold", colour = pokemon_text),
    plot.subtitle = element_text(colour = pokemon_text)
  )
