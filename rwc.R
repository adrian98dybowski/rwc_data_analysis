library(readxl)
library(ggplot2)
library(data.table)

rwc <- read_excel("Trening/rwc_history.xlsx")
setDT(rwc)
rwc[, rank := ifelse(position == "Pool stage", 1, ifelse(position == "Quater-finals", 2, ifelse(position == "Fourth place", 3, ifelse(position == "Third place", 4,
                                                                                                                                      ifelse(position == "Runner-up", 5,6)))))]
rwc_best <- rwc[rank > 1]
ggplot(rwc_best, aes(x=year, y = rank, colour = country, label = country))+
  geom_line(size = 1)+
  geom_text(aes(label=country,hjust=0.5,vjust=-2))+
  scale_y_continuous(name="Position in RWC", labels = c("Quater-finals", "Fourth place", "Third place", "Runner-up", "Champion")) +
  scale_x_continuous(name="RWC edition", breaks = c(1987, 1991, 1995, 1999, 2003, 2007, 2011, 2015, 2019)) +
  ggtitle("Knockout stage in Rugby World Cup")

            
