#ROH plots for Simons
#Panel.txt file includes sample vs population information

all_pop <- read.delim("panel.txt", header = TRUE, stringsAsFactors = F, sep = "\t")
rohfile <-  read.delim("~/Downloads/_1_simons_roh.hom", header = TRUE, stringsAsFactors = F, sep = "")
rohfile2 <- data.frame("sample" = rohfile$IID, "Chromozom" = rohfile$CHR, "KB" = rohfile$KB, "NSNP"=rohfile$NSNP, "DENSITY"= rohfile$DENSITY)
roh_merged <- merge(rohfile2, all_pop, by ="sample", all= FALSE)


ggplot(roh_merged, aes(factor(pop), log(KB), color=pop)) +
  geom_violin() +
  labs(title="Runs of Homozygosity for Simons (yes filter)",x="Populations", y = "log(ROH) in KB") +
  theme(text = element_text(size=10), axis.text.x = element_text( size=7, angle=45))
ggsave("~/Desktop/Simons_ROH_afterfilter_2.png")  

kruskal.test(log(KB) ~ pop, 
             data = roh_merged)

ROH2 <- roh_merged %>% group_by(sample)  %>%  summarise(sroh=sum(KB), nroh=n())
ROH2 <- merge(ROH2, all_pop, by="sample", all=FALSE)

ggplot(data = ROH2, aes(factor(pop), sroh, color=pop))+
  geom_violin() +
  labs(title="Runs of Homozygosity for Simons (yes filter)",x="Populations", y = "SROH in KB") +
  theme(text = element_text(size=10), axis.text.x = element_text( size=7, angle=45))
ggsave("~/Simons_ROH_afterfilter2_3.png")  

kruskal.test(sroh ~ pop, 
             data = ROH2)


ggplot(data = ROH2, aes(sroh, nroh, color=pop))+
  geom_point(alpha = 0.3) +
  labs(title="Runs of Homozygosity for Simons (no filter)",x="SROH", y = "NROH in KB") +
  theme(text = element_text(size=10), axis.text.x = element_text( size=7, angle=45)) +
  facet_wrap(~pop, ncol=3)
ggsave("~/Simons_ROH_beforefilter3_2.png")  
