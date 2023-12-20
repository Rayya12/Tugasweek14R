# import data dan cleaning
library(tidyverse)
library(palmerpenguins)
data("penguins")
penguin_clear <- na.omit(penguins)
penguin_clear$year <- as.factor(penguin_clear$year)


# load ggpubr
library(ggpubr)
library(ggplot2)


# create boxplot
bxp <- ggboxplot(penguin_clear,x = "species", y="bill_length_mm",color = "species",palette = "jco")
bxp

# create dot plot
dp <- ggdotplot(penguin_clear,x="species",y= "bill_length_mm",color = "species",palette = "jco")
dp

# create bar plot
bp <- ggbarplot(penguin_clear, x = "species", y = "bill_length_mm",fill = "year",color = "white",
                palette="jco",sort.by.groups = T,x.text.angle= 90)
bp + font("x.text", size = 8)


# create scatter plot

sp <- ggscatter(penguin_clear, x = "bill_length_mm", y = "bill_depth_mm",
                add = "reg.line",               
                conf.int = TRUE,                
                color = "year", palette = "jco", 
                shape = "year"                   
)+
  stat_cor(aes(color = year), label.x = 30)  

sp

## arrange
# menggunakan ggarange
ggarrange(bxp, dp, sp  + rremove("x.text"), 
          labels = c("A", "B", "C"),
          ncol = 2, nrow = 2)

# menggunakan cowplot
library("cowplot")
plot_grid(bxp, dp, sp  + rremove("x.text"), 
          labels = c("A", "B", "C"),
          ncol = 2, nrow = 2)

# menggunakan grid arrange
library("gridExtra")
grid.arrange(bxp, dp, sp   + rremove("x.text"), 
             ncol = 2, nrow = 2)



# create a figure
figure <- ggarrange(sp, bxp + font("x.text", size = 10),
                    ncol = 1, nrow = 2)
annotate_figure(figure,
                top = text_grob("Visualizing mpg", color = "red", face = "bold", size = 14),
                bottom = text_grob("Data source: \n palmerpenguins data set", color = "blue",
                                   hjust = 1, x = 1, face = "italic", size = 10),
                left = text_grob("Figure arranged using ggpubr", color = "green", rot = 90),
                right = "I'm done, thanks :-)!",
                fig.lab = "Figure 1", fig.lab.face = "bold"
)






