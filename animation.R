library(magick)
library(tictoc)

tic()
sizes <- seq(0, 33, 1)

imgs <- image_read(paste0("frames/frame", sizes, ".png"))

animation <- image_animate(image_scale(imgs, "300x300"), fps = 4, dispose = "previous")

image_write(animation, "animation.gif")
toc()
