
### from https://cran.r-project.org/web/packages/solitude/refman/solitude.html 
### see paper https://dl.acm.org/doi/10.1145/2133360.2133363 


library("solitude")
library("tidyverse")
library("mlbench")

data(PimaIndiansDiabetes)
PimaIndiansDiabetes = as_tibble(PimaIndiansDiabetes)
PimaIndiansDiabetes

splitter   = PimaIndiansDiabetes %>%
  select(-diabetes) %>%
  rsample::initial_split(prop = 0.5)
pima_train = rsample::training(splitter)
pima_test  = rsample::testing(splitter)

iso = isolationForest$new()
iso$fit(pima_train)

scores_train = pima_train %>%
  iso$predict() %>%
  arrange(desc(anomaly_score))

scores_train

umap_train = pima_train %>%
  scale() %>%
  uwot::umap() %>%
  setNames(c("V1", "V2")) %>%
  as_tibble() %>%
  rowid_to_column() %>%
  left_join(scores_train, by = c("rowid" = "id"))

umap_train

umap_train %>%
  ggplot(aes(V1, V2)) +
  geom_point(aes(size = anomaly_score))

scores_test = pima_test %>%
  iso$predict() %>%
  arrange(desc(anomaly_score))

scores_test

## my plot
scores_test %>%
  ggplot(aes(id, anomaly_score)) +
  geom_point(aes(size =  anomaly_score))

# quantiles of anomaly scores
quantile(scores_test$anomaly_score
         , probs = seq(0.5, 1, length.out = 11)
)


### can also use the isolation forests package (variations on same idea) ########
## https://cran.r-project.org/web/packages/isotree/vignettes/An_Introduction_to_Isolation_Forests.html
### ...

### isolation forests: solitude-package, isotree-package, dif-function of HRTNomaly-package

library(HRTnomaly)

res <- dif(pima_train) %>%
  mutate(id=row_number()) 

res %>%
  ggplot(aes(id, scores)) +
  geom_point(aes(size = scores))

quantile(res$scores
         , probs = seq(0.5, 1, length.out = 11)
)


### >> gives "better separation" ?




