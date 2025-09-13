# Shiny Applications

Este diretório contém as aplicações Shiny interativas para análise estatística em R.

## Estrutura das Aplicações

### statistical_dashboard/
Dashboard principal de análise estatística com:
- Visão geral dos dados
- Modelos estatísticos interativos
- Visualizações dinâmicas
- Relatórios automatizados

### model_explorer/
Explorador de modelos estatísticos com:
- Interface para teste de diferentes modelos
- Comparação de performance
- Validação cruzada interativa
- Diagnósticos de modelos

### data_visualizer/
Visualizador de dados com:
- Gráficos interativos
- Análise exploratória
- Customização de visualizações
- Exportação de gráficos

## Como usar

1. Navegue até o diretório da aplicação desejada
2. Execute o arquivo `app.R` ou use `shiny::runApp()`
3. Acesse a aplicação através do navegador

## Dependências

- shiny
- shinydashboard
- plotly
- DT
- ggplot2
- dplyr

## Execução

```r
# Dashboard principal
shiny::runApp("statistical_dashboard")

# Explorador de modelos
shiny::runApp("model_explorer")

# Visualizador de dados
shiny::runApp("data_visualizer")
```
