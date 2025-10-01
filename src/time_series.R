# ======================================================
# time_series.R : Análise de Séries Temporais em R
# Projeto R Statistical Modeling • Autor: Gabriel Demetrios Lafis
# Descrição: Funções para modelagem e previsão usando ARIMA e GARCH
# Data: 2025-09-12
# ======================================================

# Dependências
library(forecast)
# instalar rugarch se desejar GARCH avançado

#' Ajusta modelo ARIMA automaticamente
#' @param ts_data Série temporal (classe ts/numeric)
#' @return Modelo auto.arima
#' @examples
#' # model <- fit_arima(AirPassengers)
fit_arima <- function(ts_data) {
  if (is.numeric(ts_data)) ts_data <- ts(ts_data)
  model <- auto.arima(ts_data)
  summary(model)
}

#' Previsão a partir de modelo ARIMA
#' @param model Objeto ARIMA
#' @param h horizonte
#' @return Objeto forecast
#' @examples
#' # fc <- forecast_arima(model, h=12)
forecast_arima <- function(model, h = 12) {
  fc <- forecast::forecast(model, h = h)
  plot(fc)
  fc
}

#' Ajusta modelo GARCH simples (opcional, depende do pacote rugarch)
#' @param ts_data Série temporal
#' @return Modelo GARCH
#' @examples
#' # garch_mod <- fit_garch(AirPassengers)
fit_garch <- function(ts_data) {
  if (!requireNamespace("rugarch", quietly = TRUE)) {
    stop("Pacote rugarch não instalado para GARCH.")
  }
  spec <- rugarch::ugarchspec()
  fit <- rugarch::ugarchfit(spec = spec, data = ts_data)
  show(fit)
  fit
}

# ============ EXEMPLOS DE USO ============
if (FALSE) {
  # 1. ARIMA com dados clássicos
  data(AirPassengers)
  arima_mod <- fit_arima(AirPassengers)
  
  forecast_arima(arima_mod, h = 24)
  
  # 2. GARCH (se rugarch estiver disponível)
  # garch_mod <- fit_garch(AirPassengers)
}

cat('\n===== MÓDULO TIME SERIES CARREGADO =====\n')
cat('Funções: fit_arima(), forecast_arima(), fit_garch()\n')
cat('Para exemplos, altere if (FALSE) para if (TRUE)\n')
