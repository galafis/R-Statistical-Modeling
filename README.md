# R Statistical Modeling

![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-4285F4?style=flat&logo=rstudio&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-blue?style=flat&logo=RStudio&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-FF6600?style=flat&logo=r&logoColor=white)
![dplyr](https://img.shields.io/badge/dplyr-1f65cc?style=flat&logo=r&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

Suite avançada de modelagem estatística em R para análise de dados, machine learning, séries temporais e métodos bayesianos com visualizações interativas e relatórios automatizados.

## 🎯 Visão Geral

Plataforma completa de análise estatística que demonstra competências avançadas em R para modelagem estatística, análise de dados, machine learning e visualização de dados científicos.

### ✨ Características Principais

- **📊 Modelagem Estatística**: Regressão, GLM, modelos mistos
- **🔮 Séries Temporais**: ARIMA, GARCH, forecasting
- **🤖 Machine Learning**: Random Forest, SVM, clustering
- **📈 Visualizações**: ggplot2, plotly, dashboards interativos
- **📋 Relatórios**: R Markdown, documentos dinâmicos
- **🧪 Testes Estatísticos**: Hipóteses, ANOVA, testes não-paramétricos

## 🛠️ Stack Tecnológico

### Core R Packages
- **R 4.3+**: Linguagem de computação estatística
- **RStudio**: IDE integrado para desenvolvimento
- **tidyverse**: Conjunto de pacotes para ciência de dados
- **ggplot2**: Grammar of graphics para visualizações

### Modelagem e Análise
- **caret**: Classification and regression training
- **randomForest**: Algoritmos de random forest
- **e1071**: SVM e métodos estatísticos
- **forecast**: Análise de séries temporais
- **MASS**: Funções e datasets estatísticos

### Visualização e Interface
- **shiny**: Aplicações web interativas
- **plotly**: Gráficos interativos
- **DT**: Tabelas interativas
- **shinydashboard**: Dashboards profissionais

## 📁 Estrutura do Projeto

```
R-Statistical-Modeling/
├── R/                              # Scripts R organizados
│   ├── data_preprocessing.R        # Pré-processamento
│   ├── statistical_models.R       # Modelos estatísticos
│   ├── machine_learning.R         # Algoritmos ML
│   ├── time_series.R              # Análise temporal
│   ├── visualization.R            # Visualizações
│   └── utils.R                    # Funções utilitárias
├── data/                          # Datasets
│   ├── raw/                       # Dados brutos
│   ├── processed/                 # Dados processados
│   └── examples/                  # Dados de exemplo
├── reports/                       # Relatórios R Markdown
│   ├── analysis_report.Rmd        # Relatório principal
│   ├── model_comparison.Rmd       # Comparação de modelos
│   └── time_series_analysis.Rmd   # Análise temporal
├── shiny_apps/                    # Aplicações Shiny
│   ├── statistical_dashboard/     # Dashboard principal
│   ├── model_explorer/            # Explorador de modelos
│   └── data_visualizer/           # Visualizador de dados
├── tests/                         # Testes automatizados
├── main.R                         # Script principal
├── .gitignore                     # Arquivos ignorados
└── README.md                      # Documentação
```

## 🚀 Quick Start

### Pré-requisitos

- R 4.3+
- RStudio (recomendado)
- Rtools (Windows)

### Instalação

1. **Clone o repositório:**
```bash
git clone https://github.com/galafis/R-Statistical-Modeling.git
cd R-Statistical-Modeling
```

2. **Instale os pacotes necessários:**
```r
# Instalar pacotes principais
install.packages(c(
  "tidyverse", "ggplot2", "dplyr", "shiny", "plotly",
  "caret", "randomForest", "e1071", "forecast",
  "rmarkdown", "DT", "shinydashboard", "MASS"
))
```

3. **Execute o script principal:**
```r
source("main.R")
```

4. **Lance aplicação Shiny:**
```r
shiny::runApp("shiny_apps/statistical_dashboard")
```

## 📊 Funcionalidades Principais

### Modelagem Estatística
```r
# Regressão linear múltipla
model_lm <- lm(mpg ~ wt + hp + cyl, data = mtcars)
summary(model_lm)

# Modelo logístico
model_glm <- glm(am ~ mpg + wt, data = mtcars, family = binomial)
summary(model_glm)

# Análise de variância
anova_result <- aov(mpg ~ factor(cyl), data = mtcars)
summary(anova_result)
```

### Machine Learning
```r
library(caret)
library(randomForest)

# Random Forest
set.seed(123)
train_index <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
train_data <- iris[train_index, ]
test_data <- iris[-train_index, ]

rf_model <- randomForest(Species ~ ., data = train_data, ntree = 500)
predictions <- predict(rf_model, test_data)

# Matriz de confusão
confusionMatrix(predictions, test_data$Species)
```

### Análise de Séries Temporais
```r
library(forecast)

# Modelo ARIMA
ts_data <- ts(AirPassengers, frequency = 12)
arima_model <- auto.arima(ts_data)

# Previsão
forecast_result <- forecast(arima_model, h = 12)
plot(forecast_result)

# Métricas de acurácia
accuracy(arima_model)
```

### Visualizações Avançadas
```r
library(ggplot2)
library(plotly)

# Gráfico interativo
p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relação entre Peso e Consumo",
       x = "Peso (1000 lbs)", y = "Milhas por Galão",
       color = "Cilindros") +
  theme_minimal()

# Converter para plotly
ggplotly(p)
```

## 🧪 Testes Estatísticos

### Testes de Hipóteses
```r
# Teste t para duas amostras
t.test(mpg ~ am, data = mtcars)

# Teste qui-quadrado
chisq.test(table(mtcars$cyl, mtcars$am))

# Teste de normalidade
shapiro.test(mtcars$mpg)

# Teste de Kolmogorov-Smirnov
ks.test(mtcars$mpg, "pnorm", mean(mtcars$mpg), sd(mtcars$mpg))
```

### Análise de Correlação
```r
# Matriz de correlação
cor_matrix <- cor(mtcars[, c("mpg", "wt", "hp", "qsec")])

# Visualização da correlação
library(corrplot)
corrplot(cor_matrix, method = "color", type = "upper", 
         order = "hclust", tl.cex = 0.8, tl.col = "black")
```

## 📈 Aplicações Shiny

### Dashboard Estatístico
```r
# UI
ui <- dashboardPage(
  dashboardHeader(title = "Statistical Analysis Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data Overview", tabName = "overview"),
      menuItem("Statistical Models", tabName = "models"),
      menuItem("Visualizations", tabName = "plots")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
        fluidRow(
          box(title = "Dataset Summary", status = "primary", 
              solidHeader = TRUE, width = 12,
              DT::dataTableOutput("summary_table"))
        )
      )
    )
  )
)

# Server
server <- function(input, output) {
  output$summary_table <- DT::renderDataTable({
    summary(mtcars)
  })
}

# Run app
shinyApp(ui = ui, server = server)
```

## 📊 Análise Exploratória de Dados

### Estatísticas Descritivas
```r
# Resumo estatístico
summary(mtcars)

# Estatísticas por grupo
mtcars %>%
  group_by(cyl) %>%
  summarise(
    mean_mpg = mean(mpg),
    sd_mpg = sd(mpg),
    median_mpg = median(mpg),
    count = n()
  )
```

### Detecção de Outliers
```r
# Boxplot para identificar outliers
boxplot(mtcars$mpg, main = "Outliers em MPG")

# Método IQR
Q1 <- quantile(mtcars$mpg, 0.25)
Q3 <- quantile(mtcars$mpg, 0.75)
IQR <- Q3 - Q1
outliers <- mtcars$mpg < (Q1 - 1.5 * IQR) | mtcars$mpg > (Q3 + 1.5 * IQR)
```

## 🔬 Métodos Bayesianos

### Regressão Bayesiana
```r
library(rstanarm)

# Modelo bayesiano
bayes_model <- stan_glm(mpg ~ wt + hp, data = mtcars, 
                        family = gaussian(), 
                        prior = normal(0, 2.5),
                        prior_intercept = normal(0, 10))

# Resumo do modelo
summary(bayes_model)

# Intervalos de credibilidade
posterior_interval(bayes_model, prob = 0.95)
```

## 📋 Relatórios R Markdown

### Template de Relatório
```markdown
---
title: "Análise Estatística Avançada"
author: "Gabriel Demetrios Lafis"
date: "`r Sys.Date()`"
output: 
  html_document:
    toc: true
    toc_float: true
    theme: flatly
---

## Introdução

Este relatório apresenta uma análise estatística completa dos dados.

## Análise Exploratória

```{r}
summary(mtcars)
```

## Modelagem

```{r}
model <- lm(mpg ~ wt + hp, data = mtcars)
summary(model)
```
```

## 🧪 Testes e Validação

### Executar Testes
```bash
# Testes automatizados
Rscript tests/test_models.R

# Validação de funções
Rscript tests/test_functions.R

# Testes de performance
Rscript tests/benchmark_tests.R
```

### Validação Cruzada
```r
# K-fold cross validation
library(caret)

# Configurar validação cruzada
train_control <- trainControl(method = "cv", number = 10)

# Treinar modelo com validação cruzada
cv_model <- train(mpg ~ ., data = mtcars, 
                  method = "lm", 
                  trControl = train_control)

print(cv_model)
```

## 📊 Casos de Uso Práticos

### 1. Análise de Regressão
- Modelagem de relações entre variáveis
- Previsão de valores contínuos
- Análise de resíduos e diagnósticos

### 2. Classificação
- Análise discriminante
- Regressão logística
- Árvores de decisão

### 3. Análise de Sobrevivência
- Curvas de Kaplan-Meier
- Modelos de Cox
- Análise de risco

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

**Gabriel Demetrios Lafis**

- GitHub: [@galafis](https://github.com/galafis)
- Email: gabrieldemetrios@gmail.com

---

⭐ Se este projeto foi útil, considere deixar uma estrela!

