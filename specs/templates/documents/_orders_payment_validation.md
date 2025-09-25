Datasource: bf_o
Data schema notes:
* datasheet source query './queries/bf_o.sql'
* 'dte_emitido' references an 'orden' in field 'orden_id'
* there is no reference of 'dte_emitido' from 'orden'
* in consequence, there is no join table (many to many)
* 'dte_emitido' represents a legal voucher which is created when a payment is approved
* 'orden' represents a purchase order or "the bill" previous to the payment
* it's allowed to make full payment (one voucher, one order), split payment (one order, multiple vouchers), and bulk payment (multiple orders, one voucher)
Expected output:
* filter by 'dte_orden_id' where is not null
* filter by 'dte_revision_estado' where is not null and starts with DTE, EPR, RPR, or RLV
* three different tables named 'Validacion pago completo de orden', 'Validacion pago separado de orden', 'Validacion pago multiples ordenes'
* on each table, show what are the 'orden_id', 'dte_folio' which don't match the total ('dte_total') of the 'orden_id' total, which is computed by substracting the tip from the total ('orden_total' - 'orden_propina')
* to avoid any issue regarding data types, transform the values to integer