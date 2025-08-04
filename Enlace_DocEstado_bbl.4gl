#+ Consulta el estado de un documento.
#+
#+ Enlace con servicio web de Dispapeles para
#+ la consulta del estado de un documento de factura electrónica.

IMPORT FGL DispapelesDocEstado

GLOBALS "DispapelesDocEstado.inc"
GLOBALS
DEFINE indice_errores INTEGER
END GLOBALS

#+ Genera el filtro para consultar el estado de una factura.
#+
#+ Genera la información que será utilizada para filtrar la factura, de la cual se desea conocer su estado.
#+
#+ @code
#+ CALL f_ConsultaEstado_Agrega(
#+         123--consecutivo
#+    ,"Texto"--contrasenia
#+    ,    123--idEmpresa
#+    ,"Texto"--prefijo
#+    ,"Texto"--tipoDocumento
#+    ,"Texto"--token
#+    ,"Texto"--usuario
#+    ,"Texto"--version
#+ )
#+
#+ @param consecutivo  NÚMERO DE CONSECUTIVO DE LA FACTURA.
#+ @param contrasenia  CONTRASEÑA. CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA.
#+ @param idEmpresa ID. DE EMPRESA. CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA.
#+ @param prefijo PREFIJO DEL DOCUMENTO.
#+ @param tipoDocumento TIPO DE DOCUMENTO ELECTRÓNICO.
#+ @param token TOKEN. CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA.   
#+ @param usuario USUARIO. CAMPOS PARA VALIDAR LA SEGURIDAD. ESTOS VALORES SON ENTREGADOS POR DISPAPELES A CADA EMPRESA FACTURADORA.
#+ @param version VERSIÓN DEL MANUAL CON LA QUE EL CLIENTE TRABAJÓ LA INTEGRACIÓN.
#+
#+ @return Sin_regreso
#+
FUNCTION f_ConsultarEstado_Agrega(
               consecutivo
             , contrasenia
             , idEmpresa
             , prefijo
             , tipoDocumento
             , token
             , usuario
             , version
)
DEFINE
     consecutivo   BIGINT
   , contrasenia   VARCHAR(40)
   , idEmpresa     BIGINT
   , prefijo       VARCHAR(5)
   , tipoDocumento VARCHAR(1)
   , token         VARCHAR(40)
   , usuario       VARCHAR(40)
   , version       VARCHAR(40)

   --Inicialización de variables
   LET consultarEstado.felConsultaFactura.consecutivo   = consecutivo
   LET consultarEstado.felConsultaFactura.contrasenia   = contrasenia
   LET consultarEstado.felConsultaFactura.idEmpresa     = idEmpresa
   LET consultarEstado.felConsultaFactura.prefijo       = prefijo
   LET consultarEstado.felConsultaFactura.tipoDocumento = tipoDocumento
   LET consultarEstado.felConsultaFactura.token         = token
   LET consultarEstado.felConsultaFactura.usuario       = usuario
   LET consultarEstado.felConsultaFactura.version       = version

   LET indice_errores = 0
   
END FUNCTION

#+ Recupera un registro de respuesta.
#+
#+ Recupera un registro de respuesta correspondiente al consumo del método ConsultarEstado.
#+
#+ @code
#+ CALL f_RespuestaConsultarEstado_Recupera()
#+  RETURNING
#+     codigoQr
#+    ,codigoUltimoEstadoAdquirente 
#+    ,codigoUltimoEstadoDian 
#+    ,codigoUltimoEstadoDispapeles 
#+    ,codigoUltimoEstadoEmail 
#+    ,consecutivo
#+    ,cufe
#+    ,descripcionUltimoEstadoAdquirente 
#+    ,descripcionUltimoEstadoDian 
#+    ,descripcionUltimoEstadoDispapeles 
#+    ,descripcionUltimoEstadoEmail 
#+    ,estadoProceso
#+    ,fechaFactura
#+    ,fechaRespuesta
#+    ,fechaRespuestaUltimoEstadoAdquirente
#+    ,fechaRespuestaUltimoEstadoDian
#+    ,fechaRespuestaUltimoEstadoDispapeles
#+    ,fechaRespuestaUltimoEstadoEmail
#+    ,firmaDelDocumento
#+    ,idErp
#+    ,idLote
#+    ,prefijo
#+    ,selloDeValidacion
#+    ,tipoDocumento
#+
#+ @return codigoQr CÓDIGO QR.
#+ @return codigoUltimoEstadoAdquirente CÓDIGO DEL ESTADO DEL DOCUMENTO CON RELACIÓN AL ADQUIRENTE. ESTOS CÓDIGOS SON INTERNOS DE DISPAPELES.  
#+ @return codigoUltimoEstadoDian SE DEVUELVE EL CÓDIGO QUE MANEJA LA DIAN PARA DICHOS ESTADOS. 
#+ @return codigoUltimoEstadoDispapeles CÓDIGO DE DISPAPELES PARA IDENTIFICAR CADA FASE DE LA CREACIÓN DEL DOCUMENTO.
#+ @return codigoUltimoEstadoEmail SE DEVUELVE EL CÓDIGO DE LOS ESTADOS DEL ENVÍO.
#+ @return consecutivo  NÚMERO CONSECUTIVO DE LA FACTURA.
#+ @return cufe CUFE DE LA FACTURA.
#+ @return descripcionUltimoEstadoAdquirente DESCRIPCIÓN DEL ESTADO DEL DOCUMENTO POR PARTE DEL ADQUIRENTE, ES DECIR, SI SE ACUSÓ EL RECIBO, SE ACEPTÓ O RECHAZÓ.
#+ @return descripcionUltimoEstadoDian CAMPO QUE DESCRIBE EL ÚLTIMO ESTADO DEL DOCUMENTO ANTE LA DIAN, ES DECIR, SI SE RECIBIÓ EL ENVÍO Y SI PASÓ O NO LAS VALIDACIONES.
#+ @return descripcionUltimoEstadoDispapeles SE DEVUELVE EL ULTIMO ESTADO DEL DOCUMENTO EN LA PLATAFORMA DE DISPAPELES, ESTO ES, SI PASA O NO LAS VALIDACIONES INTERNAS, SI SE GENERA Y FIRMA EL XML, SI SE GENERA LA REPRESENTACIÓN Y SI SE PRESENTA UN ERROR EN CUALQUIERA DE ESAS ETAPAS.
#+ @return descripcionUltimoEstadoEmail CAMPO QUE DESCRIBE EL ÚLTIMO ESTADO DEL DOCUMENTO EN EL PROCESO DE ENVÍO POR EMAIL.
#+ @return estadoProceso 0 = ERROR; 1 = EXITOSO; 2 = EXITOSO CON NOTIFICACIONES; 3 = DOCUMENTO INGRESADO PREVIAMENTE; 4 = EL DOCUMENTO ESTÁ SIENDO PROCESADO; 24 = CONTINGENCIA DIAN
#+ @return fechaFactura FECHA EN QUE SE CREÓ EL DOCUMENTO EN EL ERP DEL FACTURADOR.
#+ @return fechaRespuesta FECHA Y HORA DE LA RESPUESTA LA CONSULTA.
#+ @return fechaRespuestaUltimoEstadoAdquirente FECHA Y HORA DE LA PULTIMA MODIFICACIÓN AL ESTADO DEL DOCUMENTO CON RELACIÓN AL ADQUIRENTE. ESTA FECHA ES INTERNA DE DISPAPELES. 
#+ @return fechaRespuestaUltimoEstadoDian FECHA EN LA QUE CONTESTÓ LA DIAN.
#+ @return fechaRespuestaUltimoEstadoDispapeles FECHA Y HORA DE LA ÚLTIMA MODIFICACIÓN, POR PARTE DE DISPAPELES, AL DOCUMENTO.
#+ @return fechaRespuestaUltimoEstadoEmail FECHA EN LA QUE SE ENVÍA EL EMAIL.
#+ @return firmaDelDocumento FIRMA DEL DOCUMENTO EN CASO TAL EL CLIENTE LO REQUIERA PARA CONTROL INTERNO.
#+ @return idErp CÓDIGO INTERNO QUE IDENTIFICA LA FACTURA EN EL ERP.
#+ @return idLote DENTIFICADOR DEL LOTE AL QUE PERTENECE LA FACTURA, APLICA SOLO SI LA FACTURACIÓN ES POR LOTE.
#+ @return prefijo PREFIJO DEL DOCUMENTO.
#+ @return selloDeValidacion FIRMA DE VALIDACIÓN POR PARTE DE LA DIAN, SE DEVUELVE PARA CONTROL INTERNO DEL CLIENTE.
#+ @return tipoDocumento TIPO DE DOCUMENTO ELECTRÓNICO.
#+
FUNCTION f_RespuestaConsultarEstado_Recupera()
DEFINE
     wsstatus                             INTEGER
   , codigoQr                             STRING 
   , codigoUltimoEstadoAdquirente         INTEGER 
   , codigoUltimoEstadoDian               INTEGER 
   , codigoUltimoEstadoDispapeles         INTEGER 
   , codigoUltimoEstadoEmail              INTEGER 
   , consecutivo                          BIGINT 
   , cufe                                 VARCHAR(240) 
   , descripcionUltimoEstadoAdquirente    VARCHAR(240) 
   , descripcionUltimoEstadoDian          VARCHAR(240) 
   , descripcionUltimoEstadoDispapeles    VARCHAR(240) 
   , descripcionUltimoEstadoEmail         VARCHAR(240) 
   , estadoProceso                        INTEGER 
   , fechaFactura                         DATETIME YEAR TO FRACTION(5) 
   , fechaRespuesta                       DATETIME YEAR TO FRACTION(5) 
   , fechaRespuestaUltimoEstadoAdquirente DATETIME YEAR TO FRACTION(5) 
   , fechaRespuestaUltimoEstadoDian       DATETIME YEAR TO FRACTION(5) 
   , fechaRespuestaUltimoEstadoDispapeles DATETIME YEAR TO FRACTION(5) 
   , fechaRespuestaUltimoEstadoEmail      DATETIME YEAR TO FRACTION(5) 
   , firmaDelDocumento                    STRING 
   , idErp                                VARCHAR(240) 
   , idLote                               VARCHAR(240) 
   , prefijo                              VARCHAR(5) 
   , selloDeValidacion                    STRING 
   , tipoDocumento                        VARCHAR(1)

   ,lb_hay_error BOOLEAN

    LET lb_hay_error = FALSE

    CALL Val_obliga("Es obligatorio el consecutivo",consultarEstado.felConsultaFactura.consecutivo,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatoria la contraseña",consultarEstado.felConsultaFactura.contrasenia,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el id de la empresa ",consultarEstado.felConsultaFactura.idEmpresa,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el tipo de documento",consultarEstado.felConsultaFactura.tipodocumento,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el token",consultarEstado.felConsultaFactura.token,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatorio el usuario",consultarEstado.felConsultaFactura.usuario,lb_hay_error) RETURNING lb_hay_error
    CALL Val_obliga("Es obligatoria la versión",consultarEstado.felConsultaFactura.version,lb_hay_error) RETURNING lb_hay_error

    IF lb_hay_error THEN
        LET descripcionUltimoEstadoDispapeles = "Hay errores en validación de campos obligatorios."
       RETURN  codigoQr 
             , codigoUltimoEstadoAdquirente 
             , codigoUltimoEstadoDian 
             , codigoUltimoEstadoDispapeles 
             , codigoUltimoEstadoEmail 
             , consecutivo 
             , cufe 
             , descripcionUltimoEstadoAdquirente 
             , descripcionUltimoEstadoDian 
             , descripcionUltimoEstadoDispapeles 
             , descripcionUltimoEstadoEmail 
             , estadoProceso 
             , fechaFactura 
             , fechaRespuesta 
             , fechaRespuestaUltimoEstadoAdquirente 
             , fechaRespuestaUltimoEstadoDian 
             , fechaRespuestaUltimoEstadoDispapeles 
             , fechaRespuestaUltimoEstadoEmail 
             , firmaDelDocumento 
             , idErp 
             , idLote 
             , prefijo 
             , selloDeValidacion 
             , tipoDocumento

    END IF
   
   --Se ejecuta el WS
   CALL DispapelesDocEstado.consultarEstado_g() RETURNING wsstatus
  
   --Inicialización de variables
   LET codigoQr                             = consultarEstadoResponse.return.codigoQr
   LET codigoUltimoEstadoAdquirente         = consultarEstadoResponse.return.codigoUltimoEstadoAdquirente
   LET codigoUltimoEstadoDian               = consultarEstadoResponse.return.codigoUltimoEstadoDian
   LET codigoUltimoEstadoDispapeles         = consultarEstadoResponse.return.codigoUltimoEstadoDispapeles
   LET codigoUltimoEstadoEmail              = consultarEstadoResponse.return.codigoUltimoEstadoEmail
   LET consecutivo                          = consultarEstadoResponse.return.consecutivo
   LET cufe                                 = consultarEstadoResponse.return.cufe
   LET descripcionUltimoEstadoAdquirente    = consultarEstadoResponse.return.descripcionUltimoEstadoAdquirente
   LET descripcionUltimoEstadoDian          = consultarEstadoResponse.return.descripcionUltimoEstadoDian
   LET descripcionUltimoEstadoDispapeles    = consultarEstadoResponse.return.descripcionUltimoEstadoDispapeles
   LET descripcionUltimoEstadoEmail         = consultarEstadoResponse.return.descripcionUltimoEstadoEmail
   LET estadoProceso                        = consultarEstadoResponse.return.estadoProceso
   LET fechaFactura                         = consultarEstadoResponse.return.fechaFactura
   LET fechaRespuesta                       = consultarEstadoResponse.return.fechaRespuesta
   LET fechaRespuestaUltimoEstadoAdquirente = consultarEstadoResponse.return.fechaRespuestaUltimoEstadoAdquirente
   LET fechaRespuestaUltimoEstadoDian       = consultarEstadoResponse.return.fechaRespuestaUltimoEstadoDian
   LET fechaRespuestaUltimoEstadoDispapeles = consultarEstadoResponse.return.fechaRespuestaUltimoEstadoDispapeles
   LET fechaRespuestaUltimoEstadoEmail      = consultarEstadoResponse.return.fechaRespuestaUltimoEstadoEmail
   LET firmaDelDocumento                    = consultarEstadoResponse.return.firmaDelDocumento
   LET idErp                                = consultarEstadoResponse.return.idErp
   LET idLote                               = consultarEstadoResponse.return.idLote
   LET prefijo                              = consultarEstadoResponse.return.prefijo
   LET selloDeValidacion                    = consultarEstadoResponse.return.selloDeValidacion
   LET tipoDocumento                        = consultarEstadoResponse.return.tipoDocumento

   RETURN  codigoQr 
         , codigoUltimoEstadoAdquirente 
         , codigoUltimoEstadoDian 
         , codigoUltimoEstadoDispapeles 
         , codigoUltimoEstadoEmail 
         , consecutivo 
         , cufe 
         , descripcionUltimoEstadoAdquirente 
         , descripcionUltimoEstadoDian 
         , descripcionUltimoEstadoDispapeles 
         , descripcionUltimoEstadoEmail 
         , estadoProceso 
         , fechaFactura 
         , fechaRespuesta 
         , fechaRespuestaUltimoEstadoAdquirente 
         , fechaRespuestaUltimoEstadoDian 
         , fechaRespuestaUltimoEstadoDispapeles 
         , fechaRespuestaUltimoEstadoEmail 
         , firmaDelDocumento 
         , idErp 
         , idLote 
         , prefijo 
         , selloDeValidacion 
         , tipoDocumento
         
END FUNCTION


#+ Recuperar mensaje.
#+
#+ Recupera un mensaje al resultado de la consulta del estado de una factura.
#+
#+ @code
#+ CALL f_RespuestaMensajesProceso_Recupera(
#+     indice  --Número de mensaje a recuperar 
#+ ) RETURNING
#+     codigoMensaje
#+    ,descripcionMensaje
#+    ,rechazoNotificacion
#+
#+ @param indice NÚMERO DE MENSAJE A RECUPERAR
#+
#+ @return codigoMensaje IDENTIFICADOR DEL MENSAJE.  
#+ @return descripcionMensaje CAMPO QUE DESCRIBE LOS MENSAJES DE ERROR ASOCIADOS AL DOCUMENTO
#+ @return rechazoNotificacion CAMPO QUE DESCRIBE SI LA VALIDACIÓN ES DE TIPO RECHAZO (R) O NOTIFICACIÓN (N)
#+
FUNCTION f_RespuestaMensajesProceso_Recupera(
            indice 
)
DEFINE
     indice              INTEGER 
   , codigoMensaje       VARCHAR(50)
   , descripcionMensaje  VARCHAR(240)
   , rechazoNotificacion VARCHAR(2)

   --Inicializacón de variables
   INITIALIZE  codigoMensaje
             , descripcionMensaje
             , rechazoNotificacion TO NULL
   IF ( indice > 0 AND  consultarEstadoResponse.return.listaMensajesProceso.getLength() > 0) THEN
      LET codigoMensaje       = consultarEstadoResponse.return.listaMensajesProceso[indice].codigoMensaje
      LET descripcionMensaje  = consultarEstadoResponse.return.listaMensajesProceso[indice].descripcionMensaje
      LET rechazoNotificacion = consultarEstadoResponse.return.listaMensajesProceso[indice].rechazoNotificacion
   END IF  

   RETURN  codigoMensaje
         , descripcionMensaje
         , rechazoNotificacion

END FUNCTION

#+ Recupera número de mensajes.
#+
#+ Regresa el número de mensajes asociados a la consulta del estado de una factura.
#+
#+ @code
#+ CALL f_RespuestaTamanoConsultarEstado_listaMensajes_Recupera() 
#+     RETURNING tamano
#+
#+ @return tamano  NÚMERO DE MENSAJES ASOCIADOS A LA CONSULTA DEL ESTADO DE UNA FACTURA. 
#+
FUNCTION f_RespuestaTamanoConsultarEstado_listaMensajes_Recupera()
DEFINE
     tamano      INTEGER
   
   --Inicialización de variables
   LET tamano = consultarEstadoResponse.return.listaMensajesProceso.getLength()

   RETURN tamano

END FUNCTION

PRIVATE FUNCTION Val_obliga(ls_texto,ls_dato,lb_hay_error_t)
DEFINE ls_dato,ls_texto STRING
DEFINE lb_hay_error_t BOOLEAN

    IF ls_dato IS NULL THEN
        LET indice_errores = indice_errores + 1
        LET consultarEstadoResponse.return.listaMensajesProceso[indice_errores].descripcionMensaje = ls_texto
        LET consultarEstadoResponse.return.listaMensajesProceso[indice_errores].rechazoNotificacion = "R"
        LET consultarEstadoResponse.return.listaMensajesProceso[indice_errores].codigoMensaje = "PRE"
        RETURN TRUE
    ELSE 
        RETURN lb_hay_error_t
    END IF

END FUNCTION

