# Testes Automatizados

Esta pasta contém a suíte completa de testes automatizados para garantir qualidade e confiabilidade do código R.

## Propósito

- Validação automática de funções e modelos
- Teste de regressão para evitar quebras
- Garantia de qualidade contínua
- Documentação através de exemplos de uso

## Estrutura dos Testes

### Unit Tests
- **test_preprocessing.R**: Testes para funções de pré-processamento
- **test_models.R**: Testes para modelos estatísticos
- **test_utils.R**: Testes para funções utilitárias
- **test_visualization.R**: Testes para funções de visualização

### Integration Tests
- **test_pipeline.R**: Testes do pipeline completo de análise
- **test_workflows.R**: Testes de fluxos de trabalho integrados
- **test_data_flow.R**: Testes de fluxo de dados entre componentes

### Performance Tests
- **benchmark_models.R**: Benchmarks de performance dos modelos
- **memory_tests.R**: Testes de uso de memória
- **scalability_tests.R**: Testes de escalabilidade

## Framework de Testes

### testthat
Utilizamos o framework `testthat` para estruturar os testes:

```r
library(testthat)

# Exemplo de teste unitário
test_that("função de normalização funciona corretamente", {
  dados <- c(1, 2, 3, 4, 5)
  resultado <- normalize_data(dados)
  
  expect_equal(length(resultado), length(dados))
  expect_true(all(resultado >= 0 & resultado <= 1))
  expect_equal(min(resultado), 0)
  expect_equal(max(resultado), 1)
})
```

### Cobertura de Testes
- Meta: >80% de cobertura de código
- Use `covr` package para medir cobertura
- Priori zero funções críticas

## Executando os Testes

### Todos os Testes
```r
# Executar toda a suíte
testthat::test_dir("tests/")

# Com cobertura
covr::package_coverage()
```

### Testes Específicos
```r
# Apenas testes de modelos
testthat::test_file("tests/test_models.R")

# Testes por padrão
testthat::test_dir("tests/", filter = "preprocessing")
```

### Via Command Line
```bash
# Executar todos os testes
Rscript -e "testthat::test_dir('tests/')"

# Com saída detalhada
Rscript -e "testthat::test_dir('tests/', reporter = 'summary')"
```

## Tipos de Testes

### Testes de Funções
- Input validation
- Output correctness
- Edge cases
- Error handling

### Testes de Modelos
- Model fitting
- Prediction accuracy
- Parameter estimation
- Convergence

### Testes de Dados
- Data integrity
- Schema validation
- Missing values handling
- Outlier detection

## Boas Práticas

### Naming Convention
- Arquivos: `test_[modulo].R`
- Funções de teste: `test_that("descrição clara"...)`
- Objetos de teste: `expected_`, `actual_`, `test_`

### Estrutura dos Testes
```r
# Setup
setup({
  # Preparar dados de teste
  test_data <- generate_test_data()
})

# Teardown
teardown({
  # Limpar recursos
  unlink("temp_files/*")
})

# Test cases
test_that("descrição do comportamento esperado", {
  # Arrange
  input_data <- prepare_input()
  
  # Act
  result <- function_under_test(input_data)
  
  # Assert
  expect_equal(result$status, "success")
  expect_gt(result$accuracy, 0.8)
})
```

### Test Data
- Use dados sintéticos quando possível
- Mantenha datasets pequenos para rapidez
- Inclua casos extremos e edge cases
- Teste com dados faltantes e inconsistentes

## CI/CD Integration

### GitHub Actions
```yaml
# .github/workflows/test.yml
name: R Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: r-lib/actions/setup-r@v1
    - name: Install dependencies
      run: |
        install.packages(c("testthat", "covr"))
    - name: Run tests
      run: |
        testthat::test_dir("tests/")
        covr::codecov()
```

## Métricas de Qualidade

### Cobertura de Código
- Line coverage: >80%
- Function coverage: 100%
- Branch coverage: >70%

### Performance
- Tempo máximo por teste: 30s
- Uso de memória: <500MB
- Todos os testes: <5min

## Documentação dos Testes

### README por Módulo
Cada conjunto de testes deve incluir:
- Objetivos dos testes
- Casos testados
- Dados de teste utilizados
- Critérios de aceitação

### Relatórios
- Relatórios automáticos de cobertura
- Trending de performance
- Alertas para regressões

## Debugging de Testes

### Testes Falhando
```r
# Debug interativo
testthat::test_file("tests/test_models.R", 
                   stop_on_failure = TRUE)

# Com breakpoints
debugonce(function_under_test)
testthat::test_that("test case", {...})
```

### Ferramentas Úteis
- `browser()`: Para debug interativo
- `testthat::skip()`: Pular testes temporariamente
- `testthat::expect_warning()`: Testar warnings esperados
