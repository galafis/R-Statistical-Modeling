# =========================================================
# utils.R : Funções Utilitárias para Projetos Estatísticos
# Projeto R Statistical Modeling • Autor: Gabriel Demetrios Lafis
# Data: 2025-09-12
# Descrição: Utilidades genéricas e funções auxiliares de projeto.
# =========================================================

#' Normalização simples (Min-Max)
#' @param x Vetor numérico
#' @return Vetor normalizado [0,1]
#' @examples
#' # normalize_minmax(c(1, 3, 5))
normalize_minmax <- function(x) {
  rng <- range(x, na.rm = TRUE)
  if (diff(rng) == 0) return(rep(0, length(x)))
  (x - rng[1]) / diff(rng)
}

#' Padronização (Z-score)
#' @param x Vetor numérico
#' @return Vetor padronizado
#' @examples
#' # standardize_z(c(1, 2, 3))
standardize_z <- function(x) {
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}

#' Conversor de fatores para dummies (one-hot encoding)
#' @param df Data frame
#' @param cols Colunas a codificar (default: todas factors)
#' @return Data frame expandido
#' @examples
#' # df <- factor_to_dummies(iris)
factor_to_dummies <- function(df, cols = NULL) {
  if (is.null(cols)) cols <- names(df)[sapply(df, is.factor)]
  if (length(cols) == 0) return(df)
  dummies <- model.matrix(~ . -1, df[cols])
  df <- df[, !names(df) %in% cols, drop = FALSE]
  cbind(df, dummies)
}

#' Gravação segura de RDS
#' @param obj Objeto a ser salvo
#' @param path Caminho do arquivo
#' @examples
#' # save_rds_safe(mtcars, "mtcars.rds")
save_rds_safe <- function(obj, path) {
  tryCatch({
    saveRDS(obj, path)
    cat("Arquivo salvo em:", path, "\n")
  }, error = function(e) {
    cat("Erro ao salvar arquivo:", e$message, "\n")
  })
}

# ============ EXEMPLOS DE USO ============
if (FALSE) {
  # Normalização
  print(normalize_minmax(c(5,10,20)))
  # Padronização
  print(standardize_z(mtcars$mpg))
  # Fatores para dummies
  print(head(factor_to_dummies(iris)))
  # Salvar arquivo
  save_rds_safe(mtcars, "mtcars.rds")
}

cat('\n===== MÓDULO UTILS CARREGADO =====\n')
cat('Funções: normalize_minmax(), standardize_z(), factor_to_dummies(), save_rds_safe()\n')
cat('Para exemplos, troque if (FALSE) para if (TRUE)\n')
