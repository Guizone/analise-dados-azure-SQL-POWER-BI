# Etapas do projeto

| # | Etapa | Entrega | Situação |
|---|---|---|---|
| 1 | Escolher a base e confirmar a licença | Bank Marketing (UCI), CC BY 4.0 | Concluída |
| 2 | Criar o banco no Azure | Grupo de recursos, servidor e banco (oferta gratuita) | Concluída |
| 3 | Configurar a rede | Redes selecionadas, regra de firewall e exceção para serviços do Azure | Concluída |
| 4 | Importar o CSV | Tabela `dbo.bank_marketing_raw` (`sql/01_importacao_e_validacao.sql`) | Concluída |
| 5 | Validar a carga | 41.188 linhas, 4.640 conversões, 11,27% | Concluída |
| 6 | Fazer o perfil de qualidade | `sql/02_profiling.sql` | Concluída |
| 7 | Tratar os dados em uma view | `sql/03_view_bank_marketing.sql` | Concluída |
| 8 | Validar a view | `sql/04_validacao_da_view.sql` | Concluída |
| 9 | Modelar e criar o dashboard | `powerbi/Dataview_bank_marketing.pbix` (3 abas e 1 tooltip) | Concluída, com pendências (veja `docs/premissas.md`) |
| 10 | Publicar no Power BI Service com atualização agendada | n/a | A fazer (exige conta de trabalho ou escola) |
| 11 | Taxa de conversão por `poutcome` e por canal | Nova análise | A fazer |
| 12 | Modelo preditivo de conversão | Estudo | A fazer |
