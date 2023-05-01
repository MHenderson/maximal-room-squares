# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed. # nolint

# Set target options:
tar_option_set(
  packages = c("ggplot2", "glue", "tibble"), # packages that your targets need to run
  format = "rds" # default storage format
  # Set other options as needed.
)

# tar_make_clustermq() configuration (okay to leave alone):
options(clustermq.scheduler = "multicore")

# tar_make_future() configuration (okay to leave alone):
# Install packages {{future}}, {{future.callr}}, and {{future.batchtools}} to allow use_targets() to configure tar_make_future() options.

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# source("other_functions.R") # Source other scripts as needed. # nolint

# Replace the target list below with your own:
list(
  tar_target(
    name = greedy1_example,
    command = greedy1(10)
  ),
  tar_target(
    name = greedy2_example,
    command = greedy2(10)
  ),
  tar_target(
    name = greedy1_example_plot,
    command = plot_room_square(greedy1_example)
  ),
  tar_target(
    name = greedy2_example_plot,
    command = plot_room_square(greedy2_example)
  ),
  tar_target(orders, seq(1, 95, 1)),
  tar_target(
    results,
    tibble(
            n = as.integer(orders),
      greedy1 = list(greedy1(orders)),
      greedy2 = list(greedy2(orders))
    ) %>%
      pivot_longer(-n) %>%
      mutate(
        n_filled_cells = map_dbl(value, n_filled_cells),
                volume = map_dbl(value, volume),
      ),
    pattern = map(orders)
  ),
  tar_render(
    name = readme,
    "README.Rmd"
  )
)
