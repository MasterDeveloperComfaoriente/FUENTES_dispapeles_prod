IMPORT FGL Enlace_DocEstado_bbl

MAIN
    CALL consumeConsultarEstado()
END MAIN

FUNCTION consumeConsultarEstado()
DEFINE
     codigoQr                             STRING 
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
   , codigoMensaje                        VARCHAR(50)
   , descripcionMensaje                   VARCHAR(240)
   , rechazoNotificacion                  VARCHAR(2)
   , prefijo                              VARCHAR(5) 
   , selloDeValidacion                    STRING 
   , tipoDocumento                        VARCHAR(1)
   , indice                               INTEGER


   --Genera el filtro para consultar el estado de una factura
   CALL Enlace_DocEstado_bbl.f_ConsultarEstado_Agrega(
          1            --consecutivo
        , "Pwc0mf40r1ent3" --contrasenia
        , 488             --idEmpresa
        , "SETT"          --prefijo
        , "1"              --tipoDocumento
        , "eaab450239c82b4efb6a0a894583d7aa5ffe886c" --token
        , "EmpCOMFAORIENTE" --usuario
        , "11" --version
   )

   --Recupera el resultado de la consulta del Estado de la factura
   CALL Enlace_DocEstado_bbl.f_RespuestaConsultarEstado_Recupera()
        RETURNING  codigoQr 
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

   DISPLAY "Mensaje de error: ", sqlca.sqlerrm
   DISPLAY "codigoQR      = ", codigoQr
   DISPLAY "codigoUltimoEstadoAdquirente      = ", codigoUltimoEstadoAdquirente
   DISPLAY "descripcionUltimoEstadoAdquirente = ", descripcionUltimoEstadoAdquirente

   --Se consultan todos los mensajes asociados a la respuesta al consumo del método "consultarEstado"
   FOR indice = 1 TO Enlace_DocEstado_bbl.f_RespuestaTamanoConsultarEstado_listaMensajes_Recupera()
      CALL f_RespuestaMensajesProceso_Recupera(indice)
             RETURNING  codigoMensaje
                      , descripcionMensaje
                      , rechazoNotificacion

      DISPLAY "Mensaje = ", descripcionMensaje
   END FOR

END FUNCTION