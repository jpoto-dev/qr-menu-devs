# qr-menu-devs

## Dependencias
- PHP 7.2.34
- Symfony 5.2
- symfony/webpack-encore-bundle
- apexcharts 
```html
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
```
- datatables
```html
```



## DTE, ordenes, notas de credito
### Sabana de datos
- [x] Boletas/facturas X Ordenes
```sql
SELECT 
	DTE.id AS dte_id, 
	DTE.orden_id AS dte_orden_id, 
	DTE.fecha AS dte_fecha,
	DTE.dte AS dte_tipo_id,
	CASE
		WHEN DTE.dte = 33 THEN 'FACTURA ELECTRONICA'
		WHEN DTE.dte = 39 THEN 'BOLETA ELECTRONICA'
		WHEN DTE.dte = 41 THEN 'BOLETA ELECTRONICA EXENTA'
		WHEN DTE.dte = 56 THEN 'NOTA DE DEBITO ELECTRONICA'
		WHEN DTE.dte = 61 THEN 'NOTA DE CREDITO ELECTRONICA'
		WHEN DTE.dte = 33 THEN 'FACTURA ELECTRONICA'
	END AS dte_tipo,
	DTE.folio AS dte_folio, 
	DTE.exento AS dte_exento, 
	DTE.neto AS dte_neto, 
	DTE.iva AS dte_iva, 
	DTE.total AS dte_total, 
	DTE.revision_estado AS dte_revision_estado,
	DTE.revision_detalle AS dte_revision_detalle,
	DTE.anulado AS dte_anulado,
	DTE.deleted AS dte_deleted,
	O.id AS orden_id,
	O.tienda_id AS orden_tienda_id,
	O.created AS orden_fecha,
	O.medio_pago AS orden_medio_pago, 
	O.estado AS orden_estado, 
	O.dte AS orden_dte, 
	O.dte_folio AS orden_dte_folio, 
	O.dte_tipo AS orden_dte_tipo, 
	O.dte_status AS orden_dte_status,
	O.monto AS orden_monto,
	O.descuento AS orden_descuento,
	O.total AS orden_total,
	O.propina AS orden_propina,
	O.garzon_id AS orden_garzon_id
FROM dte_emitido as DTE
LEFT JOIN orden AS O ON 
	O.tienda_id IN (@tiendas)
	AND DTE.orden_id = O.id 
WHERE 1=1
	AND DTE.tienda_id IN (@tiendas)
	AND (DTE.fecha >= @fecha_inicio)
	AND (DTE.fecha < @fecha_fin)
ORDER BY 
	DTE.fecha ASC
;
```
- [x] Boletas/facturas X Notas de credito X Ordenes
```sql
SELECT 
	DTE.id AS bf_id,
	DTE.tienda_id AS bf_tienda_id,
	DTE.dte AS bf_tipo_id,
	DTE.folio AS bf_folio,
	DTE.exento AS bf_exento,
	DTE.neto AS bf_neto,
	DTE.iva AS bf_iva,
	DTE.total AS bf_total,
	DTE.fecha AS bf_fecha,
	DTE.revision_estado AS bf_revision_estado,
	DTE.revision_detalle AS bf_revision_detalle,
	DTER.dte AS ref_dte,
	DTER.tienda_id AS nc_tienda_id,
	DTER.folio AS nc_folio,
	DTERV.fecha AS nc_fecha,
	DTERV.exento AS nc_exento,
	DTERV.neto AS nc_neto,
	DTERV.iva AS nc_iva,
	DTERV.total AS nc_total,
	DTERV.revision_estado AS nc_revision_estado,
	DTERV.revision_detalle AS nc_revision_detalle,
	O.id AS orden_id,
	O.tienda_id AS orden_tienda_id,
	O.estado AS orden_estado
FROM dte_emitido AS DTE
INNER JOIN dte_referencia AS DTER ON 
	DTER.tienda_id IN (@tiendas)
	AND DTE.folio = DTER.referencia_folio  
	AND DTE.dte = DTER.referencia_dte
INNER JOIN dte_emitido AS DTERV ON 
	DTERV.tienda_id IN (@tiendas)
	AND DTER.dte = DTERV.dte 
	AND DTER.folio = DTERV.folio
LEFT JOIN orden AS O ON 
	O.tienda_id IN (@tiendas)
	AND DTE.orden_id = O.id 	
WHERE 1=1
	AND DTE.tienda_id in (@tiendas)
	AND DTER.dte = 61
	AND (DTERV.fecha >= @fecha_inicio)
	AND (DTERV.fecha < @fecha_fin)
ORDER BY 
	DTERV.fecha ASC
;
```
### Requerimientos
- [ ] Filtro de fecha
- [ ] Filtro de tiendas
- [ ] Cantidad de documentos emitidos en una tabla
- [ ] Documentos por tipo en una tabla
- [ ] Visualizacion de totales en grafico X/Y
- [ ] Segmentacion por medio de pago en una tabla
- [ ] Segmentacion por status de venta en una tabla (aprobadas, rechazadas; desde tabla de ordenes)
- [ ] Documentos pendientes de enviar al SII en una tabla (desde tabla DTE emitido)
- [ ] Tabla con Boletas/Facturas cuyos montos con la orden no sean iguales
- [ ] Tabla con Notas de Credito cuyo monto sea superior a la del documento a acreditar
- [ ] Tabla con Boletas/Facturas que tengan Nota de Credito igual al monto y no se encuentren en estado anulada

## Comandos utiles
```bash
docker compose up -d

docker compose exec app symfony serve --allow-all-ip

docker compose exec app symfony server:stop
```