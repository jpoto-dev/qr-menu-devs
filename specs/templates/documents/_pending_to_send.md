Datasource: bf_o
Data transformation:
1. filter by 'dte_estado_envio' where is equal to 1
2. pick distincts ('dte_tipo', 'dte_folio')
3. group by 'dte_tipo' and count
Table:
* use transformed data
* table title 'Documentos por enviar por tipo'
* sum as total the count
* 'dte_tipo' as 'Tipo' in table header
* 'count' as 'Cantidad' in table header
