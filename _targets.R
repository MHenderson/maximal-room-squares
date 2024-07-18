# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("dplyr", "ggplot2", "glue", "here", "patchwork", "tibble", "wallis") # Packages that your targets need for their tasks.
  # format = "qs", # Optionally set the default storage format. qs is fast.
  #
  # Pipelines that take a long time to run may benefit from
  # optional distributed computing. To use this capability
  # in tar_make(), supply a {crew} controller
  # as discussed at https://books.ropensci.org/targets/crew.html.
  # Choose a controller that suits your needs. For example, the following
  # sets a controller that scales up to a maximum of two workers
  # which run as local R processes. Each worker launches when there is work
  # to do and exits if 60 seconds pass with no tasks to run.
  #
  #   controller = crew::crew_controller_local(workers = 2, seconds_idle = 60)
  #
  # Alternatively, if you want workers to run on a high-performance computing
  # cluster, select a controller from the {crew.cluster} package.
  # For the cloud, see plugin packages like {crew.aws.batch}.
  # The following example is a controller for Sun Grid Engine (SGE).
  # 
  #   controller = crew.cluster::crew_controller_sge(
  #     # Number of workers that the pipeline can scale up to:
  #     workers = 10,
  #     # It is recommended to set an idle time so workers can shut themselves
  #     # down if they are not running tasks.
  #     seconds_idle = 120,
  #     # Many clusters install R as an environment module, and you can load it
  #     # with the script_lines argument. To select a specific verison of R,
  #     # you may need to include a version string, e.g. "module load R/4.3.2".
  #     # Check with your system administrator if you are unsure.
  #     script_lines = "module load R"
  #   )
  #
  # Set other options as needed.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
  tar_target(
    name = R6_g1,
    command = greedy1(6) |> mutate(fill = visit)
  ),
  tar_target(
    name = R8_g1,
    command = greedy1(8) |> mutate(fill = visit)
  ),
  tar_target(
    name = R12_g1,
    command = greedy1(12) |> mutate(fill = visit)
  ),
  tar_target(
    name = R8_g2,
    command = greedy2(8) |> mutate(fill = visit)
  ),
  tar_target(
    name = R10_g2,
    command = greedy2(10) |> mutate(fill = visit)
  ),
  tar_target(
    name = R12_g2,
    command = greedy2(12) |> mutate(fill = visit)
  ),
  tar_target(
    name = plot_R6_g1,
    command = plot_with_labs(R6_g1)
  ),
  tar_target(
    name = plot_R6_g1_R8_g1,
    command = plot_with_labs(R6_g1) + plot_with_labs(R8_g1)
  ),
  tar_target(
    name = plot_R12_g1,
    command = plot_with_labs(R12_g1)
  ),
  tar_target(
    name = plot_R8_g2_R10_g2,
    command = plot_with_labs(R8_g2) + plot_with_labs(R10_g2)
  ),
  tar_target(
    name = plot_R12_g2,
    command = plot_with_labs(R12_g2)
  ),
  tar_target(
    name = save_plot_R6_g1,
    command = ggsave(plot = plot_R6_g1, filename = here("plots", "greedy1-example-plot.png"), width = 3, height = 3, bg = "white")
  ),
  tar_target(
    name = save_plot_R6_g1_R8_g1,
    command = ggsave(plot = plot_R6_g1_R8_g1, filename = here("plots", "greedy1-examples1-plot.png"), width = 8, height = 3, bg = "white")
  ),
  tar_target(
    name = save_plot_R12_g1,
    command = ggsave(plot = plot_R12_g1, filename = here("plots", "greedy1-examples2-plot.png"), width = 5, height = 5, bg = "white")
  ),
  tar_target(
    name = save_plot_R8_g2_R10_g2,
    command = ggsave(plot = plot_R8_g2_R10_g2, filename = here("plots", "greedy2-examples1-plot.png"), width = 9, height = 4, bg = "white")
  ),
  tar_target(
    name = save_plot_R12_g2,
    command = ggsave(plot = plot_R12_g2, filename = here("plots", "greedy2-examples2-plot.png"), width = 5, height = 5, bg = "white")
  )
)
