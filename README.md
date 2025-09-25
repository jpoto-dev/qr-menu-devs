# qr-menu-devs

Proyecto de desarrollo de componentes para QR Menu

## Requerimientos

Notas relacionadas con la estructura de los datos.
```txt
dte_emitido: folio NULL, no se enviaron al servicio
dte_emitido: total 0 o NULL significa boleta emitida con monto 0
dte_emitido: revision_estado DTE, EPR, RPR, RLV documento valido
dte_emitido: cuando ted es NULL entonces esta pendiente por enviar
dte_emitido: orden_id es NULL implica que hay un error porque primero se genera la orden y luego la boleta
dte_emitido: es posible que hayan multiples ordenes para un dte
orden: cuando una orden tiene un dte_tipo = 33, el monto esta sin IVA
orden: el total incluye propina
```

### Documentos legales
De forma general:
- [X] Filtro de fecha
- [X] Filtro de tiendas

Componentes:
- [X] Cantidad de documentos validos emitidos por tipo en una tabla
- [X] Visualizacion de montos totales de documentos validos emitidos por dia en grafico X/Y
- [X] Segmentacion de montos por medio de pago y por tipo de documentos validos emitidos en una tabla
- [X] Segmentacion de cantidad de documentos por estado de orden y por tipo de documento valido emitido en una tabla
- [X] Documentos pendientes por enviar al SII en una tabla
- [X] Ordenes cuyos montos no coinciden con los DTE
- [X] DTE cuyos montos son inferiores a las notas de credito asociadas
- [X] Ordenes no anuladas que tienen nota de credito asociada

## Acerca del proyecto
### Dependencias
- PHP 7.2.34
- Symfony 5.2
- Apex Charts 
```html
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
```
- DataTables
```html
 <link href="https://cdn.datatables.net/v/dt/dt-2.3.4/datatables.min.css" rel="stylesheet" integrity="sha384-pmGS6IIcXhAVIhcnh9X/mxffzZNHbuxboycGuQQoP3pAbb0SwlSUUHn2v22bOenI" crossorigin="anonymous">
 
<script src="https://cdn.datatables.net/v/dt/dt-2.3.4/datatables.min.js" integrity="sha384-X2pTSfom8FUa+vGQ+DgTCSyBZYkC1RliOduHa0X96D060s7Q//fnOh3LcazRNHyo" crossorigin="anonymous"></script>
```

### Como ejecutar
En primer lugar se debe configurar `DATABASE_URL` en el archivo `.env`:
```txt
DATABASE_URL="mysql://username:password@server_url:port/database"
```

Este proyecto utiliza Docker y Docker Compose y esta estructurado para ser ejecutado como dev container.

Si no se desea utilizar como dev container, para ejecutarlo:
```bash
docker compose up -d

docker compose exec app symfony serve --allow-all-ip
```

No olvidar ejecutar `composer install` para instalar las dependencias

Para parar el servidor:
```bash
docker compose exec app symfony server:stop
```

Las siguientes rutas se encuentran disponibles en la aplicacion.
```txt
http://localhost:8000/documents
```

### Limites PHP runtime
Los limites de PHP estan configurados como siguen:
```txt
memory_limit = 512M
max_execution_time = 300
```