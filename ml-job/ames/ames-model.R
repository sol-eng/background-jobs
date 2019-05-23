library(recipes)
library(yardstick)
library(parsnip)
library(rsample)
library(purrr)
library(dplyr)

# Make data ----
message("Making data")
ames <- AmesHousing::make_ames()

# Build recipe ----
message("Building recipe")
rec <- 
  recipe(Sale_Price ~ Neighborhood + House_Style + Year_Sold + Lot_Area, 
         data = ames) %>%
  # Log the outcome
  step_log(Sale_Price, base = 10) %>%
  # Collapse rarely occurring jobs into "other"
  step_other(Neighborhood, House_Style, threshold = 0.05) %>%
  # Dummy variables on the qualitative predictors
  step_dummy(all_nominal()) %>%
  # Unskew a predictor
  step_BoxCox(Lot_Area) %>%
  # Normalize
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) 

rec_train <- prep(rec, training = ames)

# Bootstrap sampling ----
message("Bootstrap sampling")
set.seed(35487)
bt_samples <- bootstraps(ames) %>% 
  mutate(recipes = map(splits, prepper, recipe = rec))

# Model definition ----
message("Defining model")
rf <- rand_forest(mode = "regression",
                  mtry = 10,
                  trees = 25,
                  min_n = 7) %>% 
  set_engine("randomForest")

# Model training ----
message("Training models")
bt_samples <- bt_samples %>% 
  mutate(models = map(recipes, function(rec){
    fit(rf, Sale_Price ~ ., data = juice(rec))
  }))

# Model Evaluation ----
message("Evaluating models")
bt_samples <- bt_samples %>% 
  mutate(pred = pmap(lst(split = splits, model = models, recipe = recipes), function(split, model, recipe){
    mod_data <- bake(recipe, new_data = assessment(split), all_predictors(), all_outcomes())
    out <- mod_data %>% select(Sale_Price)
    out$predicted <- predict(model, new_data = mod_data %>% select(-Sale_Price)) %>% pull(".pred")
    out
  }))

results <- map_df(bt_samples$pred, rmse, Sale_Price, predicted)

print(summary(results$.estimate))
