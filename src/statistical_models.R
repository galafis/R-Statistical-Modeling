# ===========================================================
# statistical_models.R : Modelagem Estatística Avançada
# Projeto R Statistical Modeling • Autor: Gabriel Demetrios Lafis
# Descrição: Implementa funções de regressão linear múltipla, logística binária
#            e ANOVA unifatorial, seguindo boas práticas de modularidade,
#            documentação e tratamento de erros para uso didático/profissional.
# Data: 2025-09-11
# Versão: 1.0
# ===========================================================

# === DEPENDÊNCIAS ===
library(stats)
library(broom)  # Para tidy model outputs

# === FUNÇÕES PRINCIPAIS ===

#' Ajusta modelo de regressão linear múltipla
#'
#' Esta função implementa regressão linear múltipla com validações robustas
#' e retorna um modelo lm pronto para análise e interpretação.
#'
#' @param data Data frame contendo as variáveis do modelo
#' @param formula Fórmula R especificando o modelo (ex: y ~ x1 + x2 + x3)
#' @param validate Logical, se TRUE realiza validações adicionais (default: TRUE)
#' @return Lista contendo o modelo lm e resumo estatístico
#' @examples
#' # modelo <- fit_linear_model(mtcars, mpg ~ wt + hp + cyl)
#' # print(modelo$summary)
#' @export
fit_linear_model <- function(data, formula, validate = TRUE) {
  # Validações de entrada
  if (!is.data.frame(data)) {
    stop("Argumento 'data' deve ser um data frame")
  }
  
  if (nrow(data) < 5) {
    stop("Data frame deve conter pelo menos 5 observações para regressão linear")
  }
  
  if (validate) {
    # Verifica se há valores NA nas variáveis do modelo
    vars <- all.vars(formula)
    if (any(sapply(data[vars], function(x) any(is.na(x))))) {
      warning("Dados contêm valores NA. Considere tratá-los antes da análise.")
    }
  }
  
  # Ajusta o modelo
  tryCatch({
    model <- lm(formula, data = data)
    model_summary <- summary(model)
    
    # Retorna lista estruturada
    result <- list(
      model = model,
      summary = model_summary,
      formula = formula,
      call = match.call()
    )
    
    cat("✓ Modelo de regressão linear ajustado com sucesso\n")
    cat("  R² ajustado:", round(model_summary$adj.r.squared, 4), "\n")
    cat("  P-valor F:", format.pval(model_summary$fstatistic[1]), "\n")
    
    return(result)
    
  }, error = function(e) {
    stop("Erro ao ajustar modelo linear: ", e$message)
  })
}

#' Ajusta modelo de regressão logística binária
#'
#' Implementa regressão logística para variáveis dependentes binárias
#' com tratamento robusto de erros e diagnósticos automáticos.
#'
#' @param data Data frame contendo as variáveis
#' @param formula Fórmula R para o modelo logístico (ex: y ~ x1 + x2)
#' @param validate Logical, se TRUE realiza validações adicionais (default: TRUE)
#' @return Lista contendo modelo glm e métricas de ajuste
#' @examples
#' # modelo <- fit_logistic_model(mtcars, am ~ mpg + wt + hp)
#' # print(modelo$summary)
#' @export
fit_logistic_model <- function(data, formula, validate = TRUE) {
  # Validações de entrada
  if (!is.data.frame(data)) {
    stop("Argumento 'data' deve ser um data frame")
  }
  
  if (nrow(data) < 10) {
    stop("Data frame deve conter pelo menos 10 observações para regressão logística")
  }
  
  if (validate) {
    # Verifica se a variável resposta é binária
    response_var <- all.vars(formula)[1]
    unique_vals <- unique(na.omit(data[[response_var]]))
    
    if (length(unique_vals) != 2) {
      stop("Variável dependente deve ser binária (0/1 ou TRUE/FALSE)")
    }
  }
  
  # Ajusta o modelo
  tryCatch({
    model <- glm(formula, data = data, family = binomial(link = "logit"))
    model_summary <- summary(model)
    
    # Calcula métricas adicionais
    null_deviance <- model$null.deviance
    residual_deviance <- model$deviance
    pseudo_r2 <- 1 - (residual_deviance / null_deviance)
    
    result <- list(
      model = model,
      summary = model_summary,
      pseudo_r2 = pseudo_r2,
      aic = AIC(model),
      formula = formula,
      call = match.call()
    )
    
    cat("✓ Modelo de regressão logística ajustado com sucesso\n")
    cat("  Pseudo R² (McFadden):", round(pseudo_r2, 4), "\n")
    cat("  AIC:", round(AIC(model), 2), "\n")
    
    return(result)
    
  }, error = function(e) {
    stop("Erro ao ajustar modelo logístico: ", e$message)
  })
}

#' Executa Análise de Variância (ANOVA) unifatorial
#'
#' Implementa ANOVA de um fator com validações estatísticas
#' e testes de pressupostos automáticos.
#'
#' @param data Data frame contendo os dados
#' @param formula Fórmula R para ANOVA (ex: resposta ~ fator)
#' @param alpha Nível de significância para os testes (default: 0.05)
#' @return Lista contendo resultados da ANOVA e testes de pressupostos
#' @examples
#' # resultado <- run_anova(mtcars, mpg ~ factor(cyl))
#' # print(resultado$anova_table)
#' @export
run_anova <- function(data, formula, alpha = 0.05) {
  # Validações de entrada
  if (!is.data.frame(data)) {
    stop("Argumento 'data' deve ser um data frame")
  }
  
  if (nrow(data) < 6) {
    stop("Data frame deve conter pelo menos 6 observações para ANOVA")
  }
  
  # Extrai variáveis da fórmula
  vars <- all.vars(formula)
  if (length(vars) != 2) {
    stop("Fórmula deve conter exatamente uma variável dependente e uma independente")
  }
  
  response_var <- vars[1]
  factor_var <- vars[2]
  
  # Validações específicas
  if (!is.numeric(data[[response_var]])) {
    stop("Variável dependente deve ser numérica")
  }
  
  # Verifica se há pelo menos 2 grupos
  groups <- unique(na.omit(data[[factor_var]]))
  if (length(groups) < 2) {
    stop("Variável independente deve ter pelo menos 2 grupos")
  }
  
  # Ajusta o modelo ANOVA
  tryCatch({
    aov_model <- aov(formula, data = data)
    aov_summary <- summary(aov_model)
    
    # Testes de pressupostos
    residuals <- residuals(aov_model)
    
    # Teste de normalidade (Shapiro-Wilk)
    normality_test <- shapiro.test(residuals)
    
    # Teste de homocedasticidade (Bartlett)
    bartlett_test <- bartlett.test(formula, data = data)
    
    result <- list(
      model = aov_model,
      anova_table = aov_summary,
      normality_test = normality_test,
      homogeneity_test = bartlett_test,
      residuals = residuals,
      alpha = alpha,
      formula = formula,
      call = match.call()
    )
    
    # Relatório automático
    p_value <- aov_summary[[1]]$`Pr(>F)`[1]
    cat("✓ ANOVA unifatorial executada com sucesso\n")
    cat("  P-valor:", format.pval(p_value), "\n")
    cat("  Significativo (α =", alpha, "):", ifelse(p_value < alpha, "SIM", "NÃO"), "\n")
    
    # Avisos sobre pressupostos
    if (normality_test$p.value < alpha) {
      cat("⚠ Atenção: Teste de normalidade rejeitado (p =", format.pval(normality_test$p.value), ")\n")
    }
    
    if (bartlett_test$p.value < alpha) {
      cat("⚠ Atenção: Teste de homocedasticidade rejeitado (p =", format.pval(bartlett_test$p.value), ")\n")
    }
    
    return(result)
    
  }, error = function(e) {
    stop("Erro ao executar ANOVA: ", e$message)
  })
}

# === EXEMPLOS DE USO (DESATIVADOS) ===
if (FALSE) {
  # Carrega dados de exemplo
  data(mtcars)
  
  # 1. REGRESSÃO LINEAR MÚLTIPLA
  cat("\n=== EXEMPLO: Regressão Linear ===\n")
  linear_result <- fit_linear_model(
    data = mtcars, 
    formula = mpg ~ wt + hp + cyl + qsec
  )
  print(linear_result$summary)
  
  # 2. REGRESSÃO LOGÍSTICA BINÁRIA
  cat("\n=== EXEMPLO: Regressão Logística ===\n")
  logistic_result <- fit_logistic_model(
    data = mtcars,
    formula = am ~ mpg + wt + hp
  )
  print(logistic_result$summary)
  cat("Pseudo R²:", logistic_result$pseudo_r2, "\n")
  
  # 3. ANOVA UNIFATORIAL
  cat("\n=== EXEMPLO: ANOVA ===\n")
  anova_result <- run_anova(
    data = mtcars,
    formula = mpg ~ factor(cyl)
  )
  print(anova_result$anova_table)
  
  # Análise post-hoc (se significativo)
  if (anova_result$anova_table[[1]]$`Pr(>F)`[1] < 0.05) {
    cat("\nTeste post-hoc (Tukey HSD):\n")
    tukey_result <- TukeyHSD(anova_result$model)
    print(tukey_result)
  }
}

# Operador auxiliar para concatenação
`%+%` <- function(a, b) paste0(a, b)

# === MENSAGENS DE EXPORTAÇÃO ===
cat("\n" %+% rep("=", 50) %+% "\n")
cat("📊 MÓDULO STATISTICAL_MODELS.R CARREGADO COM SUCESSO\n")
cat(rep("=", 50) %+% "\n")
cat("Funções disponíveis:\n")
cat("  • fit_linear_model()    - Regressão linear múltipla\n")
cat("  • fit_logistic_model()  - Regressão logística binária\n")
cat("  • run_anova()           - ANOVA unifatorial\n")
cat("\nPara ativar exemplos: altere if (FALSE) para if (TRUE)\n")
cat("Documentação: use ?nome_da_funcao para ajuda detalhada\n")
cat(rep("=", 50) %+% "\n")

# === FIM DO ARQUIVO ===
