Datasource: bf_o
Data transformation:
1. filter by 'dte_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
2. filter by 'dte_total' where is not null or is greater than 0
3. pick distincts ('dte_created', 'dte_tipo', 'dte_folio', 'dte_total')
Chart:
* use transformed data
* chart title 'Total de documentos enviados por dia y por tipo'
* use X/Y chart where X is days in format dd-mm-yyyy and Y is an integer value using $ currency symbol and thousands separator format from the browser configuration
* X is got from 'dte_created'
* Y is the sum of 'dte_total' per day
* Y label is 'Montos'
* create one serie per 'dte_tipo'
* use stacked bars