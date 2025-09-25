Datasource: bf_nc_o
Data transformation:
1. filter by 'nc_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
2. filter by 'bf_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
3. pick distincts 'bf_tipo', 'bf_folio', 'bf_total', 'nc_folio', 'nc_total'
4. filter where 'nc_total' > 'bf_total'; cast types to integer if it's needed
Table:
* use the transformed data
* Title 'Validacion notas de credito'
* column headers 'bf_tipo' as 'Tipo de documento', 'bf_folio' as 'Folio DTE', 'nc_folio' as 'Folio nota de credito', 'bf_total' as 'Total DTE', 'nc_total' as 'Total nota de credito', 'nc_total - bf_total' as 'Diferencia' 