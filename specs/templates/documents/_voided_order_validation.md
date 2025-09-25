Datasource: bf_nc_o
Data transformation:
1. filter by 'nc_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
2. filter by 'bf_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
3. pick uniques 'bf_tipo', 'bf_folio', 'bf_total', 'nc_folio', 'nc_total', 'orden_id', 'orden_estado', 'orden_total'
4. filter where 'bf_total' = 'nc_total' and 'nc_total' = 'orden_total'
5. lower case 'orden_estado'
6. filter by 'orden_estado' where doesn't contain 'anulado' substring
Table:
* use transformed data
* title 'Ordenes acreditadas pero no anuladas'
* column headers 'orden_id' as 'Orden', 'bf_tipo' as 'Tipo DTE', 'bf_folio' as 'Folio DTE', 'nc_folio' as 'Folio nota de credito' 