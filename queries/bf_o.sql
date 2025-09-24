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
	O.tienda_id IN (:tiendas)
	AND DTE.orden_id = O.id 
WHERE 1=1
	AND DTE.tienda_id IN (:tiendas)
	AND (DTE.fecha >= :fecha_inicio)
	AND (DTE.fecha < :fecha_fin)
ORDER BY 
	DTE.fecha ASC
;