# ===========================================================
# statistical_models.R : Modelagem Estatística Avançada
# Projeto R Statistical Modeling • Autor: Gabriel Demetrios Lafis
# Descrição: Implementa funções de regressão linear, logística e ANOVA,
#            seguindo boas práticas de modularidade e documentação.
# Data: 2025-09-11
# ===========================================================

# === Dependências
library(stats)
library(dplyr)

#' Ajusta modelo de regressão linear múltipla
#' @param data Data frame de entrada
#' @param formula Fórmula R (ex: y ~ x1 + x2)
#' @return Objeto lm
#' @export
fit_linear_model <- function(data, formula) {
  if (!is.data.frame(data)) stop("Data precisa ser data frame")
  if (nrow(data) < 3) stop("Poucos dados para regressão linear")
  model <- lm(formula, data = data)
  summary(model)
}

#' Ajusta modelo de regressão logística binária
#' @param data Data frame
#' @param formula Fórmula R (ex: y ~ x1 + x2)
#' @return Objeto glm (família binomial)
#' @export
fit_logistic_model <- function(data, formula) {
  if (!is.data.frame(data)) stop("Data precisa ser data frame")
  model <- glm(formula, data = data, family = binomial)
  summary(model)
}

#' Executa Análise de Variância (ANOVA)
#' @param data Data frame
#' @param formula Fórmula R (ex: resposta ~ fator)
#' @return Objeto aov
#' @export
run_anova <- function(data, formula) {
  if (!is.data.frame(data)) stop("Data precisa ser data frame")
  model <- aov(formula, data = data)
  summary(model)
}

# ============ EXEMPLOS DE USO =============
if (FALSE) {
  # Exemplo regressão linear
  lin_mod <- fit_linear_model(mtcars, mpg ~ wt + hp + cyl)
  print(lin_mod)

  # Exemplo regressão logística (am ~ mpg + wt)
  log_mod <- fit_logistic_model(mtcars, am ~ mpg + wt)
  print(log_mod)

  # Exemplo ANOVA com fatores
  anova_mod <- run_anova(mtcars, mpg ~ factor(cyl))
  print(anova_mod)
}

cat("Módulo statistical_models.R carregado: fit_linear_model(), fit_logistic_model(), run_anova()\n")
cat("Para exemplo, troque if (FALSE) por if (TRUE).\n")
