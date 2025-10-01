# ==============================================================================
# Data Preprocessing Module
# ==============================================================================
# 
# Descrição: Módulo para pré-processamento e limpeza de dados
# Autor: R Statistical Modeling Project
# Data: 2025-09-11
# 
# Funcionalidades:
# - Limpeza de dados faltantes
# - Normalização e padronização
# - Detecção de outliers
# - Transformação de variáveis
# - Validação de dados
# 
# ==============================================================================

# Dependências
library(dplyr)
library(tidyr)
library(VIM)
library(mice)
library(corrplot)

# ==============================================================================
# FUNÇÕES PRINCIPAIS
# ==============================================================================

#' Pré-processamento completo de dados
#' 
#' Esta função executa um pipeline completo de pré-processamento incluindo
#' limpeza, transformação e validação dos dados.
#' 
#' @param data Data frame com os dados brutos
#' @param missing_strategy Estratégia para valores faltantes ('remove', 'mean', 'median', 'mice')
#' @param normalize Lógico, se TRUE normaliza variáveis numéricas
#' @param remove_outliers Lógico, se TRUE remove outliers
#' @param outlier_method Método para detecção de outliers ('iqr', 'zscore')
#' 
#' @return Lista contendo dados processados e relatório
#' @export
preprocess_data <- function(data, 
                           missing_strategy = "mean",
                           normalize = TRUE,
                           remove_outliers = FALSE,
                           outlier_method = "iqr") {
  
  # Validação de entrada
  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }
  
  if (nrow(data) == 0) {
    stop("Data frame is empty")
  }
  
  # Inicializar relatório
  report <- list(
    original_rows = nrow(data),
    original_cols = ncol(data),
    missing_values = sum(is.na(data)),
    processing_steps = c()
  )
  
  cat("Iniciando pré-processamento...\n")
  cat("Dados originais:", nrow(data), "linhas,", ncol(data), "colunas\n")
  cat("Valores faltantes:", sum(is.na(data)), "\n")
  
  # 1. Tratamento de valores faltantes
  data_clean <- handle_missing_values(data, strategy = missing_strategy)
  report$processing_steps <- c(report$processing_steps, "missing_values_handled")
  
  # 2. Normalização (apenas variáveis numéricas)
  if (normalize) {
    numeric_cols <- sapply(data_clean, is.numeric)
    if (any(numeric_cols)) {
      data_clean[numeric_cols] <- scale(data_clean[numeric_cols])
      report$processing_steps <- c(report$processing_steps, "normalized")
      cat("Variáveis numéricas normalizadas\n")
    }
  }
  
  # 3. Remoção de outliers
  if (remove_outliers) {
    data_clean <- remove_outliers_func(data_clean, method = outlier_method)
    report$processing_steps <- c(report$processing_steps, "outliers_removed")
  }
  
  # 4. Relatório final
  report$final_rows <- nrow(data_clean)
  report$final_cols <- ncol(data_clean)
  report$rows_removed <- report$original_rows - report$final_rows
  
  cat("Pré-processamento concluído!\n")
  cat("Dados finais:", nrow(data_clean), "linhas,", ncol(data_clean), "colunas\n")
  
  return(list(
    data = data_clean,
    report = report
  ))
}

#' Tratamento de valores faltantes
#' 
#' @param data Data frame
#' @param strategy Estratégia ('remove', 'mean', 'median', 'mice')
#' @return Data frame com valores faltantes tratados
handle_missing_values <- function(data, strategy = "mean") {
  
  switch(strategy,
    "remove" = {
      na.omit(data)
    },
    "mean" = {
      data %>%
        mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
    },
    "median" = {
      data %>%
        mutate(across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)))
    },
    "mice" = {
      if (require(mice, quietly = TRUE)) {
        mice_result <- mice(data, m = 1, printFlag = FALSE)
        complete(mice_result)
      } else {
        warning("Package 'mice' not available. Using mean imputation.")
        handle_missing_values(data, "mean")
      }
    },
    {
      stop("Invalid strategy. Use 'remove', 'mean', 'median', or 'mice'")
    }
  )
}

#' Remoção de outliers
#' 
#' @param data Data frame
#' @param method Método ('iqr', 'zscore')
#' @return Data frame sem outliers
remove_outliers_func <- function(data, method = "iqr") {
  
  numeric_cols <- sapply(data, is.numeric)
  data_numeric <- data[, numeric_cols, drop = FALSE]
  data_other <- data[, !numeric_cols, drop = FALSE]
  
  if (method == "iqr") {
    # Método IQR
    outlier_rows <- c()
    for (col in names(data_numeric)) {
      Q1 <- quantile(data_numeric[[col]], 0.25, na.rm = TRUE)
      Q3 <- quantile(data_numeric[[col]], 0.75, na.rm = TRUE)
      IQR <- Q3 - Q1
      lower <- Q1 - 1.5 * IQR
      upper <- Q3 + 1.5 * IQR
      outlier_rows <- c(outlier_rows, which(data_numeric[[col]] < lower | data_numeric[[col]] > upper))
    }
    outlier_rows <- unique(outlier_rows)
    
  } else if (method == "zscore") {
    # Método Z-score
    z_scores <- abs(scale(data_numeric))
    outlier_rows <- which(apply(z_scores, 1, function(x) any(x > 3, na.rm = TRUE)))
  }
  
  if (length(outlier_rows) > 0) {
    cat("Removendo", length(outlier_rows), "outliers\n")
    data <- data[-outlier_rows, ]
  }
  
  return(data)
}

#' Validação de dados
#' 
#' @param data Data frame para validar
#' @return Lista com resultados da validação
validate_data <- function(data) {
  
  validation <- list(
    is_data_frame = is.data.frame(data),
    has_rows = nrow(data) > 0,
    has_cols = ncol(data) > 0,
    missing_percentage = round(sum(is.na(data)) / (nrow(data) * ncol(data)) * 100, 2),
    numeric_cols = sum(sapply(data, is.numeric)),
    character_cols = sum(sapply(data, is.character)),
    factor_cols = sum(sapply(data, is.factor))
  )
  
  return(validation)
}

# ==============================================================================
# EXEMPLO DE USO
# ==============================================================================

if (FALSE) {
  # Exemplo executável
  
  # Criar dados de exemplo
  set.seed(123)
  exemplo_dados <- data.frame(
    idade = c(25, 30, NA, 45, 50, 35, 28, 100, 22, 33),
    salario = c(50000, 60000, 55000, NA, 80000, 65000, 45000, 200000, 48000, 62000),
    departamento = c("TI", "RH", "TI", "Vendas", "TI", NA, "RH", "Vendas", "TI", "RH"),
    experiencia = c(2, 5, 3, 15, 18, 8, 1, 25, 1, 7)
  )
  
  cat("=== EXEMPLO DE PRÉ-PROCESSAMENTO ===\n")
  
  # Validar dados originais
  cat("\n1. Validação dos dados originais:\n")
  validacao <- validate_data(exemplo_dados)
  print(validacao)
  
  # Executar pré-processamento
  cat("\n2. Executando pré-processamento:\n")
  resultado <- preprocess_data(
    data = exemplo_dados,
    missing_strategy = "mean",
    normalize = TRUE,
    remove_outliers = TRUE,
    outlier_method = "iqr"
  )
  
  # Examinar resultados
  cat("\n3. Dados processados:\n")
  print(head(resultado$data))
  
  cat("\n4. Relatório de processamento:\n")
  print(resultado$report)
  
  # Validar dados finais
  cat("\n5. Validação dos dados finais:\n")
  validacao_final <- validate_data(resultado$data)
  print(validacao_final)
}

# ==============================================================================
# FUNÇÕES AUXILIARES
# ==============================================================================

#' Detecção de outliers
#' 
#' @param x Vetor numérico
#' @param method Método de detecção
#' @return Vetor lógico indicando outliers
detect_outliers <- function(x, method = "iqr") {
  if (method == "iqr") {
    Q1 <- quantile(x, 0.25, na.rm = TRUE)
    Q3 <- quantile(x, 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    lower <- Q1 - 1.5 * IQR
    upper <- Q3 + 1.5 * IQR
    return(x < lower | x > upper)
  } else if (method == "zscore") {
    z_scores <- abs(scale(x))
    return(z_scores > 3)
  }
}

#' Sumário estatístico completo
#' 
#' @param data Data frame
#' @return Lista com estatísticas descritivas
summary_stats <- function(data) {
  numeric_data <- data[sapply(data, is.numeric)]
  
  if (ncol(numeric_data) == 0) {
    return("Nenhuma variável numérica encontrada")
  }
  
  stats <- list(
    summary = summary(numeric_data),
    correlations = cor(numeric_data, use = "complete.obs"),
    missing_count = colSums(is.na(numeric_data))
  )
  
  return(stats)
}

cat("Módulo data_preprocessing.R carregado com sucesso!\n")
cat("Funções disponíveis: preprocess_data(), handle_missing_values(), validate_data()\n")
cat("Para executar exemplo: defina if (FALSE) como if (TRUE) e execute o script\n")
