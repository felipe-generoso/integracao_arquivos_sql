# integracao_arquivos_sql

Especificação resumida:

Aplicável a projetos de: Database Marketing / ETL / EDIs.

Integração automatizada dos dados originários dos arquivos da pasta do projeto: "Arquivos de exemplo": Pessoas e Pedidos.

Frequência de integração a cada 24 horas (schedule às 07 da manhã) via Job.

O projeto inclui:

Job e Procedures de integração com:
  - Validação de email
  - Validação de dados básicos
  - Log da rodada de integração 

Visão consolidada onde é possível filtrar:
  - Pessoas que compram mais de 1x nos últimos 12 meses
  - Pessoas em níveis de comportamento de compra (tier)
  - Pessoas que fazem aniversário no mês
  - Por região e cidade
  - Por faixa de compra
  - Por tempo médio de compras
  - Por LTV

Schema básico de tabelas:

Tabela CLIENTES:

- ID
- EMAIL
- NOME
- DATA_NASCIMENTO
- SEXO
- DATA_CADASTRO_SISTEMAORIGEM
- CIDADE
- UF
- PERMISSAO_RECEBE_EMAIL (1: Recebe // 0: não recebe)

Tabela PEDIDOS:

- ID_CLIENTE
- ID_PEDIDO
- ID_PRODUTO
- DEPARTAMENTO
- QUANTIDADE
- VALOR_UNITARIO
- PARCELAS
- DATA_PEDIDO
- MEIO_PAGAMENTO
- STATUS_PAGAMENTO

Tabela CONS_RFV (Calculada)

- DATA_ULTIMA_COMPRA
- ULTIMO_DEPTO_COMPRA / último departamento comprado
- PARCELAMENTO_PREFER / parcelamento mais praticado
- MEIO_PAGAMENTO_PREFER / meio de pagamento mais praticado
- TICKET_MEDIO_ALL / ticket médio total
- TICKET_MEDIO_12M / ticket médio últimos 12 meses
- FREQUENCIA_COMPRA_ALL / frequência de compra total
- FREQUENCIA_COMPRA_12M / frequência de compra últimos 12 meses
- TIER_ATUAL / tipo de cliente (ouro, prata, etc)

Tabela TIERS (valor comprado)

- até 1000  / Cliente básico
- 1000 a 2000 / Cliente Prata
- 2000 a 5000 / Cliente Ouro
- 5000+ / Cliente Super

Tabela LOG DE RODADAS

- ID_RODADA / Sequencial da rodada
- DATA_RODADA / Timestamp da rodada do JOB
- TABELA / Qual tabela o log está referenciando (clientes ou pedidos)
- QUANTIDADE_ALTERADO / Quantidade de registros alterados na rodada
- QUANTIDADE_INSERIDO / Quantidade de registros inseridos na rodada

Demais observações para execução do projeto:

1) Os scripts estão nomeados na pasta com a ordem numérica que deverão ser executados.
2) Deverão ser criados os diretórios: "C:\PMITG\CLIENTES" e "C:\PMITG\PEDIDOS" para a integração dos arquivos.
3) A rotina não processa arquivos do mesmo nome, que já foram processados anteriormente.
4) Os scripts foram criados por objetos e em arquivos separados para ficar mais claro o entendimento e organização.
