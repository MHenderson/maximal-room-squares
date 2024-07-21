library(targets)

tar_option_set(
  packages = c("dplyr", "ggplot2", "glue", "here", "patchwork", "tibble", "wallis")
)

tar_source()

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
