# =========================================================
# visualization.R : Visualizações Científicas em R
# Projeto R Statistical Modeling • Autor: Gabriel Demetrios Lafis
# Data: 2025-09-12
# Descrição: Funções modulares para visualização profissional (ggplot2, plotly, corrplot)
# =========================================================

# Pacotes necessários
library(ggplot2)
library(plotly)
library(corrplot)

#' Gráfico de dispersão básico com ggplot2
#' @param data Data frame
#' @param x Nome da variável no eixo x
#' @param y Nome do eixo y
#' @param color Agrupamento (opcional)
#' @return Objeto ggplot
#' @examples
#' # plot_basic_scatter(mtcars, "wt", "mpg", "cyl")
plot_basic_scatter <- function(data, x, y, color = NULL) {
  p <- ggplot(data, aes_string(x = x, y = y, color = color)) +
    geom_point(size = 3) +
    theme_minimal() +
    labs(title = paste("Dispersão:", y, "vs", x))
  print(p)
  return(p)
}

#' Gráfico interativo do ggplotly
#' @param gg Objeto ggplot2
#' @return Objeto plotly
#' @examples
#' # p <- plot_basic_scatter(mtcars, "wt", "mpg", "cyl")
#' # plot_interactive(p)
plot_interactive <- function(gg) {
  p_int <- plotly::ggplotly(gg)
  print(p_int)
  return(p_int)
}

#' Visualização de matriz de correlação
#' @param data Data frame somente variáveis numéricas
#' @param method "color" ou "number"
#' @return Plot corrplot
#' @examples
#' # plot_corr_matrix(mtcars)
plot_corr_matrix <- function(data, method = "color") {
  corr <- cor(data, use = "pairwise.complete.obs")
  corrplot(corr, method = method, type = "upper", tl.cex = 0.8)
}

# ============ EXEMPLOS DE USO ============
if (FALSE) {
  # 1. Dispersão básica
  plot_basic_scatter(mtcars, "wt", "mpg", "cyl")
  # 2. Dispersão interativa
  gg <- plot_basic_scatter(mtcars, "wt", "mpg")
  plot_interactive(gg)
  # 3. Matriz de correlação
  plot_corr_matrix(mtcars)
}

cat('\n===== MÓDULO DE VISUALIZAÇÃO CARREGADO =====\n')
cat('Funções disponíveis:\n')
cat(' • plot_basic_scatter()\n • plot_interactive()\n • plot_corr_matrix()\n')
cat('Para exemplos, altere if (FALSE) para if (TRUE)\n')
