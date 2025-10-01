# Dados de Exemplo

Esta pasta contém datasets de exemplo para demonstração e testes dos modelos estatísticos.

## Propósito

- Conjuntos de dados curados para demonstrações
- Datasets clássicos da literatura estatística
- Amostras para tutoriais e documentação
- Dados sintéticos para validação de algoritmos

## Estrutura

- **classic/**: Datasets clássicos (iris, mtcars, Boston, etc.)
- **synthetic/**: Dados sintéticos gerados programaticamente
- **real_world/**: Datasets reais para casos de uso específicos
- **time_series/**: Séries temporais de exemplo

## Formato dos Dados

- Arquivos em formato .rds, .csv ou .xlsx
- Metadados incluídos em README.md de cada subpasta
- Documentação das variáveis e fontes
- Scripts de geração (para dados sintéticos)

## Utilização

```r
# Carregar dados de exemplo
data <- readRDS("data/examples/classic/iris.rds")

# Explorar estrutura
str(data)
summary(data)
```

## Contribuições

- Mantenha consistência nos formatos
- Documente origem e contexto dos dados
- Inclua scripts de limpeza quando aplicável
