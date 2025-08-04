#+ Envio de documento a Dispapeles
#+
#+ Enlace con servicio web de Dispapeles para
#+ el envio de un documento de factura electrónica

IMPORT FGL DispapelesDoc

GLOBALS "DispapelesDoc.inc"
GLOBALS
DEFINE
 indice_Adquirentes INTEGER
,indice_Anticipo INTEGER
,indice_CamposAdicionales INTEGER
,indice_CamposAdicionales_salud INTEGER
,indice_Cargos INTEGER
,indice_CodigoBarras INTEGER
,indice_DatosEntrega INTEGER
,indice_Descuentos INTEGER
,indice_Detalle_CamposAdicionales INTEGER
,indice_Detalle_Cargos INTEGER
,indice_Detalle_CodigoBarras INTEGER
,indice_Detalle_Descuentos INTEGER
,indice_Detalle_Impuestos INTEGER
,indice_Detalle_Mandantes INTEGER
,indice_Detalle INTEGER
,indice_DocumentosAdjuntos INTEGER
,indice_FacturasModificadas INTEGER
,indice_Impuestos INTEGER
,indice_MediosPagos INTEGER
,indice_OrdenesCompras INTEGER
,indice_MensajesProceso INTEGER
,indice_cabeza INTEGER
,indice_Esquema INTEGER
,indice_Esquema_CamposAdicionales INTEGER

,indice_errores INTEGER


END GLOBALS

#+ Agregar Adquirente
#+
#+ LISTA DE ADQUIRENTES O CLIENTES QUE COMPRAN ASOCIADOS A LA FACTURA.
#+
#+ @code
#+ CALL f_Adquirente_Agrega(
#+     "Texto"--barioLocalidad
#+    ,"Texto"--ciudad
#+    ,"Texto"--codigoCIUU
#+    ,"Texto"--codigoCiudad
#+    ,"Texto"--codigoPostal
#+    ,"Texto"--departamento
#+    ,"Texto"--descripcionCiudad
#+    ,"Texto"--digitoverificacion
#+    ,"Texto"--direccion
#+    ,"Texto"--email
#+    ,"Texto"--envioPorEmailPlataforma
#+    ,"Texto"--matriculaMercantil
#+    ,"Texto"--nitProveedorTecnologico
#+    ,"Texto"--nombreCompleto
#+    ,"Texto"--nombredepartamento
#+    ,"Texto"--numeroIdentificacion
#+    ,"Texto"--pais
#+    ,"Texto"--paisnombre
#+    ,123--porcentajeParticipacion
#+    ,"Texto"--regimen
#+    ,"Texto"--telefono
#+    ,123--tipoIdentificacion
#+    ,"Texto"--tipoPersona
#+    ,"Texto"--tipoobligacion
#+ )
#+
#+ @param barioLocalidad BARRIO DEL CLIENTE
#+ @param ciudad (OBLIGATORIO) CIUDAD DE RESIDENCIA DEL CLIENTE. EL CAMPO CIUDAD DEBE RECIBIR EL CODIGO DEL MUNICIPIO SEGÚN TABLA DEL DANE. VER TABLA ANEXA SUB-REGIONES DANE.
#+ @param codigoCIUU CODIGO CIIU DEL ADQUIRENTE
#+ @param codigoCiudad
#+ @param codigoPostal CODIGO POSTAL
#+ @param departamento (OBLIGATORIO) DEPARTAMENTO DE RESIDENCIA DEL CLIENTE. EL CAMPO DEPARTAMENTO DEBE RECIBIR EL CODIGO DEL MUNICIPIO SEGÚN TABLA DEL DANE. VER TABLA ANEXA SUB-REGIONES DANE.
#+ @param descripcionCiudad NOMBRE DESCRIPTIVO DE LA CIUDAD
#+ @param digitoverificacion DÍGITO DE VERIFICACIÓN DEL DOCUMENTO DE IDENTIDAD. SE HACE OBLIGATORIO CUANDO EL TIPODOCUMENTO ES NIT.
#+ @param direccion (OBLIGATORIO) DIRECCIÓN DEL CLIENTE
#+ @param email CORREO ELECTRÓNICO DEL CLIENTE. ESTE CAMPO SE VUELVE OBLIGATORIO SI EL CAMPO APLICAFEL ES “SI” Y ENVIOPOREMAILPLATAFORMA ES EMAIL
#+ @param envioPorEmailPlataforma SI APLICA FEL ES SI, DEBE INDICAR SI EL ENVÍO SE HARÁ AL EMAIL O POR PLATAFORMA TECNOLÓGICA. SI NO SE CARGA CON LAS VARIABLES EMAIL O PLATAFORMA NO SE TRANSMITIRÁ EL DOCUMENTO.
#+ @param matriculaMercantil NUMERO DE MATRICULA MERCANTIL ASOCIADA AL PREFIJO.
#+ @param nitProveedorTecnologico NIT DEL PROVEEDOR TECNOLOGICO. ESTE CAMPO ES OBLIGATORIO SI envioPorEmailPlataforma ES PLATAFORMA
#+ @param nombreCompleto (OBLIGATORIO) CONCATENACIÓN DE NOMBRES Y APELLIDOS. SI NO SE TIENEN LOS NOMBRE Y APELLIDOS POR SEPARADOS SE PUEDE ENVIAR SOLO ESTE CAMPO. SI LA PERSONA ES JURIDICA, EN ESTE CAMPO SE AGREGA LA RAZON SOCIAL.
#+ @param nombredepartamento NOMBRE DEL DEPARTAMENTO
#+ @param numeroIdentificacion (OBLIGATORIO) NÚMERO DEL DOCUMENTO DE IDENTIFICACIÓN SIN DIGITO DE VERIFICACION EN CASO DEL NIT, SIN CARACTERES ESPECIALES
#+ @param pais (OBLIGATORIO) PAIS CLIENTE EN ESTÁNDAR ISO 3116-1, ES DECIR COLOMBIA "CO"
#+ @param paisnombre NOMBRE DEL PAÍS RELACIONADO CON EL CÓDIGO ENVIADO
#+ @param regimen 04. SIMPLE 05. ORDINARIO
#+ @param telefono TELÉFONO DEL CLIENTE
#+ @param tipoIdentificacion (OBLIGATORIO) VER EN LA SECCION DE TABLAS -> TIPO DE DOCUMENTO DE IDENTIFICACIÓN
#+ @param tipoPersona (OBLIGATORIO) TIPO DE PERSONA, 1. PERSONA JURÍDICA, 2. PERSONA NATURAL
#+ @param tipoobligacion CODIGO DE LA OBLIGACIÓN CUANDO EL TIPO DE IDENTIFICACIÓN ES NIT. VER TABLA RESPONSABILIDADES FISCALES. SI LA EMPRESA TIENE MAS DE UN TIPO DE OBLIGACIÓN, DEBERÁN IR SEPARADOS POR PUNTO Y COMA “;”. GENERA RECHAZO SI SE ENVÍA UN VALOR DIFERENTE DE LA TABLA DE RESPONSABILIDADES FISCALES.
#+
#+ @return Sin regreso
#+
FUNCTION f_Adquirente_Agrega(
     barioLocalidad
    ,ciudad
    ,codigoCIUU
    ,codigoCiudad
    ,codigoPostal
    ,departamento
    ,descripcionCiudad
    ,digitoverificacion
    ,direccion
    ,email
    ,envioPorEmailPlataforma
    ,matriculaMercantil
    ,nitProveedorTecnologico
    ,nombreCompleto
    ,nombredepartamento
    ,numeroIdentificacion
    ,pais
    ,paisnombre
    ,porcentajeParticipacion
    ,regimen
    ,telefono
    ,tipoIdentificacion
    ,tipoPersona
    ,tipoobligacion
)
DEFINE
     barioLocalidad VARCHAR(50)
    ,ciudad VARCHAR(50)
    ,codigoCIUU VARCHAR(30)
    ,codigoCiudad VARCHAR(30)
    ,codigoPostal VARCHAR(6)
    ,departamento VARCHAR(50)
    ,descripcionCiudad VARCHAR(100)
    ,digitoverificacion VARCHAR(2)
    ,direccion VARCHAR(100)
    ,email VARCHAR(200)
    ,envioPorEmailPlataforma VARCHAR(10)
    ,matriculaMercantil VARCHAR(60)
    ,nitProveedorTecnologico VARCHAR(30)
    ,nombreCompleto VARCHAR(240)
    ,nombredepartamento VARCHAR(50)
    ,numeroIdentificacion VARCHAR(30)
    ,pais VARCHAR(2)
    ,paisnombre VARCHAR(30)
    ,porcentajeParticipacion FLOAT
    ,regimen VARCHAR(240)
    ,telefono VARCHAR(50)
    ,tipoIdentificacion INTEGER
    ,tipoPersona VARCHAR(1)
    ,tipoobligacion VARCHAR(30)

    CALL Val_cabeza()

    LET indice_Adquirentes = indice_Adquirentes + 1
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].barioLocalidad = barioLocalidad
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].ciudad = ciudad
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].codigoCIUU = codigoCIUU
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].codigoCiudad = codigoCiudad
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].codigoPostal = codigoPostal
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].departamento = departamento
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].descripcionCiudad = descripcionCiudad
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].digitoverificacion = digitoverificacion
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].direccion = direccion
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].email = email
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].envioPorEmailPlataforma = envioPorEmailPlataforma
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].matriculaMercantil = matriculaMercantil
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].nitProveedorTecnologico = nitProveedorTecnologico
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].nombreCompleto = nombreCompleto
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].nombredepartamento = nombredepartamento
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].numeroIdentificacion = numeroIdentificacion
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].pais = pais
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].paisnombre = paisnombre
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].porcentajeParticipacion = porcentajeParticipacion
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].regimen = regimen
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].telefono = telefono
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].tipoIdentificacion = tipoIdentificacion
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].tipoPersona = tipoPersona
    LET enviarDocumento.felCabezaDocumento.listaAdquirentes[indice_Adquirentes].tipoobligacion = tipoobligacion

END FUNCTION

#+ Agregar Anticipo
#+
#+ ESTRUCTURA QUE DETALLA CADA ANTICIPO ASOCIADO A LA FACTURA
#+
#+ @code
#+ CALL f_Anticipo_Agrega(
#+     123.12--anticipo
#+    ,"Texto"--descripcion
#+    ,"2020-03-24 10:15"--fechaAnticipo
#+ )
#+
#+ @param anticipo (OBLIGATORIO) VALOR DE UN ANTICIPO DE LA FACTURA
#+ @param descripcion DESCRIPCIONES ASOCIADAS A LA ENTREGA COMO REFERENCIA
#+ @param fechaAnticipo FECHA DE UNO DE LOS ANTICIPOS
#+
#+ @return Sin regreso
#+
FUNCTION f_Anticipo_Agrega(
     anticipo
    ,descripcion
    ,fechaAnticipo
)
DEFINE
     anticipo FLOAT
    ,descripcion STRING
    ,fechaAnticipo DATETIME YEAR TO FRACTION(5)

    CALL Val_cabeza()

    LET indice_Anticipo = indice_Anticipo + 1
    LET enviarDocumento.felCabezaDocumento.listaAnticipo[indice_Anticipo].anticipo = anticipo
    LET enviarDocumento.felCabezaDocumento.listaAnticipo[indice_Anticipo].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaAnticipo[indice_Anticipo].fechaAnticipo = fechaAnticipo

END FUNCTION

#+ Agregar CampoAdicional
#+
#+ LISTA QUE ALMACENA UNO O VARIOS ELEMENTOS CON ASOCIACIÓN CAMPO VALOR PARA MANEJAR CAMPOS NO TENIDOS EN CUENTA EN EL ESTÁNDAR UBL2.1 DEFINIDO POR LA DIAN. ESTE CAMPO HACE PARTE DE LOS CAMBIOS POR EL NUEVO MODELO
#+
#+ @code
#+ CALL f_CampoAdicional_Agrega(
#+     "2020-03-24 10:15" --fecha
#+    ,"Texto" --nombreCampo
#+    ,123 --orden
#+    ,123 --seccion
#+    ,"Texto" --valorCampo
#+    ,"Texto" --nombreSector
#+ )
#+
#+ @param fecha FECHA DE REFERENCIA ASOCIADA AL CAMPO NECESARIO PARA MOSTRAR EN LA REPRESENTACIÓN GRÁFICA
#+ @param nombreCampo DESCRIPCION DEL VALOR ALMACENADO. PARA EL MANEJO DE LAS NOTAS DE LA DIAN, COLOCAR EL CONCEPTO DESCRIPCION
#+ @param orden ORDEN EN EL QUE SE PRESENTARÁ LA INFORMACIÓN, DA UNA JERARQUIA AL MOMENTO DE PINTAR EL DATO
#+ @param seccion GRUPO DE DATOS ADICIONALES QUE SIRVE PARA SABER UNA DETERMINADA POSICIÓN EN LA QUE SE QUIERA REPRESENTAR LA INFORMACIÓN EN EL PDF
#+ @param valorCampo VALOR DEL CAMPO ADICIONAL INDICADO
#+ @param nombreSector NOMBRE DEL SECTOR DE LA EMPRESA
#+
#+ @return Sin regreso
#+
FUNCTION f_CampoAdicional_Agrega(
     fecha
    ,nombreCampo
    ,orden
    ,seccion
    ,valorCampo
    ,nombreSector
)
DEFINE
     fecha DATETIME YEAR TO FRACTION(5)
    ,nombreCampo VARCHAR(50)
    ,orden INTEGER
    ,seccion INTEGER
    ,valorCampo VARCHAR(800)
    ,nombreSector VARCHAR(240)

    CALL Val_cabeza()

    LET indice_CamposAdicionales = indice_CamposAdicionales + 1
    LET enviarDocumento.felCabezaDocumento.listaCamposAdicionales[indice_CamposAdicionales].fecha = fecha
    LET enviarDocumento.felCabezaDocumento.listaCamposAdicionales[indice_CamposAdicionales].nombreCampo = nombreCampo
    LET enviarDocumento.felCabezaDocumento.listaCamposAdicionales[indice_CamposAdicionales].orden = orden
    LET enviarDocumento.felCabezaDocumento.listaCamposAdicionales[indice_CamposAdicionales].seccion = seccion
    LET enviarDocumento.felCabezaDocumento.listaCamposAdicionales[indice_CamposAdicionales].valorCampo = valorCampo
    LET enviarDocumento.felCabezaDocumento.listaCamposAdicionales[indice_CamposAdicionales].nombreSector = nombreSector

END FUNCTION

#+ Agregar Cargo
#+
#+ LISTADO DE CARGOS ASOCIADOS A LA FACTURA
#+
#+ @code
#+ CALL f_Cargo_Agrega(
#+     "Texto"--codigoCargo
#+    ,"Texto"--descripcion
#+    ,123.12--porcentajeCargo
#+    ,123.12--valorCargo
#+ )
#+
#+ @param codigoCargo CÓDIGO INTERNO QUE MANEJA LA EMPRESA PARA ESE CARGO. AÚN LA DIAN NO DEFINE CODIGOS ESTÁNDAR
#+ @param descripcion DESCRIPCIÓN DEL CARGO APLICADO A LA FACTURA
#+ @param porcentajeCargo PORCENTAJE DEL CARGO
#+ @param valorCargo (OBLIGATORIO) INDICA SI ES UN CARGO O UN DESCUENTO APLICADO A LA FACTURA
#+
#+ @return Sin regreso
#+
FUNCTION f_Cargo_Agrega(
     codigoCargo
    ,descripcion
    ,porcentajeCargo
    ,valorCargo
)
DEFINE
     codigoCargo VARCHAR(2)
    ,descripcion VARCHAR(240)
    ,porcentajeCargo FLOAT
    ,valorCargo FLOAT

    CALL Val_cabeza()

    LET indice_Cargos = indice_Cargos + 1
    LET enviarDocumento.felCabezaDocumento.listaCargos[indice_Cargos].codigoCargo = codigoCargo
    LET enviarDocumento.felCabezaDocumento.listaCargos[indice_Cargos].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaCargos[indice_Cargos].porcentajeCargo = porcentajeCargo
    LET enviarDocumento.felCabezaDocumento.listaCargos[indice_Cargos].valorCargo = valorCargo

END FUNCTION

#+ Agregar CodigoBarra
#+
#+ LISTADO DE LOS CÓDIGOS DE BARRAS
#+
#+ @code
#+ CALL f_CodigoBarra_Agrega(
#+     "Texto"--cadenaACodificar
#+    ,"Texto"--descripcion
#+    ,"2020-03-24 10:15"--fecha
#+    ,123--orden
#+    ,"Texto"--tipoCodificacion
#+    ,"Texto"--tipoModelo
#+ )
#+
#+ @param cadenaACodificar (OBLIGATORIO) CADENA PARA LA GENERACIÓN DEL CÓDIGO DE BARRAS, VER LAS ESPECIFICACIONES PARA EL ENVÍO DEL CÓDIGO DE BARRAS DE RECAUDO. SI LA LISTA DE CODIGO DE BARRAS TIENE MAS DE UN ITEM ESTE VALOR SE HACE OBLIGATORIO PARA EL PT.
#+ @param descripcion NOTA ASOCIADA AL CÓDIGO DE BARRAS
#+ @param fecha FECHA DE REFERENCIA ASOCIADA AL CAMPO NECESARIO PARA MOSTRAR EN LA REPRESENTACIÓNGRÁFICA
#+ @param orden ORDEN EN EL QUE SE MOSTRARÁ CADA CÓDIGO EN LA REPRESENTACIÓN GRÁFICA
#+ @param tipoCodificacion INDICA SI ES EAN, UPC U OTRA VERSIÓN. POR DEFECTO SE USARÁ EL EAN128
#+ @param tipoModelo (OBLIGATORIO) MODELO DE CÓDIGO QUE SE IMPLEMENTARÁ AL INTERIOR DE DISPAPELES. DISPAPELES INDICARÁ ESTE VALOR PARA QUE SEA ENVIADO POR EL FACTURADOR DE ACUERDO CON SU NECESIDAD. SI LA LISTA DE CODIGO DE BARRAS TIENE MAS DE UN ITEM ESTE VALOR SE HACE OBLIGATORIO PARA EL PT.
#+
#+ @return Sin regreso
#+
FUNCTION f_CodigoBarra_Agrega(
     cadenaACodificar
    ,descripcion
    ,fecha
    ,orden
    ,tipoCodificacion
    ,tipoModelo
)
DEFINE
     cadenaACodificar VARCHAR(255)
    ,descripcion VARCHAR(255)
    ,fecha DATETIME YEAR TO FRACTION(5)
    ,orden INTEGER
    ,tipoCodificacion VARCHAR(255)
    ,tipoModelo VARCHAR(255)

    CALL Val_cabeza()

    LET indice_CodigoBarras = indice_CodigoBarras + 1
    LET enviarDocumento.felCabezaDocumento.listaCodigoBarras[indice_CodigoBarras].cadenaACodificar = cadenaACodificar
    LET enviarDocumento.felCabezaDocumento.listaCodigoBarras[indice_CodigoBarras].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaCodigoBarras[indice_CodigoBarras].fecha = fecha
    LET enviarDocumento.felCabezaDocumento.listaCodigoBarras[indice_CodigoBarras].orden = orden
    LET enviarDocumento.felCabezaDocumento.listaCodigoBarras[indice_CodigoBarras].tipoCodificacion = tipoCodificacion
    LET enviarDocumento.felCabezaDocumento.listaCodigoBarras[indice_CodigoBarras].tipoModelo = tipoModelo

END FUNCTION

#+ Agregar DatoEntrega
#+
#+ LISTADO DE INFORMACIÓN QUE PERMITE HACER LA ENTREGA DE LA MERCANCÍA
#+
#+ @code
#+ CALL f_DatoEntrega_Agrega(
#+     123456789--cantidad
#+    ,123456789--cantidadMaxima
#+    ,123456789--cantidadMinima
#+    ,"Texto"--ciudadEntrega
#+    ,"Texto"--descripcion
#+    ,"Texto"--direccionEntrega
#+    ,"Texto"--empresaTransportista
#+    ,"Texto"--identificacionTransportista
#+    ,"Texto"--identificadorTransporte
#+    ,"Texto"--lugarEntrega
#+    ,"Texto"--nitEmpresaTransportista
#+    ,"Texto"--nombreTransportista
#+    ,"Texto"--numeroRadicado
#+    ,"Texto"--numeroRemesa
#+    ,"Texto"--ordenCompra
#+    ,"Texto"--paisEntrega
#+    ,"2020-03-24 10:15"--periodoEntregaEstimado
#+    ,"2020-03-24 10:15"--periodoEntregaPrometido
#+    ,"2020-03-24 10:15"--periodoEntregaSolicitado
#+    ,"Texto"--telefonoEntrega
#+    ,"Texto"--tiempoRealEntrega
#+    ,"Texto"--tipoIdentificacionEmpresaTransportista
#+    ,0 --tipoServicio
#+    ,"Texto"--tipoidentificacionTransportista
#+    ,"2020-03-24 10:15"--ultimaFechaEntrega
#+    ,"Texto"--unidadMedida
#+    ,"Texto"--valorFlete
#+    ,"Texto"--dVIdentificaciontransportista
#+ )
#+
#+ @param cantidad (OBLIGATORIO) CANTIDAD POR TRANSPORTAR
#+ @param cantidadMaxima (OBLIGATORIO) CANTIDAD MAXIMA POR TRANSPORTAR
#+ @param cantidadMinima (OBLIGATORIO) CANTIDAD MÍNIMA POR TRANSPORTAR
#+ @param ciudadEntrega CIUDA DE ENTREGA
#+ @param descripcion DESCRIPCIONES ASOCIADAS A LA ENTREGA COMO REFERENCIA
#+ @param direccionEntrega DIRECCION DE ENTREGA
#+ @param empresaTransportista EMPRESA TRANSPORTISTA
#+ @param identificacionTransportista (OBLIGATORIO) NÚMERO DEL DOCUMENTO DE IDENTIFICACIÓN SIN DIGITO DE VERIFICACION EN CASO DEL NIT, SIN CARACTERES ESPECIALES
#+ @param identificadorTransporte (OBLIGATORIO) PLACA DEL VEHÍCULO
#+ @param lugarEntrega LUGAR DE ENTREGA
#+ @param nitEmpresaTransportista NIT DE LA EMPRESA TRANSPORTISTA
#+ @param nombreTransportista NOMBRE TRANSPORTISTA
#+ @param numeroRadicado
#+ @param numeroRemesa
#+ @param ordenCompra
#+ @param paisEntrega (OBLIGATORIO) PAIS CLIENTE EN ESTÁNDAR ISO 3116-1, ES DECIR COLOMBIA "CO"
#+ @param periodoEntregaEstimado PERIODO DE ENTREGA ESTIMADO
#+ @param periodoEntregaPrometido PERIODO DE ENTREGA PROMETIDO
#+ @param periodoEntregaSolicitado PERIODO DE ENTREGA SOLICITADO
#+ @param telefonoEntrega TELEFONO DE ENTREGA
#+ @param tiempoRealEntrega TIEMPO REAL DE ENTREGA
#+ @param tipoIdentificacionEmpresaTransportista TIPO DE IDENTIFICACION DE LA EMPRESA TRANSPORTISTA
#+ @param tipoServicio
#+ @param tipoidentificacionTransportista (OBLIGATORIO) VER EN LA SECCION DE TABLAS -> TIPO DE DOCUMENTO DE IDENTIFICACIÓN
#+ @param ultimaFechaEntrega ULTIMA FECHA DE ENTREGA
#+ @param unidadMedida
#+ @param valorFlete
#+ @param dVIdentificaciontransportista (OBLIGATORIO) DIGITO DE VERIFICACIÓN DE LA IDENTIFICACIÓN, SE REQUIERE OBLIGATORIO CUANDO EL TIPO DE IDENTIFICACION DEL TRANSPORTISTA ES 31 (NIT)
#+
#+ @return Sin regreso
#+
FUNCTION f_DatoEntrega_Agrega(
     cantidad
    ,cantidadMaxima
    ,cantidadMinima
    ,ciudadEntrega
    ,descripcion
    ,direccionEntrega
    ,empresaTransportista
    ,identificacionTransportista
    ,identificadorTransporte
    ,lugarEntrega
    ,nitEmpresaTransportista
    ,nombreTransportista
    ,numeroRadicado
    ,numeroRemesa
    ,ordenCompra
    ,paisEntrega
    ,periodoEntregaEstimado
    ,periodoEntregaPrometido
    ,periodoEntregaSolicitado
    ,telefonoEntrega
    ,tiempoRealEntrega
    ,tipoIdentificacionEmpresaTransportista
    ,tipoServicio
    ,tipoidentificacionTransportista
    ,ultimaFechaEntrega
    ,unidadMedida
    ,valorFlete
    ,dVIdentificaciontransportista
)
DEFINE
     cantidad BIGINT
    ,cantidadMaxima BIGINT
    ,cantidadMinima BIGINT
    ,ciudadEntrega STRING
    ,descripcion STRING
    ,direccionEntrega STRING
    ,empresaTransportista STRING
    ,identificacionTransportista STRING
    ,identificadorTransporte STRING
    ,lugarEntrega STRING
    ,nitEmpresaTransportista STRING
    ,nombreTransportista STRING
    ,numeroRadicado STRING
    ,numeroRemesa STRING
    ,ordenCompra STRING
    ,paisEntrega STRING
    ,periodoEntregaEstimado DATETIME YEAR TO FRACTION(5)
    ,periodoEntregaPrometido DATETIME YEAR TO FRACTION(5)
    ,periodoEntregaSolicitado DATETIME YEAR TO FRACTION(5)
    ,telefonoEntrega STRING
    ,tiempoRealEntrega STRING
    ,tipoIdentificacionEmpresaTransportista STRING
    ,tipoServicio INTEGER
    ,tipoidentificacionTransportista STRING
    ,ultimaFechaEntrega DATETIME YEAR TO FRACTION(5)
    ,unidadMedida STRING
    ,valorFlete FLOAT
    ,dVIdentificaciontransportista STRING

    CALL Val_cabeza()

    LET indice_DatosEntrega = indice_DatosEntrega + 1
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].cantidad = cantidad
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].cantidadMaxima = cantidadMaxima
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].cantidadMinima = cantidadMinima
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].ciudadEntrega = ciudadEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].direccionEntrega = direccionEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].empresaTransportista = empresaTransportista
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].identificacionTransportista = identificacionTransportista
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].identificadorTransporte = identificadorTransporte
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].lugarEntrega = lugarEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].nitEmpresaTransportista = nitEmpresaTransportista
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].nombreTransportista = nombreTransportista
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].numeroRadicado = numeroRadicado
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].numeroRemesa = numeroRemesa
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].ordenCompra = ordenCompra
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].paisEntrega = paisEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].periodoEntregaEstimado = periodoEntregaEstimado
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].periodoEntregaPrometido = periodoEntregaPrometido
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].periodoEntregaSolicitado = periodoEntregaSolicitado
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].telefonoEntrega = telefonoEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].tiempoRealEntrega = tiempoRealEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].tipoIdentificacionEmpresaTransportista = tipoIdentificacionEmpresaTransportista
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].tipoServicio = tipoServicio
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].tipoidentificacionTransportista = tipoidentificacionTransportista
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].ultimaFechaEntrega = ultimaFechaEntrega
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].unidadMedida = unidadMedida
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].valorFlete = valorFlete
    LET enviarDocumento.felCabezaDocumento.listaDatosEntrega[indice_DatosEntrega].dVIdentificaciontransportista = dVIdentificaciontransportista

END FUNCTION

#+ Agregar Descuento
#+
#+ LISTADO DE DESCUENTOS ASOCIADOS A LA FACTURA
#+
#+ @code
#+ CALL f_Descuento_Agrega(
#+     "Texto"--codigoDescuento
#+    ,"Texto"--descripcion
#+    ,123.12--descuento
#+    ,123.12--porcentajeDescuento
#+ )
#+
#+ @param codigoDescuento CÓDIGO QUE IDENTIFICA EL TIPO DE DESCUENTO
#+ @param descripcion DESCRIPCIÓN DEL DESCUENTO
#+ @param descuento (OBLIGATORIO) VALOR DEL DESCUENTO
#+ @param porcentajeDescuento (OBLIGATORIO) PORCENTAJE DEL DESCUENTO
#+
#+ @return Sin regreso
#+
FUNCTION f_Descuento_Agrega(
     codigoDescuento
    ,descripcion
    ,descuento
    ,porcentajeDescuento
)
DEFINE
     codigoDescuento VARCHAR(2)
    ,descripcion VARCHAR(240)
    ,descuento FLOAT
    ,porcentajeDescuento FLOAT

    CALL Val_cabeza()

    LET indice_Descuentos = indice_Descuentos + 1
    LET enviarDocumento.felCabezaDocumento.listaDescuentos[indice_Descuentos].codigoDescuento = codigoDescuento
    LET enviarDocumento.felCabezaDocumento.listaDescuentos[indice_Descuentos].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaDescuentos[indice_Descuentos].descuento = descuento
    LET enviarDocumento.felCabezaDocumento.listaDescuentos[indice_Descuentos].porcentajeDescuento = porcentajeDescuento

END FUNCTION

#+ Agregar CampoAdicional_Detalle
#+
#+ LISTA QUE ALMACENA UNO O VARIOS ELEMENTOS CON ASOCIACIÓN CAMPO VALOR PARA MANEJAR CAMPOS NO TENIDOS EN CUENTA EN EL ESTÁNDAR UBL2.1 DEFINIDO POR LA DIAN. ESTE CAMPO HACE PARTE DE LOS CAMBIOS POR EL NUEVO MODELO.
#+
#+ @code
#+ CALL f_CampoAdicional_Detalle_Agrega(
#+     "2020-03-24 10:15" --fecha
#+    ,"Texto" --nombreCampo
#+    ,123 --orden
#+    ,123 --seccion
#+    ,"Texto" --valorCampo
#+    ,"Texto" --nombreSector
#+ )
#+
#+ @param fecha FECHA DE REFERENCIA ASOCIADA AL CAMPO NECESARIO PARA MOSTRAR EN LA REPRESENTACIÓN GRÁFICA
#+ @param nombreCampo DESCRIPCION DEL VALOR ALMACENADO. PARA EL MANEJO DE LAS NOTAS DE LA DIAN, COLOCAR EL CONCEPTO DESCRIPCION
#+ @param orden ORDEN EN EL QUE SE PRESENTARÁ LA INFORMACIÓN, DA UNA JERARQUIA AL MOMENTO DE PINTAR EL DATO
#+ @param seccion GRUPO DE DATOS ADICIONALES QUE SIRVE PARA SABER UNA DETERMINADA POSICIÓN EN LA QUE SE QUIERA REPRESENTAR LA INFORMACIÓN EN EL PDF
#+ @param valorCampo VALOR DEL CAMPO ADICIONAL INDICADO
#+ @param nombreSector NOMBRE DEL SECTOR DE LA EMPRESA
#+
#+ @return Sin regreso
#+
FUNCTION f_CampoAdicional_Detalle_Agrega(
     fecha
    ,nombreCampo
    ,orden
    ,seccion
    ,valorCampo
    ,nombreSector
)
DEFINE
     fecha DATETIME YEAR TO FRACTION(5)
    ,nombreCampo VARCHAR(50)
    ,orden INTEGER
    ,seccion INTEGER
    ,valorCampo VARCHAR(800)
    ,nombreSector VARCHAR(240)

    CALL Val_detalle()

    LET indice_Detalle_CamposAdicionales = indice_Detalle_CamposAdicionales + 1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCamposAdicionales[indice_Detalle_CamposAdicionales].fecha = fecha
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCamposAdicionales[indice_Detalle_CamposAdicionales].nombreCampo = nombreCampo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCamposAdicionales[indice_Detalle_CamposAdicionales].orden = orden
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCamposAdicionales[indice_Detalle_CamposAdicionales].seccion = seccion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCamposAdicionales[indice_Detalle_CamposAdicionales].valorCampo = valorCampo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCamposAdicionales[indice_Detalle_CamposAdicionales].nombreSector = nombreSector

END FUNCTION

#+ Agregar Cargo_Detalle
#+
#+ LISTADO DE CARGOS ASOCIADOS A LA FACTURA
#+
#+ @code
#+ CALL f_Cargo_Detalle_Agrega(
#+     "Texto"--codigoCargo
#+    ,"Texto"--descripcion
#+    ,123.12--porcentajeCargo
#+    ,123.12--valorCargo
#+ )
#+
#+ @param codigoCargo CÓDIGO INTERNO QUE MANEJA LA EMPRESA PARA ESE CARGO. AÚN LA DIAN NO DEFINE CODIGOS ESTÁNDAR
#+ @param descripcion DESCRIPCIÓN DEL CARGO APLICADO A LA FACTURA
#+ @param porcentajeCargo PORCENTAJE DEL CARGO
#+ @param valorCargo (OBLIGATORIO) INDICA SI ES UN CARGO O UN DESCUENTO APLICADO A LA FACTURA
#+
#+ @return Sin regreso
#+
FUNCTION f_Cargo_Detalle_Agrega(
     codigoCargo
    ,descripcion
    ,porcentajeCargo
    ,valorCargo
)
DEFINE
     codigoCargo VARCHAR(2)
    ,descripcion VARCHAR(240)
    ,porcentajeCargo FLOAT
    ,valorCargo FLOAT

    CALL Val_detalle()

    LET indice_Detalle_Cargos = indice_Detalle_Cargos + 1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCargos[indice_Detalle_Cargos].codigoCargo = codigoCargo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCargos[indice_Detalle_Cargos].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCargos[indice_Detalle_Cargos].porcentajeCargo = porcentajeCargo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCargos[indice_Detalle_Cargos].valorCargo = valorCargo

END FUNCTION

#+ Agregar CodigoBarra_Detalle
#+
#+ LISTA TODOS LOS CÓDIGOS DE BARRA ASOCIADOS A UN PRODUCTO
#+
#+ @code
#+ CALL f_CodigoBarra_Detalle_Agrega(
#+     "Texto"--cadenaACodificar
#+    ,"Texto"--descripcion
#+    ,"2020-03-24 10:15"--fecha
#+    ,123--orden
#+    ,"Texto"--tipoCodificacion
#+    ,"Texto"--tipoModelo
#+ )
#+
#+ @param cadenaACodificar (OBLIGATORIO) CADENA PARA LA GENERACIÓN DEL CÓDIGO DE BARRAS, VER LAS ESPECIFICACIONES PARA EL ENVÍO DEL CÓDIGO DE BARRAS DE RECAUDO. SI LA LISTA DE CODIGO DE BARRAS TIENE MAS DE UN ITEM ESTE VALOR SE HACE OBLIGATORIO PARA EL PT.
#+ @param descripcion NOTA ASOCIADA AL CÓDIGO DE BARRAS
#+ @param fecha FECHA DE REFERENCIA ASOCIADA AL CAMPO NECESARIO PARA MOSTRAR EN LA REPRESENTACIÓNGRÁFICA
#+ @param orden ORDEN EN EL QUE SE MOSTRARÁ CADA CÓDIGO EN LA REPRESENTACIÓN GRÁFICA
#+ @param tipoCodificacion INDICA SI ES EAN, UPC U OTRA VERSIÓN. POR DEFECTO SE USARÁ EL EAN128
#+ @param tipoModelo (OBLIGATORIO) MODELO DE CÓDIGO QUE SE IMPLEMENTARÁ AL INTERIOR DE DISPAPELES. DISPAPELES INDICARÁ ESTE VALOR PARA QUE SEA ENVIADO POR EL FACTURADOR DE ACUERDO CON SU NECESIDAD. SI LA LISTA DE CODIGO DE BARRAS TIENE MAS DE UN ITEM ESTE VALOR SE HACE OBLIGATORIO PARA EL PT.
#+
#+ @return Sin regreso
#+
FUNCTION f_CodigoBarra_Detalle_Agrega(
     cadenaACodificar
    ,descripcion
    ,fecha
    ,orden
    ,tipoCodificacion
    ,tipoModelo
)
DEFINE
     cadenaACodificar VARCHAR(255)
    ,descripcion VARCHAR(255)
    ,fecha DATETIME YEAR TO FRACTION(5)
    ,orden INTEGER
    ,tipoCodificacion VARCHAR(255)
    ,tipoModelo VARCHAR(255)

    CALL Val_detalle()

    LET indice_Detalle_CodigoBarras = indice_Detalle_CodigoBarras + 1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCodigoBarras[indice_Detalle_CodigoBarras].cadenaACodificar = cadenaACodificar
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCodigoBarras[indice_Detalle_CodigoBarras].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCodigoBarras[indice_Detalle_CodigoBarras].fecha = fecha
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCodigoBarras[indice_Detalle_CodigoBarras].orden = orden
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCodigoBarras[indice_Detalle_CodigoBarras].tipoCodificacion = tipoCodificacion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaCodigoBarras[indice_Detalle_CodigoBarras].tipoModelo = tipoModelo

END FUNCTION

#+ Agregar Descuento_Detalle
#+
#+ LISTA DE DESCUENTOS ASOCIADOS AL PRODUCTO POR LÍNEA DE DETALLE
#+
#+ @code
#+ CALL f_Descuento_Detalle_Agrega(
#+     "Texto"--codigoDescuento
#+    ,"Texto"--descripcion
#+    ,123.12--descuento
#+    ,123.12--porcentajeDescuento
#+ )
#+
#+ @param codigoDescuento CÓDIGO QUE IDENTIFICA EL TIPO DE DESCUENTO
#+ @param descripcion DESCRIPCIÓN DEL DESCUENTO
#+ @param descuento (OBLIGATORIO) VALOR DEL DESCUENTO
#+ @param porcentajeDescuento (OBLIGATORIO) PORCENTAJE DEL DESCUENTO
#+
#+ @return Sin regreso
#+
FUNCTION f_Descuento_Detalle_Agrega(
     codigoDescuento
    ,descripcion
    ,descuento
    ,porcentajeDescuento
)
DEFINE
     codigoDescuento VARCHAR(2)
    ,descripcion VARCHAR(240)
    ,descuento FLOAT
    ,porcentajeDescuento FLOAT

    CALL Val_detalle()

    LET indice_Detalle_Descuentos = indice_Detalle_Descuentos + 1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaDescuentos[indice_Detalle_Descuentos].codigoDescuento = codigoDescuento
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaDescuentos[indice_Detalle_Descuentos].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaDescuentos[indice_Detalle_Descuentos].descuento = descuento
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaDescuentos[indice_Detalle_Descuentos].porcentajeDescuento = porcentajeDescuento

END FUNCTION

#+ Agregar Impuesto_Detalle
#+
#+ LISTA DE LOS IMPUESTOS Y/O RETENCIONES ASOCIADOS AL DETALLE. SI EL PRODUCTO O SERVICIO ES EXCLUIDO NO SE HACE OBLIGATORIO ESTE VALOR.
#+
#+ @code
#+ CALL f_Impuesto_Detalle_Agrega(
#+     123.12--baseimponible
#+    ,"Texto"--codigoImpuestoRetencion
#+    ,NULL--isAutoRetenido
#+    ,123.12--porcentaje
#+    ,123.12--valorImpuestoRetencion
#+ )
#+
#+ @param baseimponible (OBLIGATORIO) BASE IMPONIBLE SOBRE LA QUE SE CALCULA LA RETENCIÓN O IMPUESTO. TENER EN CUENTA QUE ESTE VALOR DEBE TENER DESCUENTOS INCLUIDOS
#+ @param codigoImpuestoRetencion (OBLIGATORIO) CÓDIGO DEL IMPUESTO O RETENCIÓN. VER NUEVA TABLA DE IMPUESTOS EN LA SECCIÓN TABLAS.
#+ @param isAutoRetenido (OBLIGATORIO) INDICA SI LO QUE SE REPORTA ES IMPUESTO O RETENCIÓN. VALORES POSIBLES: TRUE (ES RETENCIÓN), FALSE (ES IMPUESTO)
#+ @param porcentaje (OBLIGATORIO) PORCENTAJE DE IMPUESTO O RETENCIÓN A APLICAR
#+ @param valorImpuestoRetencion (OBLIGATORIO) VALOR DEL IMPUESTO O RETENCIÓN A APLICAR
#+
#+ @return Sin regreso
#+
FUNCTION f_Impuesto_Detalle_Agrega(
     baseimponible
    ,codigoImpuestoRetencion
    ,isAutoRetenido
    ,porcentaje
    ,valorImpuestoRetencion
)
DEFINE
     baseimponible FLOAT
    ,codigoImpuestoRetencion VARCHAR(2)
    ,isAutoRetenido BOOLEAN
    ,porcentaje FLOAT
    ,valorImpuestoRetencion FLOAT

    CALL Val_detalle()

    LET indice_Detalle_Impuestos = indice_Detalle_Impuestos + 1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaImpuestos[indice_Detalle_Impuestos].baseimponible = baseimponible
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaImpuestos[indice_Detalle_Impuestos].codigoImpuestoRetencion = codigoImpuestoRetencion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaImpuestos[indice_Detalle_Impuestos].isAutoRetenido = isAutoRetenido
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaImpuestos[indice_Detalle_Impuestos].porcentaje = porcentaje
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaImpuestos[indice_Detalle_Impuestos].valorImpuestoRetencion = valorImpuestoRetencion

END FUNCTION

#+ Agregar Mandante_Detalle
#+
#+ LISTA DE LOS MANDANTES ASOCIADOS A LA FACTURA. APLICA SOLO SI EL CAMPO aplicaMandato ES IGUAL A SI
#+
#+ @code
#+ CALL f_Mandante_Detalle_Agrega(
#+     "Texto"--ciudad
#+    ,"Texto"--departamento
#+    ,"Texto"--descripcionContrato
#+    ,"Texto"--digitoVerificacion
#+    ,"Texto"--direccion
#+    ,"Texto"--identificacionMandante
#+    ,"Texto"--nombreMandante
#+    ,"Texto"--numeroContrato
#+    ,"Texto"--pais
#+    ,"Texto"--tipoContrato
#+    ,"Texto"--tipoEstablecimiento
#+    ,"Texto"--tipoIdentificacionMandante
#+    ,"Texto"--tipoObligacion
#+    ,"Texto"--tipoPersona
#+    ,"Texto"--tipoRepresentacion
#+    ,"Texto"--zonaPostal
#+    ,123.45 --porcentajeParticipacion
#+ )
#+
#+ @param ciudad CIUDAD DE RESIDENCIA DEL CLIENTE. EL CAMPO CIUDAD DEBE RECIBIR EL CODIGO DEL MUNICIPIO SEGÚN TABLA DEL DANE. VER TABLA ANEXA SUB-REGIONES DANE
#+ @param departamento DEPARTAMENTO DE RESIDENCIA DEL CLIENTE. EL CAMPO DEPARTAMENTO DEBE RECIBIR EL CODIGO DEL MUNICIPIO SEGÚN TABLA DEL DANE. VER TABLA ANEXA SUB-REGIONES DANE
#+ @param descripcionContrato DESCRIPCIÓN DEL CONTRATO DE MANDATO
#+ @param digitoVerificacion (OBLIGATORIO) SI LA FACTURA MANEJA MANDANTE, SE DEBE AGREGAR ESTE VALOR DE MANERA OBLIGATORIA. OBLIGATORIO SOLO SI TIPO IDENTIFICACIÓN ES NIT
#+ @param direccion DIRECCIÓN MANDANTE
#+ @param identificacionMandante (OBLIGATORIO) IDENTIFICACIÓN MANDANTE
#+ @param nombreMandante NOMBRE DEL MANDANTE
#+ @param numeroContrato NUMERO DE CONTRATO DE MANDATO
#+ @param pais PAIS CLIENTE EN ESTÁNDAR ISO 3116-1, ES DECIR COLOMBIA "CO"
#+ @param tipoContrato TIPO DE CONTRATO DE MANDATO
#+ @param tipoEstablecimiento TIPO DE ESTABLECIMIENTO
#+ @param tipoIdentificacionMandante (OBLIGATORIO) VER EN LA SECCION DE TABLAS -> TIPO DE DOCUMENTO DE IDENTIFICACIÓN
#+ @param tipoObligacion CODIGO DE LA OBLIGACIÓN CUANDO EL TIPO DE IDENTIFICACIÓN ES NIT. VER TABLA RESPONSABILIDADES FISCALES. SI LA EMPRESA TIENE MAS DE UN TIPO DE OBLIGACIÓN, DEBERÁN IR SEPARADOS POR PUNTO Y COMA “;”
#+ @param tipoPersona TIPO DE PERSONA, 1. PERSONA JURÍDICA, 2. PERSONA NATURAL 
#+ @param tipoRepresentacion PENDIENTE DEFINICIÓN DIAN
#+ @param zonaPostal CODIGO POSTAL
#+ @param porcentajeParticipacion APLICA PARA CONSORCIOS Y UNIONES TEMPORALES
#+
#+ @return Sin regreso
#+
FUNCTION f_Mandante_Detalle_Agrega(
     ciudad
    ,departamento
    ,descripcionContrato
    ,digitoVerificacion
    ,direccion
    ,identificacionMandante
    ,nombreMandante
    ,numeroContrato
    ,pais
    ,tipoContrato
    ,tipoEstablecimiento
    ,tipoIdentificacionMandante
    ,tipoObligacion
    ,tipoPersona
    ,tipoRepresentacion
    ,zonaPostal
    ,porcentajeParticipacion
)
DEFINE
     ciudad VARCHAR(100)
    ,departamento VARCHAR(100)
    ,descripcionContrato VARCHAR(240)
    ,digitoVerificacion VARCHAR(2)
    ,direccion VARCHAR(100)
    ,identificacionMandante VARCHAR(30)
    ,nombreMandante VARCHAR(200)
    ,numeroContrato VARCHAR(100)
    ,pais VARCHAR(2)
    ,tipoContrato VARCHAR(100)
    ,tipoEstablecimiento VARCHAR(20)
    ,tipoIdentificacionMandante STRING
    ,tipoObligacion VARCHAR(30)
    ,tipoPersona VARCHAR(1)
    ,tipoRepresentacion VARCHAR(20)
    ,zonaPostal VARCHAR(30)
    ,porcentajeParticipacion FLOAT

    CALL Val_detalle()

    LET indice_Detalle_Mandantes = indice_Detalle_Mandantes + 1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].ciudad = ciudad
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].departamento = departamento
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].descripcionContrato = descripcionContrato
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].digitoVerificacion = digitoVerificacion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].direccion = direccion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].identificacionMandante = identificacionMandante
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].nombreMandante = nombreMandante
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].numeroContrato = numeroContrato
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].pais = pais
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].tipoContrato = tipoContrato
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].tipoEstablecimiento = tipoEstablecimiento
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].tipoIdentificacionMandante = tipoIdentificacionMandante
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].tipoObligacion = tipoObligacion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].tipoPersona = tipoPersona
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].tipoRepresentacion = tipoRepresentacion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].zonaPostal = zonaPostal
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].listaMandantes[indice_Detalle_Mandantes].porcentajeParticipacion = porcentajeParticipacion

END FUNCTION

#+ Agregar DetalleDocumento
#+
#+ LISTA QUE ALMACENA LOS DETALLES DE PRODUCTOS Y/O SERVICIOS
#+
#+ @code
#+ CALL f_DetalleDocumento_Agrega(
#+     "Texto"--aplicaMandato
#+    ,"Texto"--campoAdicional1
#+    ,"Texto"--campoAdicional2
#+    ,"Texto"--campoAdicional3
#+    ,"Texto"--campoAdicional4
#+    ,"Texto"--campoAdicional5
#+    ,123.12--cantidad
#+    ,"Texto"--codigoproducto
#+    ,"Texto"--descripcion
#+    ,"Texto"--familia
#+    ,"2020-03-24 10:15"--fechaSuscripcionContrato
#+    ,"Texto"--gramaje
#+    ,"Texto"--grupo
#+    ,"Texto"--marca
#+    ,"Texto"--modelo
#+    ,123--muestracomercial
#+    ,123--muestracomercialcodigo
#+    ,"Texto"--nombreProducto
#+    ,123--posicion
#+    ,123.12--preciosinimpuestos
#+    ,123.12--preciototal
#+    ,"Texto"--referencia
#+    ,"Texto"--seriales
#+    ,123.12--tamanio
#+    ,123--tipoImpuesto
#+    ,"Texto"--tipocodigoproducto
#+    ,"Texto"--unidadmedida
#+    ,123.12--valorunitario
#+    ,123.12--valorUnitarioPorCantidad
#+ )
#+
#+ @param aplicaMandato INDICA SI EL PRODUCTO O SERVICIO MANEJA MANDATO O NO. LOS VALORES SON ‘SI’ O ‘NO’
#+ @param campoAdicional1 
#+ @param campoAdicional2 
#+ @param campoAdicional3 
#+ @param campoAdicional4 
#+ @param campoAdicional5 
#+ @param cantidad (OBLIGATORIO) CANTIDAD DEL PRODUCTO, POR DEFECTO DEBE ENVIARSE EL VALOR UNO “1”, EL VALOR DEBE SER SIEMPRE MAYOR A CERO
#+ @param codigoproducto (OBLIGATORIO) CÓDIGO DEL PRODUCTO O SERVICIO
#+ @param descripcion INFORMACIÓN DESCRIPTIVA DEL PRODUCTO
#+ @param familia FAMILIA AL QUE PERTENECE EL PRODUCTO
#+ @param fechaSuscripcionContrato 
#+ @param gramaje PESO EN GRAMOS
#+ @param grupo GRUPO AL QUE PERTENECE EL PRODUCTO
#+ @param marca MARCA DEL PRODUCTO
#+ @param modelo MODELO DEL PRODUCTO
#+ @param muestracomercial INDICA SI ES UNA MUESTRA COMERCIAL O UN REGALO. LOS VALORES SON “MUESTRA=1, REGALO=2”. ESTE CAMPO ES OBLIGATORIO SI EL CLIENTE MANEJA REGALOS A NIVEL DE DETALLE. INDEPENDIENTE DE LA OPCION QUE SE ESCOJA, SIEMPRE SE DEBE ENVIAR EL VALOR COMERCIAL DEL PRODUCTO, AUNQUE ESTE NO SUMA AL VALOR TOTAL DE LA FACTURA.
#+ @param muestracomercialcodigo ESTE CAMPO ES OBLIGATORIO SI HAY MUESTRA COMERCIAL. LOS CODIGOS ACEPTADOS SON: 1. VALOR COMERCIAL, 2. VALOR EN INVENTARIOS, 3. OTRO VALOR
#+ @param nombreProducto (OBLIGATORIO) NOMBRE DEL PRODUCTO O SERVICIO
#+ @param posicion VALOR PARA RESPETAR EL ORDEN ASIGNADO POR EL ERP
#+ @param preciosinimpuestos (OBLIGATORIO) VALOR SIN IMPUESTOS. (CANTIDAD X VALOR UNITARIO – DESCUENTO +CARGOS)
#+ @param preciototal (OBLIGATORIO)VALOR TOTAL A PAGAR POR EL/LOS PRODUCTOS POR LA LÍNEA DE DETALLE. FORMULA (CANTIDAD X VALOR UNITARIO – DESCUENTO +CARGOS) +IMPUESTOS.
#+ @param referencia REFERENCIA O GRUPO DEL PRODUCTO
#+ @param seriales SERIALES REGISTRADOS
#+ @param tamanio TAMAÑO
#+ @param tipoImpuesto (OBLIGATORIO) GRAVADO=1, EXCLUIDO=2, EXENTO=3. SI NO SE ENVÍA POR DEFECTO SE CARGARÁ EL VALOR COMO GRAVADO
#+ @param tipocodigoproducto (OBLIGATORIO) INDICA QUE CÓDIGO DEL ESTÁNDAR DEL PRODUCTO. 001: COLOMBIA COMPRA EFICIENTE. 010: NÚMEROS GLOBALES DE IDENTIFICACIÓN DE PRODUCTOS – GTIN. 020: PARTIDA ARANCELARIA. 999: ESTÁNDAR DE ADOPCIÓN DEL CONTRIBUYENTE
#+ @param unidadmedida (OBLIGATORIO) UNIDAD DE MEDIDA QUE MANEJA EL FACTURADOR. SE DEBE USAR LOS VALORES DESCRITOS EN LA TABLA 6.3.6. DEL DOCUMENTO ADJUNTO ANEXO%20TÉCNICO%20DE%20FACTURA%20ELECTRÓNICA.PDF.
#+ @param valorunitario (OBLIGATORIO) VALOR UNITARIO DEL PRODUCTO O SERVICIO. ES EL VALOR COMERCIAL DEL PRODUCTO SIN APLICAR IMPUESTOS NI DESCUENTOS. EL VALOR DEBE SER MAYOR A CERO.
#+ @param valorUnitarioPorCantidad ESTE CAMPO NO ES EXIGIDO POR LA DIAN, ES UN COMODÍN PARA CLIENTES QUE QUIERAN VER ESTA INFORMACIÓN EN SU REPRESENTACIÓN GRÁFICA
#+
#+ @return Sin regreso
#+
FUNCTION f_DetalleDocumento_Agrega(
     aplicaMandato
    ,campoAdicional1
    ,campoAdicional2
    ,campoAdicional3
    ,campoAdicional4
    ,campoAdicional5
    ,cantidad
    ,codigoproducto
    ,descripcion
    ,familia
    ,fechaSuscripcionContrato
    ,gramaje
    ,grupo
    ,marca
    ,modelo
    ,muestracomercial
    ,muestracomercialcodigo
    ,nombreProducto
    ,posicion
    ,preciosinimpuestos
    ,preciototal
    ,referencia
    ,seriales
    ,tamanio
    ,tipoImpuesto
    ,tipocodigoproducto
    ,unidadmedida
    ,valorunitario
    ,valorUnitarioPorCantidad
)
DEFINE
     aplicaMandato VARCHAR(2)
    ,campoAdicional1 STRING
    ,campoAdicional2 STRING
    ,campoAdicional3 STRING
    ,campoAdicional4 STRING
    ,campoAdicional5 STRING
    ,cantidad FLOAT
    ,codigoproducto VARCHAR(30)
    ,descripcion VARCHAR(240)
    ,familia VARCHAR(240)
    ,fechaSuscripcionContrato DATETIME YEAR TO FRACTION(5)
    ,gramaje VARCHAR(800)
    ,grupo VARCHAR(240)
    ,marca VARCHAR(240)
    ,modelo VARCHAR(240)
    ,muestracomercial INTEGER
    ,muestracomercialcodigo INTEGER
    ,nombreProducto VARCHAR(240)
    ,posicion INTEGER
    ,preciosinimpuestos FLOAT
    ,preciototal FLOAT
    ,referencia VARCHAR(100)
    ,seriales VARCHAR(800)
    ,tamanio FLOAT
    ,tipoImpuesto INTEGER
    ,tipocodigoproducto VARCHAR(30)
    ,unidadmedida VARCHAR(5)
    ,valorunitario FLOAT
    ,valorUnitarioPorCantidad FLOAT

    CALL Val_cabeza()

    LET indice_Detalle = indice_Detalle + 1
    LET indice_Detalle_CamposAdicionales = 0
    LET indice_Detalle_Cargos = 0
    LET indice_Detalle_CodigoBarras = 0
    LET indice_Detalle_Descuentos = 0
    LET indice_Detalle_Impuestos = 0
    LET indice_Detalle_Mandantes = 0

    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].aplicaMandato = aplicaMandato
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].campoAdicional1 = campoAdicional1
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].campoAdicional2 = campoAdicional2
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].campoAdicional3 = campoAdicional3
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].campoAdicional4 = campoAdicional4
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].campoAdicional5 = campoAdicional5
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].cantidad = cantidad
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].codigoproducto = codigoproducto
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].descripcion = descripcion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].familia = familia
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].fechaSuscripcionContrato = fechaSuscripcionContrato
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].gramaje = gramaje
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].grupo = grupo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].marca = marca
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].modelo = modelo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].muestracomercial = muestracomercial
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].muestracomercialcodigo = muestracomercialcodigo
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].nombreProducto = nombreProducto
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].posicion = posicion
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].preciosinimpuestos = preciosinimpuestos
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].preciototal = preciototal
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].referencia = referencia
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].seriales = seriales
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].tamanio = tamanio
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].tipoImpuesto = tipoImpuesto
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].tipocodigoproducto = tipocodigoproducto
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].unidadmedida = unidadmedida
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].valorunitario = valorunitario
    LET enviarDocumento.felCabezaDocumento.listaDetalle[indice_Detalle].valorUnitarioPorCantidad = valorUnitarioPorCantidad

END FUNCTION

#+ Agregar DocumentoAdjunto
#+
#+ LISTA DE DOCUMENTOS ADJUNTOS QUE SE ENVÍAN POR EL WEB SERVICE
#+
#+ @code
#+ CALL f_DocumentoAdjunto_Agrega(
#+     ""--ArchivoRuta
#+    ,"Texto"--nombreConExtension
#+ )
#+
#+ @param ArchivoRuta CONTENIDO DEL ARCHIVO EN BASE 64. ESTE CAMPO CONTIENE UN ARREGLO DE BYTE’S QUE REPRESENTA EL DOCUMENTO ADJUNTO QUE POSTERIORMENTE SE PASA POR UN BASE 64.
#+ @param nombreConExtension NOMBRE DEL ARCHIVO A ADJUNTAR
#+
#+ @return Sin regreso
#+
FUNCTION f_DocumentoAdjunto_Agrega(
     ArchivoRuta
    ,nombreConExtension
)
DEFINE
     nombreConExtension VARCHAR(240)
    ,ArchivoRuta STRING

    CALL Val_cabeza()

    LET indice_DocumentosAdjuntos = indice_DocumentosAdjuntos + 1

    LOCATE enviarDocumento.felCabezaDocumento.listaDocumentosAdjuntos[indice_DocumentosAdjuntos].contenidoDelDoc IN MEMORY
    CALL enviarDocumento.felCabezaDocumento.listaDocumentosAdjuntos[indice_DocumentosAdjuntos].contenidoDelDoc.readFile(ArchivoRuta) 
    LET enviarDocumento.felCabezaDocumento.listaDocumentosAdjuntos[indice_DocumentosAdjuntos].nombreConExtension = nombreConExtension

END FUNCTION

#+ Agregar FacturaModificada
#+
#+ LISTA DE LAS FACTURAS ASOCIADAS A UNA NOTA. ESTE VALOR SE HACE OBLIGATORIO CUANDO EL TIPO DOCUMENTO ES UNA NOTA CRÉDITO O DEBITO
#+
#+ @code
#+ CALL f_FacturaModificada_Agrega(
#+     "Texto"--consecutivoFacturaModificada
#+    ,"Texto"--cufeFacturaModificada
#+    ,"2020-03-24 10:15"--fechaFacturaModificada
#+    ,"Texto"--observacion
#+    ,"Texto"--prefijoFacturaModificada
#+    ,"Texto"--tipoDocumentoFacturaModificada
#+ )
#+
#+ @param consecutivoFacturaModificada (OBLIGATORIO) CONSECUTIVO DE LA FACTURA A MODIFICAR. ESTE CAMPO SOLO APLICA PARA LAS NOTAS DÉBITO Y/O CRÉDITO. EJ: 564231
#+ @param cufeFacturaModificada 
#+ @param fechaFacturaModificada 
#+ @param observacion 
#+ @param prefijoFacturaModificada (OBLIGATORIO) VALOR NECESARIO PARA PODER ENCONTRAR EL CUFE DE LA FACTURA A AFECTAR. EJ: FACT
#+ @param tipoDocumentoFacturaModificada (OBLIGATORIO) VALOR NECESARIO PARA PODER ENCONTRAR EL CUFE DE LA FACTURA A AFECTAR.
#+
#+ @return Sin regreso
#+
FUNCTION f_FacturaModificada_Agrega(
     consecutivoFacturaModificada
    ,cufeFacturaModificada
    ,fechaFacturaModificada
    ,observacion
    ,prefijoFacturaModificada
    ,tipoDocumentoFacturaModificada
)
DEFINE
     consecutivoFacturaModificada STRING
    ,cufeFacturaModificada STRING
    ,fechaFacturaModificada DATETIME YEAR TO FRACTION(5)
    ,observacion STRING
    ,prefijoFacturaModificada VARCHAR(5)
    ,tipoDocumentoFacturaModificada VARCHAR(1)

    CALL Val_cabeza()

    LET indice_FacturasModificadas = indice_FacturasModificadas + 1
    LET enviarDocumento.felCabezaDocumento.listaFacturasModificadas[indice_FacturasModificadas].consecutivoFacturaModificada = consecutivoFacturaModificada
    LET enviarDocumento.felCabezaDocumento.listaFacturasModificadas[indice_FacturasModificadas].cufeFacturaModificada = cufeFacturaModificada
    LET enviarDocumento.felCabezaDocumento.listaFacturasModificadas[indice_FacturasModificadas].fechaFacturaModificada = fechaFacturaModificada
    LET enviarDocumento.felCabezaDocumento.listaFacturasModificadas[indice_FacturasModificadas].observacion = observacion
    LET enviarDocumento.felCabezaDocumento.listaFacturasModificadas[indice_FacturasModificadas].prefijoFacturaModificada = prefijoFacturaModificada
    LET enviarDocumento.felCabezaDocumento.listaFacturasModificadas[indice_FacturasModificadas].tipoDocumentoFacturaModificada = tipoDocumentoFacturaModificada

END FUNCTION

#+ Agregar Impuesto
#+
#+ LISTA DE LOS IMPUESTOS Y/O RETENCIONES ASOCIADOS AL DETALLE. SI EL PRODUCTO O SERVICIO ES EXCLUIDO NO SE HACE OBLIGATORIO ESTE VALOR.
#+
#+ @code
#+ CALL f_Impuesto_Agrega(
#+     123.12--baseimponible
#+    ,"Texto"--codigoImpuestoRetencion
#+    ,NULL--isAutoRetenido
#+    ,123.12--porcentaje
#+    ,123.12--valorImpuestoRetencion
#+ )
#+
#+ @param baseimponible (OBLIGATORIO) BASE IMPONIBLE SOBRE LA QUE SE CALCULA LA RETENCIÓN O IMPUESTO. TENER EN CUENTA QUE ESTE VALOR DEBE TENER DESCUENTOS INCLUIDOS
#+ @param codigoImpuestoRetencion (OBLIGATORIO) CÓDIGO DEL IMPUESTO O RETENCIÓN. VER NUEVA TABLA DE IMPUESTOS EN LA SECCIÓN TABLAS.
#+ @param isAutoRetenido (OBLIGATORIO) INDICA SI LO QUE SE REPORTA ES IMPUESTO O RETENCIÓN. VALORES POSIBLES: TRUE (ES RETENCIÓN), FALSE (ES IMPUESTO)
#+ @param porcentaje (OBLIGATORIO) PORCENTAJE DE IMPUESTO O RETENCIÓN A APLICAR
#+ @param valorImpuestoRetencion (OBLIGATORIO) VALOR DEL IMPUESTO O RETENCIÓN A APLICAR
#+
#+ @return Sin regreso
#+
FUNCTION f_Impuesto_Agrega(
     baseimponible
    ,codigoImpuestoRetencion
    ,isAutoRetenido
    ,porcentaje
    ,valorImpuestoRetencion
)
DEFINE
     baseimponible FLOAT
    ,codigoImpuestoRetencion VARCHAR(2)
    ,isAutoRetenido BOOLEAN
    ,porcentaje FLOAT
    ,valorImpuestoRetencion FLOAT

    CALL Val_cabeza()

    LET indice_Impuestos = indice_Impuestos + 1
    LET enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].baseimponible = baseimponible
    LET enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].codigoImpuestoRetencion = codigoImpuestoRetencion
    LET enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].isAutoRetenido = isAutoRetenido
    LET enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].porcentaje = porcentaje
    LET enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].valorImpuestoRetencion = valorImpuestoRetencion

END FUNCTION

#+ Agregar MedioPago
#+
#+ LISTADO DE LOS MEDIOS DE PAGO.
#+
#+ @code
#+ CALL f_MedioPago_Agrega(
#+     "Texto"--medioPago
#+ )
#+
#+ @param medioPago (OBLIGATORIO) LISTADO DE LOS MEDIOS DE PAGO.
#+
#+ @return Sin regreso
#+
FUNCTION f_MedioPago_Agrega(
     medioPago
)
DEFINE
     medioPago VARCHAR(2)

    CALL Val_cabeza()

    LET indice_MediosPagos = indice_MediosPagos + 1
    LET enviarDocumento.felCabezaDocumento.listaMediosPagos[indice_MediosPagos].medioPago = medioPago

END FUNCTION

#+ Agregar Esquema
#+
#+ LISTADO DE LOS ESQUEMA.
#+
#+ @code
#+ CALL f_Esquema_Agrega(
#+     "Texto"--esquema
#+    ,"Texto"--nombreSector
#+ )
#+
#+ @param medioPago ESQUEMA.
#+
#+ @return Sin regreso
#+
FUNCTION f_Esquema_Agrega(
     esquema
    ,nombreSector
)
DEFINE
     esquema STRING
    ,nombreSector STRING

    CALL Val_cabeza()

    LET indice_Esquema = indice_Esquema + 1
    LET indice_Esquema_CamposAdicionales = 0

    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].esquema = esquema
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].nombreSector = nombreSector

END FUNCTION

#+ Agregar CampoAdicional de Esquema
#+
#+ LISTA QUE ALMACENA UNO O VARIOS ELEMENTOS CON ASOCIACIÓN CAMPO VALOR PARA MANEJAR CAMPOS NO TENIDOS EN CUENTA EN EL ESTÁNDAR UBL2.1 DEFINIDO POR LA DIAN. ESTE CAMPO HACE PARTE DE LOS CAMBIOS POR EL NUEVO MODELO
#+
#+ @code
#+ CALL f_Esquema_CampoAdicional_Agrega(
#+     "2020-03-24 10:15" --fecha
#+    ,"Texto" --nombreCampo
#+    ,123 --orden
#+    ,123 --seccion
#+    ,"Texto" --valorCampo
#+    ,"Texto" --nombreSector
#+ )
#+
#+ @param fecha FECHA DE REFERENCIA ASOCIADA AL CAMPO NECESARIO PARA MOSTRAR EN LA REPRESENTACIÓN GRÁFICA
#+ @param nombreCampo DESCRIPCION DEL VALOR ALMACENADO. PARA EL MANEJO DE LAS NOTAS DE LA DIAN, COLOCAR EL CONCEPTO DESCRIPCION
#+ @param orden ORDEN EN EL QUE SE PRESENTARÁ LA INFORMACIÓN, DA UNA JERARQUIA AL MOMENTO DE PINTAR EL DATO
#+ @param seccion GRUPO DE DATOS ADICIONALES QUE SIRVE PARA SABER UNA DETERMINADA POSICIÓN EN LA QUE SE QUIERA REPRESENTAR LA INFORMACIÓN EN EL PDF
#+ @param valorCampo VALOR DEL CAMPO ADICIONAL INDICADO
#+ @param nombreSector NOMBRE DEL SECTOR DE LA EMPRESA
#+
#+ @return Sin regreso
#+
FUNCTION f_Esquema_CampoAdicional_Agrega(
     fecha
    ,nombreCampo
    ,orden
    ,seccion
    ,valorCampo
    ,nombreSector
)
DEFINE
     fecha DATETIME YEAR TO FRACTION(5)
    ,nombreCampo VARCHAR(50)
    ,orden INTEGER
    ,seccion INTEGER
    ,valorCampo VARCHAR(800)
    ,nombreSector VARCHAR(240)

    CALL Val_Esquema()

    LET indice_Esquema_CamposAdicionales = indice_Esquema_CamposAdicionales + 1
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].listaCamposAdicionales[indice_Esquema_CamposAdicionales].fecha = fecha
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].listaCamposAdicionales[indice_Esquema_CamposAdicionales].nombreCampo = nombreCampo
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].listaCamposAdicionales[indice_Esquema_CamposAdicionales].orden = orden
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].listaCamposAdicionales[indice_Esquema_CamposAdicionales].seccion = seccion
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].listaCamposAdicionales[indice_Esquema_CamposAdicionales].valorCampo = valorCampo
    LET enviarDocumento.felCabezaDocumento.listaEsquema[indice_Esquema].listaCamposAdicionales[indice_Esquema_CamposAdicionales].nombreSector = nombreSector

END FUNCTION

#+ Agregar OrdenCompra
#+
#+ CONTIENE UN LISTADO DE LAS ORDENES DE COMPRAS ASOCIADAS A UNA FACTURA. UNA OPCIÓN ES MANEJAR LA INICIAL SEPARANDO TODO POR PUNTO Y COMA “;”
#+
#+ @code
#+ CALL f_OrdenCompra_Agrega(
#+     "2020-03-24 10:15"--fechaemisionordencompra
#+    ,"Texto"--numeroaceptacioninterno
#+    ,"Texto"--ordencompra
#+ )
#+
#+ @param fechaemisionordencompra FECHA DE CREACIÓN DE LA ORDEN DE COMPRA
#+ @param numeroaceptacioninterno NUMERO DE ACEPTACIÓN, CODIGO INTERNO DEL COMPRADOR
#+ @param ordencompra ORDEN DE COMPRA ASOCIADA A LA FACTURA
#+
#+ @return Sin regreso
#+
FUNCTION f_OrdenCompra_Agrega(
     fechaemisionordencompra
    ,numeroaceptacioninterno
    ,ordencompra
)
DEFINE
     fechaemisionordencompra DATETIME YEAR TO FRACTION(5)
    ,numeroaceptacioninterno VARCHAR(40)
    ,ordencompra VARCHAR(40)

    CALL Val_cabeza()

    LET indice_OrdenesCompras = indice_OrdenesCompras + 1
    LET enviarDocumento.felCabezaDocumento.listaOrdenesCompras[indice_OrdenesCompras].fechaemisionordencompra = fechaemisionordencompra
    LET enviarDocumento.felCabezaDocumento.listaOrdenesCompras[indice_OrdenesCompras].numeroaceptacioninterno = numeroaceptacioninterno
    LET enviarDocumento.felCabezaDocumento.listaOrdenesCompras[indice_OrdenesCompras].ordencompra = ordencompra

END FUNCTION

#+ Agregar Pagos
#+
#+ ESTRUCTURA QUE ALMACENA LA INFORMACIÓN DEL PAGO
#+
#+ @code
#+ CALL f_Pagos_Agrega(
#+     "Texto"--codigoMonedaCambio
#+    ,"2020-03-24 10:15"--fechaTasaCambio
#+    ,"2020-03-24 10:15"--fechavencimiento
#+    ,"Texto"--moneda
#+    ,123.12--pagoanticipado
#+    ,123--periododepagoa
#+    ,123--tipocompra
#+    ,123.12--totalCargos
#+    ,123.12--totalDescuento
#+    ,123.12--totalbaseconimpuestos
#+    ,123.12--totalbaseimponible
#+    ,123.12--totalfactura
#+    ,123.12--totalimportebruto
#+    ,123.12--trm
#+    ,123.12--trm_alterna
#+    ,123.12--subtotal
#+    ,"Texto"--valorEnLetrasSubTotal
#+    ,"Texto"--valorAdicional1
#+    ,"Texto"--valorAdicional2
#+    ,"Texto"--valorAdicional3
#+    ,"Texto"--valorAdicional4
#+    ,"Texto"--valorAdicional5
#+    ,"Texto"--valorEnLetras1
#+    ,"Texto"--valorEnLetras2
#+    ,"Texto"--valorEnLetras3
#+    ,"Texto"--valorEnLetras4
#+    ,"Texto"--valorEnLetras5
#+    ,123.12--redondeoTotalFactura
#+ )
#+
#+ @param codigoMonedaCambio (OBLIGATORIO) MONEDA EN LA QUE SE CONVIERTE CON LA TRM EN ESTÁNDAR ISO 4217, ESTE VALOR SIEMPRE DEBE SER COP
#+ @param fechaTasaCambio OBLIGATORIO PARA FACTURAS DE EXPORTACIÓN O NACIONALES EN OTRA MONEDA. FECHA CON LA QUE SE FIJA LA TASA DE CAMBIO. CAMPO NUEVO
#+ @param fechavencimiento APLICA PARA VENTAS A CREDITO tipocompra=2, INFORMA LA FECHA LIMITE EN QUE SE DEBE PAGAR LA FACTURA DE ACUERDO A LO ACORDADO EN EL PERDIODO DE PAGO. ESTE CAMPO ES OBLIGATORIO SI tipocompra=2
#+ @param moneda (OBLIGATORIO) MONEDA EN LA QUE SE NEGOCIA EN ESTÁNDAR ISO 4217
#+ @param pagoanticipado CONSOLIDADO DE TODOS LOS ANTICIPOS DE LA FACTURA. ESTE VALOR SALE DE LA SUMATORIA DE TODOS LOS ANTICIPOS EN LA LISTA DE ANTICIPOS A NIVEL GLOBAL
#+ @param periododepagoa ESTE CAMPO INDICA EL NÚMERO DE DIAS EN QUE SE PAGARA LA COMPRA CUANDO ES A CREDITO, ES DECIR tipocompra=2. ESTE CAMPO ES OBLIGATORIO SI tipocompra=2
#+ @param tipocompra (OBLIGATORIO) ESTE CAMPO INDICA SI LA COMPRA ES 1. DE CONTADO O 2. A CRÉDITO
#+ @param totalCargos CONSOLIDADO DEL TOTAL DE LOS CARGOS APLICADOS. EL VALOR SALE DE LA SUMATORIA DEL VALORCARGO DE LA LISTA DE CARGOS A NIVEL GLOBAL.
#+ @param totalDescuento CONSOLIDADO DEL TOTAL DE LOS DESCUENTOS APLICADOS. EL VALOR SALE DE LA SUMATORIA DEL VALOR DESCUENTO DE LA LISTA DE DESCUENTOS A NIVEL GLOBAL.
#+ @param totalbaseconimpuestos (OBLIGATORIO) ES EL TOTAL IMPORTE BRUTO MAS LA SUMATORIA DE TODOS LOS VALORES DE IMPUESTOS A NIVEL DE DETALLE. NO APLICA PARA CODIGOS DE RETENCIÓN. Totalimportebruto + ? valorImpuestoRetencion(NIVEL DETALLE)
#+ @param totalbaseimponible (OBLIGATORIO) ES LA SUMATORIA DE TODAS LAS BASES IMPONIBLES EN LA LISTA DE IMPUESTOS ASOCIADAS AL DETALLE DE LA FACTURA, QUE APLICAN COMO IMPUESTOS Y NO COMO RETENCIONES.
#+ @param totalfactura (OBLIGATORIO) ES LA BASE CON IMPUESTOS, MAS CARGOS, MENOS DESCUENTOS, MENOS ANTICIPOS, TODO A NIVEL GLOBAL. Totalbaseconimpuestos+ totalCargos- totalDescuento- pagoanticipado
#+ @param totalimportebruto (OBLIGATORIO) SUMATORIA DE TODOS LOS PRECIOS SIN IMPUESTO DE LAS LÍNEAS DE DETALLE DE LA FACTURA.
#+ @param trm SE HACE OBLIGATORIO PARA FACTURAS DE EXPORTACIÓN O NACIONALES EN OTRA MONEDA
#+ @param trm_alterna APLICA PARA FACTURAS DE EXPORTACIÓN O NACIONALES EN OTRA MONEDA
#+ @param subtotal NO NO VALOR UTILIZADO COMO COMODÍN PARA LAS EMPRESAS QUE REQUIERAN EN EL CAMPO SUBTOTAL UN VALOR PARTICULAR
#+ @param valorEnLetrasSubTotal COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorAdicional1 COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorAdicional2 COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorAdicional3 COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorAdicional4 COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorAdicional5 COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorEnLetras1 NO NO COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorEnLetras2 NO NO COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorEnLetras3 NO NO COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorEnLetras4 NO NO COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param valorEnLetras5 NO NO COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+ @param redondeoTotalFactura COMODÍN PARA REPRESENTACIONES GRÁFICAS
#+
#+ @return Sin regreso
#+
FUNCTION f_Pagos_Agrega(
     codigoMonedaCambio
    ,fechaTasaCambio
    ,fechavencimiento
    ,moneda
    ,pagoanticipado
    ,periododepagoa
    ,tipocompra
    ,totalCargos
    ,totalDescuento
    ,totalbaseconimpuestos
    ,totalbaseimponible
    ,totalfactura
    ,totalimportebruto
    ,trm
    ,trm_alterna
    ,subtotal
    ,valorEnLetrasSubTotal
    ,valorAdicional1
    ,valorAdicional2
    ,valorAdicional3
    ,valorAdicional4
    ,valorAdicional5
    ,valorEnLetras1
    ,valorEnLetras2
    ,valorEnLetras3
    ,valorEnLetras4
    ,valorEnLetras5
    ,redondeoTotalFactura
)
DEFINE
     codigoMonedaCambio VARCHAR(3)
    ,fechaTasaCambio DATETIME YEAR TO FRACTION(5)
    ,fechavencimiento DATETIME YEAR TO FRACTION(5)
    ,moneda VARCHAR(3)
    ,pagoanticipado FLOAT
    ,periododepagoa INTEGER
    ,tipocompra INTEGER
    ,totalCargos FLOAT
    ,totalDescuento FLOAT
    ,totalbaseconimpuestos FLOAT
    ,totalbaseimponible FLOAT
    ,totalfactura FLOAT
    ,totalimportebruto FLOAT
    ,trm FLOAT
    ,trm_alterna FLOAT
    ,subtotal FLOAT
    ,valorEnLetrasSubTotal VARCHAR(240)
    ,valorAdicional1 VARCHAR(240)
    ,valorAdicional2 VARCHAR(240)
    ,valorAdicional3 VARCHAR(240)
    ,valorAdicional4 VARCHAR(240)
    ,valorAdicional5 VARCHAR(240)
    ,valorEnLetras1 VARCHAR(240)
    ,valorEnLetras2 VARCHAR(240)
    ,valorEnLetras3 VARCHAR(240)
    ,valorEnLetras4 VARCHAR(240)
    ,valorEnLetras5 VARCHAR(240)
    ,redondeoTotalFactura FLOAT

    CALL Val_cabeza()

    LET enviarDocumento.felCabezaDocumento.pago.codigoMonedaCambio = codigoMonedaCambio
    LET enviarDocumento.felCabezaDocumento.pago.fechaTasaCambio = fechaTasaCambio
    LET enviarDocumento.felCabezaDocumento.pago.fechavencimiento = fechavencimiento
    LET enviarDocumento.felCabezaDocumento.pago.moneda = moneda
    LET enviarDocumento.felCabezaDocumento.pago.pagoanticipado = pagoanticipado
    LET enviarDocumento.felCabezaDocumento.pago.periododepagoa = periododepagoa
    LET enviarDocumento.felCabezaDocumento.pago.tipocompra = tipocompra
    LET enviarDocumento.felCabezaDocumento.pago.totalCargos = totalCargos
    LET enviarDocumento.felCabezaDocumento.pago.totalDescuento = totalDescuento
    LET enviarDocumento.felCabezaDocumento.pago.totalbaseconimpuestos = totalbaseconimpuestos
    LET enviarDocumento.felCabezaDocumento.pago.totalbaseimponible = totalbaseimponible
    LET enviarDocumento.felCabezaDocumento.pago.totalfactura = totalfactura
    LET enviarDocumento.felCabezaDocumento.pago.totalimportebruto = totalimportebruto
    LET enviarDocumento.felCabezaDocumento.pago.trm = trm
    LET enviarDocumento.felCabezaDocumento.pago.trm_alterna = trm_alterna
    LET enviarDocumento.felCabezaDocumento.pago.subtotal = subtotal
    LET enviarDocumento.felCabezaDocumento.pago.valorEnLetrasSubTotal = valorEnLetrasSubTotal
    LET enviarDocumento.felCabezaDocumento.pago.valorAdicional1 = valorAdicional1
    LET enviarDocumento.felCabezaDocumento.pago.valorAdicional2 = valorAdicional2
    LET enviarDocumento.felCabezaDocumento.pago.valorAdicional3 = valorAdicional3
    LET enviarDocumento.felCabezaDocumento.pago.valorAdicional4 = valorAdicional4
    LET enviarDocumento.felCabezaDocumento.pago.valorAdicional5 = valorAdicional5
    LET enviarDocumento.felCabezaDocumento.pago.valorEnLetras1 = valorEnLetras1
    LET enviarDocumento.felCabezaDocumento.pago.valorEnLetras2 = valorEnLetras2
    LET enviarDocumento.felCabezaDocumento.pago.valorEnLetras3 = valorEnLetras3
    LET enviarDocumento.felCabezaDocumento.pago.valorEnLetras4 = valorEnLetras4
    LET enviarDocumento.felCabezaDocumento.pago.valorEnLetras5 = valorEnLetras5
    LET enviarDocumento.felCabezaDocumento.pago.redondeoTotalFactura = redondeoTotalFactura

END FUNCTION

#+ Agregar CabezaDocumento
#+
#+ Agregar CabezaDocumento
#+
#+ @code
#+ CALL f_CabezaDocumento_Agrega(
#+     "Texto"--aplicafel
#+    ,123--cantidadLineas
#+    ,"Texto"--centroCostos
#+    ,123--codigoPlantillaPdf
#+    ,"Texto"--codigovendedor
#+    ,123456789--consecutivo
#+    ,"Texto"--contrasenia
#+    ,"Texto"--descripcionCentroCostos
#+    ,"2020-03-24 10:15"--fechafacturacion
#+    ,123456789--idEmpresa
#+    ,"Texto"--idErp
#+    ,"Texto"--incoterm
#+    ,"Texto"--nombrevendedor
#+    ,"Texto"--prefijo
#+    ,"Texto"--sucursal
#+    ,"Texto"--tipoOperacion
#+    ,"Texto"--tipodocumento
#+    ,"Texto"--tiponota
#+    ,"Texto"--token
#+    ,"Texto"--usuario
#+    ,"Texto"--version
#+    ,"Texto"--nombreImpresora
#+    ,"Texto"--campoAdicional1
#+    ,"Texto"--campoAdicional2
#+    ,"Texto"--campoAdicional3
#+    ,"Texto"--campoAdicional4
#+    ,"Texto"--campoAdicional5
#+ )
#+
#+ @param aplicafel (OBLIGATORIO) APLICA FACTURA ELECTRÓNICA A ESTE CLIENTE. VALORES POSIBLES (SI, NO). ESTA VARIABLE PERMITE EL ENVIO O NO DEL DOCUMENTO POR EMAIL AL COMPRADOR O ADQUIRENTE
#+ @param cantidadLineas (OBLIGATORIO) VERIFICA EL NUMERO DE LOS DETALLES, ESTE ES UN CONTROL DE LA DIAN PARA COMPROBAR QUE LOS SERVICIOS Y PRODUCTOS VAN COMPLETOS
#+ @param centroCostos CENTRO DE COSTOS AL QUE SE DEBE ASOCIAR LA FACTURA
#+ @param codigoPlantillaPdf (OBLIGATORIO) CODIGO DEL FORMATO DEL DOCUMENTO ELECTRÓNICO A IMPLEMENTAR. APLICA SOLO SI LA EMPRESA MANEJA MAS DE UN FORMATO PARA FACTURAS Y NOTAS. CUANDO EL VALOR ES CERO (0), INDICA QUE NO SE REQUIERE CREAR REPRESENTACIÓN GRÁFICA
#+ @param codigovendedor CODIGO O IDENTIFICACIÓN DEL VENDEDOR
#+ @param consecutivo (OBLIGATORIO) CONSECUTIVO ENTREGADO EN LA RESOLUCIÓN DE LA DIAN O NÚMERO DE FACTURA
#+ @param contrasenia (OBLIGATORIO) CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA
#+ @param descripcionCentroCostos DESCRIPCIÓN DEL CENTRO DE COSTOS
#+ @param fechafacturacion (OBLIGATORIO) FECHA Y HORA EN LA QUE SE FACTURÓ EN FORMATO YYYY-MM-DD HH:mm:ss
#+ @param idEmpresa (OBLIGATORIO) CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA
#+ @param idErp ID DEL ERP PARA ASOCIARLO A LA FACTURA
#+ @param incoterm (OBLIGATORIO) OBLIGATORIO PARA FACTURAS DE EXPORTACIÓN. VER TABLA INCOTERM
#+ @param nombrevendedor NOMBRE DEL VENDEDOR
#+ @param prefijo PREFIJO DE DOCUMENTO, SOLO SI LA EMPRESA LO MANEJA
#+ @param sucursal SUCURSAL DE LA EMPRESA
#+ @param tipoOperacion (OBLIGATORIO) VER EN LA SECCION TABLAS: TIPOS DE OPERACIÓN
#+ @param tipodocumento (OBLIGATORIO) TIPO DE DOCUMENTO --1. FACTURA DE VENTA, 2. NOTA CRÉDITO, 3. NOTA DÉBITO 4. FACTURA DE EXPORTACIÓN, 5. FACTURA DE CONTINGENCIA, 6. FACTURA DE IMPORTACIÓN.
#+ @param tiponota (OBLIGATORIO) NOTA CRÉDITO: 1. DEVOLUCIÓN DE PARTE DE LOS BIENES 2. ANULACIÓN DE FACTURA 3. REBAJA TOTAL APLICADA 4. DESCUENTO TOTAL APLICADO 5. RESCISIÓN: NULIDAD POR FALTA DE REQUISITOS 6. OTROS. NOTA DEBITO: 7. INTERESES 8. GASTOS POR COBRAR 9. CAMBIO DEL VALOR 10. OTROS
#+ @param token (OBLIGATORIO) CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA
#+ @param usuario (OBLIGATORIO) CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA
#+ @param version (OBLIGATORIO) VERSIÓN DEL MANUAL CON LA QUE EL CLIENTE TRABAJÓ LA INTEGRACIÓN
#+ @param nombreImpresora NOMBRE DE LA IMPRESORA CUANDO SE UTILICE IMPRESIÓN AUTOMÁTICA
#+ @param campoAdicional1 CAMPO ADICIONAL DE COMODÍN
#+ @param campoAdicional2 CAMPO ADICIONAL DE COMODÍN
#+ @param campoAdicional3 CAMPO ADICIONAL DE COMODÍN
#+ @param campoAdicional4 CAMPO ADICIONAL DE COMODÍN
#+ @param campoAdicional5 CAMPO ADICIONAL DE COMODÍN
#+
#+ @return Sin regreso
#+
FUNCTION f_CabezaDocumento_Agrega(
     aplicafel
    ,cantidadLineas
    ,centroCostos
    ,codigoPlantillaPdf
    ,codigovendedor
    ,consecutivo
    ,contrasenia
    ,descripcionCentroCostos
    ,fechafacturacion
    ,idEmpresa
    ,idErp
    ,incoterm
    ,nombrevendedor
    ,prefijo
    ,sucursal
    ,tipoOperacion
    ,tipodocumento
    ,tiponota
    ,token
    ,usuario
    ,version
    ,nombreImpresora
    ,campoAdicional1
    ,campoAdicional2
    ,campoAdicional3
    ,campoAdicional4
    ,campoAdicional5
)
DEFINE
     aplicafel VARCHAR(2)
    ,cantidadLineas INTEGER
    ,centroCostos VARCHAR(100)
    ,codigoPlantillaPdf INTEGER
    ,codigovendedor VARCHAR(50)
    ,consecutivo BIGINT
    ,contrasenia VARCHAR(40)
    ,descripcionCentroCostos VARCHAR(240)
    ,fechafacturacion DATETIME YEAR TO FRACTION(5)
    ,idEmpresa BIGINT
    ,idErp VARCHAR(40)
    ,incoterm VARCHAR(3)
    ,nombrevendedor VARCHAR(50)
    ,prefijo VARCHAR(5)
    ,sucursal VARCHAR(50)
    ,tipoOperacion VARCHAR(2)
    ,tipodocumento VARCHAR(1)
    ,tiponota VARCHAR(2)
    ,token VARCHAR(40)
    ,usuario VARCHAR(40)
    ,version VARCHAR(40)
    ,nombreImpresora VARCHAR(240)
    ,campoAdicional1 VARCHAR(240)
    ,campoAdicional2 VARCHAR(240)
    ,campoAdicional3 VARCHAR(240)
    ,campoAdicional4 VARCHAR(240)
    ,campoAdicional5 VARCHAR(240)

    CALL f_IniciaDocumentoCaptura()

    LET indice_cabeza = indice_cabeza + 1
    
    LET enviarDocumento.felCabezaDocumento.aplicafel = aplicafel
    LET enviarDocumento.felCabezaDocumento.cantidadLineas = cantidadLineas
    LET enviarDocumento.felCabezaDocumento.centroCostos = centroCostos
    LET enviarDocumento.felCabezaDocumento.codigoPlantillaPdf = codigoPlantillaPdf
    LET enviarDocumento.felCabezaDocumento.codigovendedor = codigovendedor
    LET enviarDocumento.felCabezaDocumento.consecutivo = consecutivo
    LET enviarDocumento.felCabezaDocumento.contrasenia = contrasenia
    LET enviarDocumento.felCabezaDocumento.descripcionCentroCostos = descripcionCentroCostos
    LET enviarDocumento.felCabezaDocumento.fechafacturacion = fechafacturacion
    LET enviarDocumento.felCabezaDocumento.idEmpresa = idEmpresa
    LET enviarDocumento.felCabezaDocumento.idErp = idErp
    LET enviarDocumento.felCabezaDocumento.incoterm = incoterm
    LET enviarDocumento.felCabezaDocumento.nombrevendedor = nombrevendedor
    LET enviarDocumento.felCabezaDocumento.prefijo = prefijo
    LET enviarDocumento.felCabezaDocumento.sucursal = sucursal
    LET enviarDocumento.felCabezaDocumento.tipoOperacion = tipoOperacion
    LET enviarDocumento.felCabezaDocumento.tipodocumento = tipodocumento
    LET enviarDocumento.felCabezaDocumento.tiponota = tiponota
    LET enviarDocumento.felCabezaDocumento.token = token
    LET enviarDocumento.felCabezaDocumento.usuario = usuario
    LET enviarDocumento.felCabezaDocumento.version = version
    LET enviarDocumento.felCabezaDocumento.nombreImpresora = nombreImpresora
    LET enviarDocumento.felCabezaDocumento.campoAdicional1 = campoAdicional1
    LET enviarDocumento.felCabezaDocumento.campoAdicional2 = campoAdicional2
    LET enviarDocumento.felCabezaDocumento.campoAdicional3 = campoAdicional3
    LET enviarDocumento.felCabezaDocumento.campoAdicional4 = campoAdicional4
    LET enviarDocumento.felCabezaDocumento.campoAdicional5 = campoAdicional5

END FUNCTION

#+ Recupera MensajesProceso
#+
#+ Especifica el código del mensaje y una descripción relacionada al código de respuesta
#+
#+ @code
#+ CALL f_MensajesProceso_Recupera(1)
#+ RETURNING
#+     codigoMensaje
#+    ,descripcionMensaje
#+    ,rechazoNotificacion
#+ 
#+ @param indice indice del mensaje que se desea recuperar
#+
#+ @return codigoMensaje IDENTIFICADOR DEL MENSAJE
#+ @return descripcionMensaje CAMPO QUE DESCRIBE LOS MENSAJES DE ERROR ASOCIADOS AL DOCUMENTO
#+ @return rechazoNotificacion CAMPO QUE DESCRIBE SI LA VALIDACIÓN ES DE TIPO RECHAZO (R) O NOTIFICACIÓN (N)
#+
FUNCTION f_MensajesProceso_Recupera(indice)
DEFINE
     codigoMensaje VARCHAR(50)
    ,descripcionMensaje VARCHAR(240)
    ,rechazoNotificacion VARCHAR(2)
    ,indice INTEGER 

    LET codigoMensaje = enviarDocumentoResponse.return.listaMensajesProceso[indice].codigoMensaje
    LET descripcionMensaje = enviarDocumentoResponse.return.listaMensajesProceso[indice].descripcionMensaje
    LET rechazoNotificacion = enviarDocumentoResponse.return.listaMensajesProceso[indice].rechazoNotificacion

    RETURN
         codigoMensaje
        ,descripcionMensaje
        ,rechazoNotificacion

END FUNCTION

#+ Conteo MensajesProceso
#+
#+ Total de mensajes que entrego la petición
#+
#+ @code
#+ CALL f_MensajesProceso_Conteo()
#+ RETURNING conteoMensaje
#+
#+ @return MensajesConteo Total de mensajes que entrego la petición
#+
FUNCTION f_MensajesProceso_Conteo()
    RETURN enviarDocumentoResponse.return.listaMensajesProceso.getLength()
END FUNCTION

#+ Recupera RespuestaEnvio
#+
#+ respuesta al cliente del web service sobre el almacenamiento de la información y genera los documentos xml y pdf
#+
#+ @code
#+ CALL f_RespuestaEnvio_Recupera()
#+ RETURNING
#+     codigoQr
#+    ,consecutivo
#+    ,cufe
#+    ,descripcionProceso
#+    ,estadoProceso
#+    ,fechaExpedicion
#+    ,fechaFactura
#+    ,fechaRespuesta
#+    ,firmaDelDocumento
#+    ,idErp
#+    ,prefijo
#+    ,selloDeValidacion
#+    ,tipoDocumento
#+
#+ @return codigoQr CÓDIGO QR PARA QUE SEA IMPLEMENTADO POR EL CLIENTE EN EL PDF. ESTE VALOR ES LA CADENA CONCATENADA DA LOS DATOS COMO LO PIDE LA DIAN
#+ @return consecutivo CONSECUTIVO HABILITADO POR LA DIAN PARA FACTURAR ELECTRÓNICAMENTE
#+ @return cufe CÓDIGO ÚNICO DE FACTURA ELECTRÓNICA. CON ESTE VALOR EL CLIENTE PODRÍA GENERAR LA REPRESENTACIÓN GRÁFICA SI ASÍ LO QUISIERA
#+ @return descripcionProceso 
#+ @return estadoProceso 0 = ERROR; 1 = EXITOSO; 2 = EXITOSO CON NOTIFICACIONES; 3 = DOCUMENTO INGRESADO PREVIAMENTE; 4 = EL DOCUMENTO ESTÁ SIENDO PROCESADO; 24 = CONTINGENCIA DIAN
#+ @return fechaExpedicion FECHA EN LA CUAL LA DIAN REALIZA LA VALIDACIÓN
#+ @return fechaFactura FECHA DE CREACIÓN DE LA FACTURA EN EL ERP
#+ @return fechaRespuesta FECHA DE LA RESPUESTA DEL WEB SERVICE
#+ @return firmaDelDocumento FIRMA DEL DOCUMENTO EN CASO TAL EL CLIENTE LO REQUIERA PARA CONTROL INTERNO
#+ @return idErp APLICA SOLO CUANDO LA EMPRESA ENVÍA EL ID DEL ERP QUE IDENTIFICA LA FACTURA, Y DEVUELVE DICHO VALOR, DE LO CONTRARIO DEVUELVE CERO
#+ @return prefijo PREFIJO DEL DOCUMENTO ELECTRÓNICO
#+ @return selloDeValidacion FIRMA DE VALIDACIÓN POR PARTE DE LA DIAN, SE DEVUELVE PARA CONTROL INTERNO DEL CLIENTE
#+ @return tipoDocumento TIPO DE DOCUMENTO ELECTRÓNICO
#+
FUNCTION f_RespuestaEnvio_Recupera()
DEFINE wsstatus,contador,conta_2   INTEGER
    ,lb_hay_error BOOLEAN
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

    LET lb_hay_error = FALSE
    
    CALL Val_obliga("Es obligatorio el usuario",enviarDocumento.felCabezaDocumento.usuario,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el token",enviarDocumento.felCabezaDocumento.token,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatoria la contraseña",enviarDocumento.felCabezaDocumento.contrasenia,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el id de la empresa ",enviarDocumento.felCabezaDocumento.idEmpresa,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatoria la versión",enviarDocumento.felCabezaDocumento.version,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el tipo de documento",enviarDocumento.felCabezaDocumento.tipodocumento,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el consecutivo",enviarDocumento.felCabezaDocumento.consecutivo,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatoria la fecha de facturación",enviarDocumento.felCabezaDocumento.fechafacturacion,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatoria la cantidad de líneas ",enviarDocumento.felCabezaDocumento.cantidadLineas,lb_hay_error) RETURNING lb_hay_error
    --CALL Val_obliga("Es obligatorio el valor incoterm",enviarDocumento.felCabezaDocumento.incoterm,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el tipo de nota",enviarDocumento.felCabezaDocumento.tiponota,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el valor aplicafel",enviarDocumento.felCabezaDocumento.aplicafel,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el tipo de operación",enviarDocumento.felCabezaDocumento.tipoOperacion,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el codigoPlantillaPdf",enviarDocumento.felCabezaDocumento.codigoPlantillaPdf,lb_hay_error) RETURNING lb_hay_error

    CALL Val_obliga("Es obligatoria la moneda del pago",enviarDocumento.felCabezaDocumento.pago.moneda,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el total importe bruto del pago",enviarDocumento.felCabezaDocumento.pago.totalimportebruto,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el total base imponible del pago",enviarDocumento.felCabezaDocumento.pago.totalbaseimponible,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el total base con impuestos del pago",enviarDocumento.felCabezaDocumento.pago.totalbaseconimpuestos,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el total de la factura del pago",enviarDocumento.felCabezaDocumento.pago.totalfactura,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el tipo de compra del pago",enviarDocumento.felCabezaDocumento.pago.tipocompra,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el codigo de moneda cambio del pago",enviarDocumento.felCabezaDocumento.pago.codigoMonedaCambio,lb_hay_error) RETURNING lb_hay_error

    CALL Val_lista("Es requerida al menos una sección Detalle",enviarDocumento.felCabezaDocumento.listaDetalle.getLength(),lb_hay_error) RETURNING lb_hay_error
    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaDetalle.getLength()
        CALL Val_obliga("Es obligatorio codigo producto del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].codigoproducto,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio tipo codigo producto del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].tipocodigoproducto,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio nombre del producto del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].nombreProducto,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatoria la cantidad del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].cantidad,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatoria la unidad de medida del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].unidadmedida,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el valor unitario del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].valorunitario,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el precio sin impuestos del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].preciosinimpuestos,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el precio total del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].preciototal,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el tipo de impuesto del detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].tipoImpuesto,lb_hay_error) RETURNING lb_hay_error

        FOR conta_2 = 1 TO enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaMandantes.getLength()
            CALL Val_obliga("Es obligatoria la identificacion del Detalle "||contador||" Mandante "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaMandantes[conta_2].identificacionMandante,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el digito Verificación del Detalle "||contador||" Mandante "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaMandantes[conta_2].digitoVerificacion,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el tipo Identificación del Detalle "||contador||" Mandante "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaMandantes[conta_2].tipoIdentificacionMandante,lb_hay_error) RETURNING lb_hay_error
        END FOR

        FOR conta_2 = 1 TO enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaDescuentos.getLength()
            CALL Val_obliga("Es obligatorio el descuento del Detalle "||contador||" Descuento "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaDescuentos[conta_2].descuento,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el porcentaje del Detalle "||contador||" Descuento "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaDescuentos[conta_2].porcentajeDescuento,lb_hay_error) RETURNING lb_hay_error
        END FOR

        FOR conta_2 = 1 TO enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaCargos.getLength()
            CALL Val_obliga("Es obligatorio el valorCargo del Detalle "||contador||" Cargo "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaCargos[conta_2].valorCargo,lb_hay_error) RETURNING lb_hay_error
        END FOR

        FOR conta_2 = 1 TO enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaCodigoBarras.getLength()
            CALL Val_obliga("Es obligatorio la cadena a codificar del Detalle "||contador||" CodigoBarras "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaCodigoBarras[conta_2].cadenaACodificar,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el tipo modelo del Detalle "||contador||" CodigoBarras "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaCodigoBarras[conta_2].tipoModelo,lb_hay_error) RETURNING lb_hay_error
        END FOR

        CALL Val_lista("Es requerida al menos una sección Impuesto del Detalle "||contador,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos.getLength(),lb_hay_error) RETURNING lb_hay_error
        FOR conta_2 = 1 TO enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos.getLength()
            CALL Val_obliga("Es obligatoria la base imponible del Detalle "||contador||" Impuesto "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos[conta_2].baseimponible,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el codigo Impuesto Retencion del Detalle "||contador||" Impuesto "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos[conta_2].codigoImpuestoRetencion,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el campo isAutoRetenido del Detalle "||contador||" Impuesto "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos[conta_2].isAutoRetenido,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el porcentaje del Detalle "||contador||" Impuesto "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos[conta_2].porcentaje,lb_hay_error) RETURNING lb_hay_error
            CALL Val_obliga("Es obligatorio el valorImpuestoRetencion del Detalle "||contador||" Impuesto "||conta_2,enviarDocumento.felCabezaDocumento.listaDetalle[contador].listaImpuestos[conta_2].valorImpuestoRetencion,lb_hay_error) RETURNING lb_hay_error
        END FOR
    END FOR

    CALL Val_lista("Es requerida al menos una sección Adquirente",enviarDocumento.felCabezaDocumento.listaAdquirentes.getLength(),lb_hay_error) RETURNING lb_hay_error
    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaAdquirentes.getLength()
        CALL Val_obliga("Es obligatorio el tipo persona del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].tipoPersona,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el nombre completo del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].nombreCompleto,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el tipo identificación del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].tipoIdentificacion,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el numero identificación del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].numeroIdentificacion,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el pais del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].pais,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el departamento del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].departamento,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatoria la ciudad del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].ciudad,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatoria la dirección del Adquirente "||contador,enviarDocumento.felCabezaDocumento.listaAdquirentes[contador].direccion,lb_hay_error) RETURNING lb_hay_error    
    END FOR

    --CALL Val_lista("Es requerida al menos una sección Impuesto",enviarDocumento.felCabezaDocumento.listaImpuestos.getLength(),lb_hay_error) RETURNING lb_hay_error
    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaImpuestos.getLength()
        CALL Val_obliga("Es obligatoria la base imponible del Impuesto "||contador,enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].baseimponible,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el codigo Impuesto Retencion del Impuesto "||contador,enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].codigoImpuestoRetencion,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el dato isAutoRetenido del Impuesto "||contador,enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].isAutoRetenido,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el porcentaje del Impuesto "||contador,enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].porcentaje,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el valor Impuesto Retencion del Impuesto "||contador,enviarDocumento.felCabezaDocumento.listaImpuestos[indice_Impuestos].valorImpuestoRetencion,lb_hay_error) RETURNING lb_hay_error
    END FOR
    
    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaFacturasModificadas.getLength()
        CALL Val_obliga("Es obligatorio el tipo Documento de la factura modificada "||contador,enviarDocumento.felCabezaDocumento.listaFacturasModificadas[contador].tipoDocumentoFacturaModificada,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el prefijo de la factura modificada "||contador,enviarDocumento.felCabezaDocumento.listaFacturasModificadas[contador].prefijoFacturaModificada,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el consecutivo de la factura modificada "||contador,enviarDocumento.felCabezaDocumento.listaFacturasModificadas[contador].consecutivoFacturaModificada,lb_hay_error) RETURNING lb_hay_error
    END FOR

    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaCargos.getLength()
        CALL Val_obliga("Es obligatorio el valor del Cargo "||contador,enviarDocumento.felCabezaDocumento.listaCargos[contador].valorCargo,lb_hay_error) RETURNING lb_hay_error
    END FOR

    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaDescuentos.getLength()
        CALL Val_obliga("Es obligatorio el descuento del Descuento "||contador,enviarDocumento.felCabezaDocumento.listaDescuentos[contador].descuento,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el porcentaje del Descuento "||contador,enviarDocumento.felCabezaDocumento.listaDescuentos[contador].porcentajeDescuento,lb_hay_error) RETURNING lb_hay_error
    END FOR

    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaDatosEntrega.getLength()
        CALL Val_obliga("Es obligatoria la cantidad del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].cantidad,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el cantidad Máxima del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].cantidadMaxima,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el cantidad Mínima del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].cantidadMinima,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el identificador Transporte del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].identificadorTransporte,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el pais del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].paisEntrega,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el tipoidentificacionTransportista del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].tipoidentificacionTransportista,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el identificacionTransportista del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].identificacionTransportista,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el dVIdentificaciontransportista del DatoEntrega "||contador,enviarDocumento.felCabezaDocumento.listaDatosEntrega[contador].dVIdentificaciontransportista,lb_hay_error) RETURNING lb_hay_error
    END FOR
    
    CALL Val_lista("Es requerida al menos una sección MediosPago",enviarDocumento.felCabezaDocumento.listaMediosPagos.getLength(),lb_hay_error) RETURNING lb_hay_error
    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaMediosPagos.getLength()
        CALL Val_obliga("Es obligatorio el Medio de Pago "||contador,enviarDocumento.felCabezaDocumento.listaMediosPagos[contador].medioPago,lb_hay_error) RETURNING lb_hay_error
    END FOR
    
    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaAnticipo.getLength()
        CALL Val_obliga("Es obligatorio el valor del Anticipo "||contador,enviarDocumento.felCabezaDocumento.listaAnticipo[contador].anticipo,lb_hay_error) RETURNING lb_hay_error
    END FOR

    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaCodigoBarras.getLength()
        CALL Val_obliga("Es obligatorio la cadena a codificar "||contador,enviarDocumento.felCabezaDocumento.listaCodigoBarras[contador].cadenaACodificar,lb_hay_error) RETURNING lb_hay_error
        CALL Val_obliga("Es obligatorio el tipo modelo "||contador,enviarDocumento.felCabezaDocumento.listaCodigoBarras[contador].tipoModelo,lb_hay_error) RETURNING lb_hay_error
    END FOR

    IF lb_hay_error THEN
        LET descripcionProceso = "Hay errores en validación de campos obligatorios."
    ELSE
        CALL DispapelesDoc.enviarDocumento_g() RETURNING wsstatus

        LET codigoQr = enviarDocumentoResponse.return.codigoQr
        LET consecutivo = enviarDocumentoResponse.return.consecutivo
        LET cufe = enviarDocumentoResponse.return.cufe
        LET descripcionProceso = enviarDocumentoResponse.return.descripcionProceso
        LET estadoProceso = enviarDocumentoResponse.return.estadoProceso
        LET fechaExpedicion = enviarDocumentoResponse.return.fechaExpedicion
        LET fechaFactura = enviarDocumentoResponse.return.fechaFactura
        LET fechaRespuesta = enviarDocumentoResponse.return.fechaRespuesta
        LET firmaDelDocumento = enviarDocumentoResponse.return.firmaDelDocumento
        LET idErp = enviarDocumentoResponse.return.idErp
        LET prefijo = enviarDocumentoResponse.return.prefijo
        LET selloDeValidacion = enviarDocumentoResponse.return.selloDeValidacion
        LET tipoDocumento = enviarDocumentoResponse.return.tipoDocumento
    END IF
    

    CALL f_LiberaAdjuntos()

    LET indice_cabeza = 0

    RETURN
     codigoQr
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

END FUNCTION

PRIVATE FUNCTION f_IniciaDocumentoCaptura()

    LET indice_Adquirentes = 0
    LET indice_Anticipo = 0
    LET indice_CamposAdicionales = 0
    LET indice_CamposAdicionales_salud = 0
    LET indice_Cargos = 0
    LET indice_CodigoBarras = 0
    LET indice_DatosEntrega = 0
    LET indice_Descuentos = 0
    LET indice_Detalle_CamposAdicionales = 0
    LET indice_Detalle_Cargos = 0
    LET indice_Detalle_CodigoBarras = 0
    LET indice_Detalle_Descuentos = 0
    LET indice_Detalle_Impuestos = 0
    LET indice_Detalle_Mandantes = 0
    LET indice_Detalle = 0
    LET indice_DocumentosAdjuntos = 0
    LET indice_FacturasModificadas = 0
    LET indice_Impuestos = 0
    LET indice_MediosPagos = 0
    LET indice_OrdenesCompras = 0
    LET indice_MensajesProceso = 0
    LET indice_Esquema = 0
    LET indice_Esquema_CamposAdicionales = 0

    LET indice_errores = 0

    --CALL enviarDocumento.felCabezaDocumento.listaDetalle.CLEAR()
    INITIALIZE enviarDocumento TO NULL
END FUNCTION

PRIVATE FUNCTION f_LiberaAdjuntos()
DEFINE contador INTEGER

    FOR contador = 1 TO enviarDocumento.felCabezaDocumento.listaDocumentosAdjuntos.getLength()
        FREE enviarDocumento.felCabezaDocumento.listaDocumentosAdjuntos[contador].contenidoDelDoc
    END FOR
    
END FUNCTION

PRIVATE FUNCTION Val_obliga(ls_texto,ls_dato,lb_hay_error_t)
DEFINE ls_dato,ls_texto STRING
DEFINE lb_hay_error_t BOOLEAN

    IF ls_dato IS NULL THEN
        LET indice_errores = indice_errores + 1
        LET enviarDocumentoResponse.return.listaMensajesProceso[indice_errores].descripcionMensaje = ls_texto
        LET enviarDocumentoResponse.return.listaMensajesProceso[indice_errores].rechazoNotificacion = "R"
        LET enviarDocumentoResponse.return.listaMensajesProceso[indice_errores].codigoMensaje = "PRE"
        RETURN TRUE
    ELSE 
        RETURN lb_hay_error_t
    END IF

END FUNCTION

PRIVATE FUNCTION Val_lista(ls_texto,ls_dato,lb_hay_error_t)
DEFINE ls_texto STRING
DEFINE ls_dato INTEGER
DEFINE lb_hay_error_t BOOLEAN

    IF ls_dato < 1 THEN
        LET indice_errores = indice_errores + 1
        LET enviarDocumentoResponse.return.listaMensajesProceso[indice_errores].descripcionMensaje = ls_texto
        LET enviarDocumentoResponse.return.listaMensajesProceso[indice_errores].rechazoNotificacion = "R"
        LET enviarDocumentoResponse.return.listaMensajesProceso[indice_errores].codigoMensaje = "PRE"
        RETURN TRUE
    ELSE 
        RETURN lb_hay_error_t
    END IF

END FUNCTION

PRIVATE FUNCTION Val_indice(ls_texto,ls_dato)
DEFINE ls_texto STRING
DEFINE ls_dato INTEGER

    IF ls_dato < 1 THEN
        DISPLAY "Error: ",ls_texto
        EXIT PROGRAM 1
    END IF

END FUNCTION

PRIVATE FUNCTION Val_detalle()

    CALL Val_indice("Error: No se ha llamado previamente la funcion f_DetalleDocumento_Agrega",indice_Detalle)

END FUNCTION

PRIVATE FUNCTION Val_cabeza()

    CALL Val_indice("Error: La primera funcion a invocar debe ser f_CabezaDocumento_Agrega",indice_cabeza)

END FUNCTION

PRIVATE FUNCTION Val_Esquema()

    CALL Val_indice("Error: No se ha llamado previamente la funcion f_Esquema_Agrega",indice_Esquema)

END FUNCTION

