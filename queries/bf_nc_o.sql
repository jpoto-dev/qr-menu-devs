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
	DTER.tienda_id IN (:tiendas)
	AND DTE.folio = DTER.referencia_folio  
	AND DTE.dte = DTER.referencia_dte
INNER JOIN dte_emitido AS DTERV ON 
	DTERV.tienda_id IN (:tiendas)
	AND DTER.dte = DTERV.dte 
	AND DTER.folio = DTERV.folio
LEFT JOIN orden AS O ON 
	O.tienda_id IN (:tiendas)
	AND DTE.orden_id = O.id 	
WHERE 1=1
	AND DTE.tienda_id in (:tiendas)
	AND DTER.dte = 61
	AND (DTERV.fecha >= :fecha_inicio)
	AND (DTERV.fecha < :fecha_fin)
ORDER BY 
	DTERV.fecha ASC