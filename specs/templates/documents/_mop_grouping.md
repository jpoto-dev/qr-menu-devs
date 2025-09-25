Datasource: bf_o
Data transformation:
1. filter by 'dte_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
2. filter by 'dte_orden_id' where is not null
3. pick unique 'dte', 'dte_folio', 'dte_total'
4. group by 'orden_medio_pago', 'dte_tipo' and sum 'dte_total'
Table:
* use transformed data
* table title 'Total medios de pago por tipo de documento'
* use 'orden_medio_pago' as row headers
* use 'dte_tipo' as column headers
* use 'orden_total' as cell value
* add an additional row to sum values per 'dte_tipo'
* add an additional column to sum values per 'orden_medio_pago'
* show the values as currency ($) using browser locale for thousands separator