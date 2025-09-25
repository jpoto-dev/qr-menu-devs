Datasource: bf_o
Data transformation:
1. filter by 'dte_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
2. filter by 'dte_orden_id' where is not null
3. group by 'orden_estado', 'dte_tipo' and count
Table:
* use transformed data
* table title 'Cantidad total de ordenes por estado por tipo de documento'
* use 'orden_estado' as row headers
* use 'dte_tipo' as column headers
* use count as cell value
* add an additional row to sum values per 'dte_tipo'
* add an additional column to sum values per 'orden_estado'