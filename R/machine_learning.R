# ===========================================================
# machine_learning.R : Algoritmos de Machine Learning Clássicos
# Projeto R Statistical Modeling • Autor: Gabriel Demetrios Lafis
# Descrição: Funções modulares para Random Forest, SVM e K-means.
# Data: 2025-09-11
# ===========================================================

# Dependências
library(randomForest)
library(e1071)
library(dplyr)

#' Random Forest Classificação
#' @param data Data frame
#' @param formula Fórmula (ex: Species ~ .)
#' @param ntree Número de árvores
#' @return Lista com modelo, importância, predições
#' @examples
#' # rf <- run_random_forest(iris, Species ~ ., ntree = 200)
run_random_forest <- function(data, formula, ntree = 200) {
  if (!is.data.frame(data)) stop("data precisa ser data.frame")
  model <- randomForest(formula, data = data, ntree = ntree)
  pred <- predict(model, data)
  importance <- importance(model)
  list(model = model, predictions = pred, importance = importance)
}

#' SVM Classificação (e1071)
#' @param data Data frame
#' @param formula Fórmula
#' @param kernel Tipo de kernel (default "radial")
#' @return Lista: modelo, predição, acurácia
#' @examples
#' # svm <- run_svm(iris, Species ~ ., kernel="linear")
run_svm <- function(data, formula, kernel = "radial") {
  if (!is.data.frame(data)) stop("data precisa ser data.frame")
  model <- svm(formula, data = data, kernel = kernel)
  pred <- predict(model, data)
  acc <- mean(pred == data[[all.vars(formula)[1]]])
  list(model = model, predictions = pred, accuracy = acc)
}

#' Clustering (K-means)
#' @param data Data frame (apenas numérico)
#' @param centers Número de clusters
#' @param nstart Inicializações
#' @return Objeto kmeans
#' @examples
#' # clust <- run_clustering(iris[,1:4], centers=3)
run_clustering <- function(data, centers = 3, nstart = 20) {
  if (!is.data.frame(data)) stop("data precisa ser data.frame numérico")
  km <- kmeans(data, centers = centers, nstart = nstart)
  km
}

# ============ EXEMPLOS DE USO =============
if (FALSE) {
  # 1. Random Forest
  rf <- run_random_forest(iris, Species ~ .)
  print(rf$model)
  print(rf$importance)

  # 2. SVM
  svm_mod <- run_svm(iris, Species ~ ., kernel = "linear")
  print(svm_mod$model)
  print(svm_mod$accuracy)

  # 3. K-means
  clust <- run_clustering(iris[,1:4], centers = 3)
  print(clust$centers)
  print(table(clust$cluster, iris$Species))
}

cat("\n===== MÓDULO DE MACHINE LEARNING CARREGADO =====\n")
cat("Funções disponíveis:\n")
cat(" • run_random_forest()\n • run_svm()\n • run_clustering()\n")
cat("Para exemplos: if (FALSE) > if (TRUE)\n")
