# Processed Data

Esta pasta contém dados que foram limpos, transformados e preparados para análise.

## Diretrizes

- Dados processados são derivados dos dados brutos em `../raw/`
- Utilize scripts em `R/data_preprocessing.R` para gerar estes dados
- Mantenha rastreabilidade: documente a origem e transformações aplicadas
- Inclua metadados descrevendo as mudanças realizadas

## Tipos de Processamento

### Limpeza de Dados
- Remoção de valores faltantes
- Correção de inconsistências
- Padronização de formatos
- Detecção e tratamento de outliers

### Transformações
- Normalização e padronização
- Codificação de variáveis categóricas
- Criação de features derivadas
- Agregacções temporais ou por grupos

### Feature Engineering
- Combinação de variáveis existentes
- Criação de indicadores e flags
- Binning e discretização
- Redução de dimensionalidade

## Estrutura de Arquivos

- Use nomes descritivos que indiquem o processamento
- Inclua versão ou data: `dados_limpos_v2.rds`
- Prefixos sugeridos:
  - `clean_` - dados limpos
  - `feat_` - com feature engineering
  - `norm_` - normalizados
  - `final_` - prontos para modelagem

## Metadados Obrigatórios

Para cada arquivo, documente:
- Script utilizado para geração
- Data de processamento
- Mudanças aplicadas
- Variáveis removidas/adicionadas
- Estatísticas antes/depois
