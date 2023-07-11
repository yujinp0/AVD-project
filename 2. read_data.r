library(daqr)
library(tidyverse)
library(rhdf5)

reticulate::use_virtualenv("r-reticulate")

file_name <- "S2_Marked_20221021092334.daq"

read_daq_and_save_to_hdf5(file_name)

file_name <- "S2_Marked_20221021092334.hdf5"

ddf1 <- h5read(file = file_name,
       name = "dynobjs")$H1


ddf1 <- as.data.frame(ddf1)



ddf2 <- h5read(file = file_name,
               name = "dynobjs")$A1


ddf2 <- as.data.frame(ddf2)




ggplot(ddf1) +
  geom_point(aes(frames, speed*3.6))
plotly::ggplotly()



ggplot(ddf2) +
  geom_point(aes(frames, speed*3.6))
plotly::ggplotly()




df <- read_driver_data(file_name, TRUE)


ggplot(df) +
  geom_point(aes(frames, ED_speed_mps*3.28, color = "ED Speed")) +
  geom_point(aes(frames, LV_speed_mps*3.28, color = "LV Speed"))


ggplot(df %>% filter(ED_y_ft <= 15252)) +
  geom_point(aes(ED_y_ft, ED_speed_mps*3.28, color = "ED Speed")) +
  geom_point(aes(ED_y_ft, LV_speed_mps*3.28, color = "LV Speed"))


ggplot(df %>% filter(ED_y_ft <= 15252)) +
  geom_point(aes(ED_y_ft, ED_acc_pedal_pos, color = "ED gas pedal pos")) 


ggplot(df %>% filter(ED_y_ft <= 15252)) +
  geom_point(aes(ED_y_ft, ED_brake_pedal_force_kg, color = "ED brake pedal force")) 


plot(ddf1$speed)
lines(ddf2$speed, col="red")
lines(df$ED_speed_mps, col= "blue")

set.seed(123)
sp_dist_mph <- rnorm(n = 50, mean = 49.7, sd = 6.2)
sp_dist_mph

plot(sp_dist_mph)
lines(sp_dist_mph)

x =df$ED_speed_mph*1.467

plot(df$LV_speed_fps)
lines(x, col="red")
lines(df$ED_speed_mph, col="blue")
