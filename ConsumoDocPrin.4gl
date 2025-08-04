IMPORT FGL Enlace_Doc_bbl

MAIN
DEFINE
     codigoQr VARCHAR(2000)
    ,consecutivo BIGINT
    ,cufe STRING
    ,descripcionProceso STRING
    ,estadoProceso INTEGER
    ,fechaExpedicion DATETIME YEAR TO FRACTION(5)
    ,fechaFactura DATETIME YEAR TO FRACTION(5)
    ,fechaRespuesta DATETIME YEAR TO FRACTION(5)
    ,firmaDelDocumento STRING
    ,idErp STRING
    ,prefijo VARCHAR(5)
    ,selloDeValidacion STRING
    ,tipoDocumento VARCHAR(1)
DEFINE
     codigoMensaje VARCHAR(50)
    ,descripcionMensaje VARCHAR(240)
    ,rechazoNotificacion VARCHAR(2)
DEFINE
     contadorMensajes INTEGER

    -- f_CabezaDocumento_Agrega debe ser la primera función en llamar
    CALL Enlace_Doc_bbl.f_CabezaDocumento_Agrega(
        "SI" --aplicafel
       ,1 --cantidadLineas
       ,"1" --centroCostos
       ,0 --codigoPlantillaPdf
       ,"1" --codigovendedor
       ,1 --consecutivo
       ,"Pwc0mf40r1ent3" --contrasenia
       ,"descripcionCentroCostos" --descripcionCentroCostos
       ,DATETIME( 2021-07-05 15:55:55.34532 ) YEAR TO FRACTION(5) --fechafacturacion
       ,488 --idEmpresa
       ,"" --idErp
       ,"" --incoterm
       ,"nombrevendedor" --nombrevendedor
       ,"DS" --prefijo
       ,"" --sucursal
       ,"10" --tipoOperacion
       ,"7" --tipodocumento
       ,"0" --tiponota
       ,"eaab450239c82b4efb6a0a894583d7aa5ffe886c" --token
       ,"EmpCOMFAORIENTE" --usuario
       ,"11" --version
       ,"" --nombreImpresora
       ,"" --campoAdicional1
       ,"" --campoAdicional2
       ,"" --campoAdicional3
       ,"" --campoAdicional4
       ,"" --campoAdicional5
    )

    -- Este metodo se repite por cada Adquiriente
    CALL Enlace_Doc_bbl.f_Adquirente_Agrega(
        "Bosa" --barioLocalidad
       ,"Medellín" --ciudad
       ,"55" --codigoCIUU
       ,"001" --codigoCiudad
       ,"050010" --codigoPostal
       ,"05" --departamento
       ,"MEDELLÍN" --descripcionCiudad
       ,"1" --digitoverificacion
       ,"Circular 76 # 39b 80 Antioquia MEDELLÍN" --direccion
       ,"nada@nada.com" --email
       ,"Email" --envioPorEmailPlataforma
       ,"753269egsdsf" --matriculaMercantil
       ,"860028580" --nitProveedorTecnologico
       ,"Alberto de la Torre Paramo" --nombreCompleto
       ,"Antioquia" --nombredepartamento
       ,"11338854" --numeroIdentificacion
       ,"CO" --pais
       ,"Colombia" --paisnombre
       ,"100" --porcentajeParticipacion
       ,"04" --regimen
       ,"1234567890" --telefono
       ,13 --tipoIdentificacion
       ,"2" --tipoPersona
       ,"A-04" --tipoobligacion
    )

    {
    -- Este metodo se repite por cada Anticipo
    CALL Enlace_Doc_bbl.f_Anticipo_Agrega(
        0 --anticipo
       ,"" --descripcion
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fechaAnticipo
    )

    -- Este metodo se repite por cada Campo Adicional
    CALL Enlace_Doc_bbl.f_CampoAdicional_Agrega(
        DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fecha
       ,"Prueba" --nombreCampo
       ,5 --orden
       ,5 --seccion
       ,"5" --valorCampo
       ,"" --nombreSector
    )
}
{
    -- Este metodo se repite por cada Cargo
    CALL Enlace_Doc_bbl.f_Cargo_Agrega(
        "123456" --codigoCargo
       ,"sin cargo" --descripcion
       ,0 --porcentajeCargo
       ,0 --valorCargo
    )
}
{
    -- Este metodo se repite por cada Codigo de Barras
    CALL Enlace_Doc_bbl.f_CodigoBarra_Agrega(
        "Nada123456" --cadenaACodificar
       ,"Nada123456" --descripcion
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fecha
       ,1 --orden
       ,"1" --tipoCodificacion
       ,"1" --tipoModelo
    )

    -- Este metodo se repite por cada Dato de Entrega
    CALL Enlace_Doc_bbl.f_DatoEntrega_Agrega(
        1 --cantidad
       ,1000 --cantidadMaxima
       ,1 --cantidadMinima
       ,"Bogota" --ciudadEntrega
       ,"" --descripcion
       ,"" --direccionEntrega
       ,"" --empresaTransportista
       ,"abcd" --identificacionTransportista
       ,"abcd" --identificadorTransporte
       ,"" --lugarEntrega
       ,"89063059f" --nitEmpresaTransportista
       ,"Jesus Caro" --nombreTransportista
       ,"1"--numeroRadicado
       ,"3"--numeroRemesa
       ,"3"--ordenCompra
       ,"CO" --paisEntrega
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --periodoEntregaEstimado
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --periodoEntregaPrometido
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --periodoEntregaSolicitado
       ,"1234567890" --telefonoEntrega
       ,"Mañana" --tiempoRealEntrega
       ,"Carro rojo 45623" --tipoIdentificacionEmpresaTransportista
       ,0 --tipoServicio
       ,"31" --tipoidentificacionTransportista
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --ultimaFechaEntrega
       ,"mm"--unidadMedida
       ,"100"--valorFlete
       ,"DIV=CLASS12345" --dVIdentificaciontransportista
    )

    -- Este metodo se repite por cada Descuento
    CALL Enlace_Doc_bbl.f_Descuento_Agrega(
        "00" --codigoDescuento
       ,"Sin descuento" --descripcion
       ,0 --descuento
       ,0 --porcentajeDescuento
    )
}
    -- Este metodo se repite por cada Documento Adjunto
{    CALL Enlace_Doc_bbl.f_DocumentoAdjunto_Agrega(
        "C:\\Puerto\\Referencia.txt" --Ruta completa. Ruta con nombre del archivo
       ,"Referencia.txt" --nombreConExtension
    )

    -- Este metodo se repite por cada Factura Modificada
    CALL Enlace_Doc_bbl.f_FacturaModificada_Agrega(
        "1" --consecutivoFacturaModificada
       ,"" --cufeFacturaModificada
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fechaFacturaModificada
       ,"" --observacion
       ,"SETT" --prefijoFacturaModificada
       ,"1" --tipoDocumentoFacturaModificada
    )
}
{
    -- Este metodo se repite por cada Impuesto
    CALL Enlace_Doc_bbl.f_Impuesto_Agrega(
        1000.00 --baseimponible
       ,"01" --codigoImpuestoRetencion
       ,false --isAutoRetenido
       ,16 --porcentaje
       ,160 --valorImpuestoRetencion
    )
}

    -- Este metodo se repite por cada Medio de Pago
    CALL Enlace_Doc_bbl.f_MedioPago_Agrega(
        "10" --medioPago
    )
{
    -- Este metodo se repite por cada Orden de Compra
    CALL Enlace_Doc_bbl.f_OrdenCompra_Agrega(
        DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fechaemisionordencompra
       ,"123456" --numeroaceptacioninterno
       ,"123456" --ordencompra
    )
}

    CALL Enlace_Doc_bbl.f_Pagos_Agrega(
        "COP" --codigoMonedaCambio
       ,DATETIME( 2021-07-05 00:00:00.00000 ) YEAR TO FRACTION(5) --fechaTasaCambio
       ,DATETIME( 2021-07-05 00:00:00.00000 ) YEAR TO FRACTION(5) --fechavencimiento
       ,"COP" --moneda
       ,1 --pagoanticipado
       ,1 --periododepagoa
       ,1 --tipocompra
       ,1 --totalCargos
       ,1 --totalDescuento
       ,1160 --totalbaseconimpuestos
       ,1000 --totalbaseimponible
       ,1160 --totalfactura
       ,1000 --totalimportebruto
       ,1 --trm
       ,1 --trm_alterna
       ,"1" --subtotal
       ,"valorEnLetrasSubTotal" --valorEnLetrasSubTotal
       ,"" --valorAdicional1
       ,"" --valorAdicional2
       ,"" --valorAdicional3
       ,"" --valorAdicional4
       ,"" --valorAdicional5
       ,"" --valorEnLetras1
       ,"" --valorEnLetras2
       ,"" --valorEnLetras3
       ,"" --valorEnLetras4
       ,"" --valorEnLetras5
       ,"" --redondeoTotalFactura
    )
 {   
    CALL f_Esquema_Agrega(
        "Texto"--esquema
        ,"Texto"--nombreSector
    )

    CALL f_Esquema_CampoAdicional_Agrega(
        "2020-03-24 10:15" --fecha
        ,"Texto" --nombreCampo
        ,123 --orden
        ,123 --seccion
        ,"Texto" --valorCampo
        ,"Texto" --nombreSector
    )
}
    ---------------------------------------------------------------------
    -- Inica seccion detalle. f_DetalleDocumento_Agrega debe ser la primera función de la sección
    -- Esta seccion se repite por cada Detalle
    CALL Enlace_Doc_bbl.f_DetalleDocumento_Agrega(
        "no" --aplicaMandato
       ,"" --campoAdicional1
       ,"" --campoAdicional2
       ,"" --campoAdicional3
       ,"" --campoAdicional4
       ,"" --campoAdicional5
       ,1 --cantidad
       ,"86101705" --codigoproducto
       ,"Servicio de administarción de pensiones" --descripcion
       ,"" --familia
       ,DATETIME( 2021-07-05 00:00:00.00000 ) YEAR TO FRACTION(5) --fechaSuscripcionContrato
       ,"1" --gramaje
       ,"1" --grupo
       ,"1" --marca
       ,"1" --modelo
       ,0 --muestracomercial
       ,0 --muestracomercialcodigo
       ,"CAPACITACIÓN ADMINISTRATIVA" --nombreProducto
       ,0 --posicion
       ,1000.00 --preciosinimpuestos
       ,1160.00 --preciototal
       ,"1" --referencia
       ,"1" --seriales
       ,0 --tamanio
       ,1 --tipoImpuesto
       ,"001" --tipocodigoproducto
       ,"ATT" --unidadmedida
       ,1000.00 --valorunitario
       ,100 --porcentajeParticipacion
    )
{
    -- Este metodo se repite por cada Campo Adicional de Detalle
    CALL Enlace_Doc_bbl.f_CampoAdicional_Detalle_Agrega(
        DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fecha
       ,"Prueba" --nombreCampo
       ,0 --orden
       ,0 --seccion
       ,"0" --valorCampo
       ,"" --nombreSector
    )
}
{
    -- Este metodo se repite por cada Cargo de Detalle
    CALL Enlace_Doc_bbl.f_Cargo_Detalle_Agrega(
        "00" --codigoCargo
       ,"Prueba" --descripcion
       ,0 --porcentajeCargo
       ,0 --valorCargo
    )
}
{
    -- Este metodo se repite por cada Codigo de Barra de Detalle
    CALL Enlace_Doc_bbl.f_CodigoBarra_Detalle_Agrega(
        "prueba" --cadenaACodificar
       ,"" --descripcion
       ,DATETIME( 2000-01-01 00:00:00.00000 ) YEAR TO FRACTION(5) --fecha
       ,0 --orden
       ,"" --tipoCodificacion
       ,"prueba" --tipoModelo
    )
}
{
    -- Este metodo se repite por cada Descuento de Detalle
    CALL Enlace_Doc_bbl.f_Descuento_Detalle_Agrega(
        "00" --codigoDescuento
       ,"Sin descuento" --descripcion
       ,0 --descuento
       ,0 --porcentajeDescuento
    )
}

    -- Este metodo se repite por cada Impuesto de Detalle
    CALL Enlace_Doc_bbl.f_Impuesto_Detalle_Agrega(
        1000.00 --baseimponible
       ,"01" --codigoImpuestoRetencion
       ,false --isAutoRetenido
       ,16 --porcentaje
       ,160 --valorImpuestoRetencion
    )
{
    -- Este metodo se repite por cada Mandante de Detalle
    CALL Enlace_Doc_bbl.f_Mandante_Detalle_Agrega(
        "Medellín" --ciudad
       ,"05" --departamento
       ,"" --descripcionContrato
       ,"8" --digitoVerificacion
       ,"Cra 79a #78 - 55" --direccion
       ,"123456789" --identificacionMandante
       ,"Nombre" --nombreMandante
       ,"" --numeroContrato
       ,"CO" --pais
       ,"" --tipoContrato
       ,"" --tipoEstablecimiento
       ,"31" --tipoIdentificacionMandante
       ,"" --tipoObligacion
       ,"" --tipoPersona
       ,"" --tipoRepresentacion
       ,"" --zonaPostal
       ,"" --porcentajeParticipacion
    )
}
    -- Termina seccion detalle
    ---------------------------------------------------------------------


    CALL Enlace_Doc_bbl.f_RespuestaEnvio_Recupera()
        RETURNING      codigoQr
            ,consecutivo
            ,cufe
            ,descripcionProceso
            ,estadoProceso
            ,fechaExpedicion
            ,fechaFactura
            ,fechaRespuesta
            ,firmaDelDocumento
            ,idErp
            ,prefijo
            ,selloDeValidacion
            ,tipoDocumento
    
    DISPLAY "Respuesta Protocolo: ", sqlca.sqlerrm
    DISPLAY "Respuesta Proceso: ", descripcionProceso

    FOR contadorMensajes = 1 TO Enlace_Doc_bbl.f_MensajesProceso_Conteo()

        CALL Enlace_Doc_bbl.f_MensajesProceso_Recupera(contadorMensajes)
            RETURNING
             codigoMensaje
            ,descripcionMensaje
            ,rechazoNotificacion

        DISPLAY "Mensaje: ", descripcionMensaje
        
    END FOR


END MAIN

