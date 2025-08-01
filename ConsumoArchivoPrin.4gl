IMPORT FGL Enlace_Archivo_bbl

MAIN

    CALL consumeConsultarArchivos()
    --CALL consumeBorrarRegistrosIA()
    --CALL consumeConsultarRegistrosIA()
    --CALL consumeConsultarRegistrosIAManual()
END MAIN


FUNCTION consumeConsultarArchivos()
DEFINE 
     formato               VARCHAR(4)
   , mimeType              VARCHAR(240)
   , nameFile              VARCHAR(240)
   , streamFile            STRING 

   , codigoMensaje         VARCHAR(50)
   , descripcionMensaje    VARCHAR(240)
   , rechazoNotificacion   VARCHAR(2)

   , indice               INTEGER
   , codigoRespuesta      INTEGER
   , consecutivo          BIGINT
   , descripcionRespuesta VARCHAR(240)
   , estadoProceso        INTEGER
   , idErp                VARCHAR(240)
   , prefijo              VARCHAR(5) 
   , tipoDocumento        VARCHAR(1)

   --Inicializa la información para llevar a cabo la consulta de archivos
   CALL Enlace_Archivo_bbl.f_consultarFacturaArchivo_Agrega(
     46      --consecutivo  
   , "Pwc0mf40r1ent3"     --contrasenia  
   , 488    --idEmpresa  
   , "SETT" --prefijo  
   , 0      --tipoArchivo  
   , "1"     --tipoDocumento  
   , "eaab450239c82b4efb6a0a894583d7aa5ffe886c"     --token  
   , "EmpCOMFAORIENTE"     --usuario  
   , "11"     --version 
   )

   --Recupera la información referente a la consulta de archivos
   CALL Enlace_Archivo_bbl.f_RespuestaDescargaDocumentos_Recupera()
        RETURNING  codigoRespuesta
                 , consecutivo         
                 , descripcionRespuesta 
                 , estadoProceso        
                 , idErp                
                 , prefijo              
                 , tipoDocumento

   DISPLAY "Código de error       = ", SQLCA.sqlerrm
   DISPLAY "Codigo Respuesta      = ", codigoRespuesta
   DISPLAY "Descripción respuesta = ", descripcionRespuesta

   
   --Recupera todos los mensajes resultantes de la consulta
   FOR indice = 1 TO Enlace_Archivo_bbl.f_RespuestaTamanoConsultarArchivos_listaMensajes_Recupera()
      CALL Enlace_Archivo_bbl.f_RespuestaMensajesProcesoArchivo_Recupera(indice)
           RETURNING codigoMensaje
                   , descripcionMensaje
                   , rechazoNotificacion

      DISPLAY "Mensaje = ", descripcionMensaje
   END FOR

   --Recupera todos los archivos resultantes de la consulta
   FOR indice = 1 TO Enlace_Archivo_bbl.f_RespuestaTamanoConsultarArchivos_listaArchivos_Recupera()
      CALL Enlace_Archivo_bbl.f_RespuestaArchivos_Recupera(indice)
           RETURNING  formato
                    , mimeType
                    , nameFile
                    , streamFile

      DISPLAY "Archivo = ", nameFile
   END FOR
   
   --Guarda todos los archivos resultantes de la consulta
   CALL Enlace_Archivo_bbl.f_ConsultarArchivos_Guardar("c:\\Puerto\\")
   
END FUNCTION   

FUNCTION consumeBorrarRegistrosIA()
DEFINE
     indice               INTEGER
   , codigoRespuesta      INTEGER
   , consecutivo          BIGINT
   , descripcionRespuesta VARCHAR(240)
   , estadoProceso        INTEGER
   , idErp                VARCHAR(240)
   , formato              VARCHAR(4)
   , mimeType             VARCHAR(240)
   , nameFile             VARCHAR(240)
   , streamFile           STRING
   , codigoMensaje        VARCHAR(50)
   , descripcionMensaje   VARCHAR(240)
   , rechazoNotificacion  VARCHAR(2)
   , prefijo              VARCHAR(5) 
   , tipoDocumento        VARCHAR(1)


   --Inicializa la información para llevar a cabo la eliminación de registros IA
   CALL Enlace_Archivo_bbl.f_borrarRegistrosIA_Agrega(
         1      --consecutivo  
       , "Pwc0mf40r1ent3"     --contrasenia  
       , 488    --idEmpresa  
       , "SETT" --prefijo  
       , 3      --tipoArchivo  
       , "1"     --tipoDocumento  
       , "eaab450239c82b4efb6a0a894583d7aa5ffe886c"     --token  
       , "EmpCOMFAORIENTE"     --usuario  
       , "11"     --version 
   )
   
   --Recupera la respuesta del WS
   CALL Enlace_Archivo_bbl.f_RespuestaBorrarRegistrosIA_Recupera()
        RETURNING  codigoRespuesta
                 , consecutivo         
                 , descripcionRespuesta 
                 , estadoProceso        
                 , idErp                
                 , prefijo              
                 , tipoDocumento
        
   DISPLAY "Código de error       = ", SQLCA.sqlerrm
   DISPLAY "Codigo Respuesta      = ", codigoRespuesta
   DISPLAY "Descripción respuesta = ", descripcionRespuesta

   --Recupera todos los mensajes restantes después de la eliminación de registros IA
   FOR indice = 1 TO Enlace_Archivo_bbl.f_RespuestaTamanoBorrarRegistrosIA_listaMensajes_Recupera()
      CALL Enlace_Archivo_bbl.f_RespuestaBorrarRegistrosIAMensajes_Recupera(indice)
           RETURNING codigoMensaje
                   , descripcionMensaje
                   , rechazoNotificacion

      DISPLAY "Mensaje = ", descripcionMensaje
   END FOR        

   --Recupera todos los archivos restantes después de la eliminación de registros IA
   FOR indice = 1 TO Enlace_Archivo_bbl.f_RespuestaTamanoBorrarRegistrosIA_listaArchivos_Recupera()
      CALL Enlace_Archivo_bbl.f_RespuestaBorrarRegistrosIAArchivos_Recupera(indice)
           RETURNING  formato
                    , mimeType
                    , nameFile
                    , streamFile

      DISPLAY "Archivo = ", nameFile
   END FOR        

   --Guarda todos los archivos resultantes de la consulta
   CALL Enlace_Archivo_bbl.f_BorrarRegistrosIA_Guardar("c:\\Puerto\\")

END FUNCTION

FUNCTION consumeConsultarRegistrosIA()
DEFINE
      wsstatus       INTEGER
    , indice         INTEGER 
    , resultado      VARCHAR(255)  


    --Inicializa la información para llevar a cabo la consulta de registros IA
    CALL Enlace_Archivo_bbl.f_consultarRegistrosIA_Agrega(
         1      --consecutivo  
       , "Pwc0mf40r1ent3"     --contrasenia  
       , 488    --idEmpresa  
       , "SETT" --prefijo  
       , 1      --tipoArchivo  
       , "1"     --tipoDocumento  
       , "eaab450239c82b4efb6a0a894583d7aa5ffe886c"     --token  
       , "EmpCOMFAORIENTE"     --usuario  
       , "11"     --version 
    )

    --Consume el WS
    CALL Enlace_Archivo_bbl.f_RegistrosIA_Recupera() RETURNING wsstatus

   DISPLAY "Código de error:  ", SQLCA.sqlerrm

   
   FOR indice = 1 TO Enlace_Archivo_bbl.f_RespuestaTamanoConsultarRegistrosIA_Recupera()
      CALL Enlace_Archivo_bbl.f_RespuestaConsultarRegistrosIA_Recupera(indice)
           RETURNING resultado
      DISPLAY "Resultado = ", resultado
   END FOR     
   
END FUNCTION

FUNCTION consumeConsultarRegistrosIAManual()
DEFINE
      wsstatus       INTEGER
    , indice         INTEGER 
    , resultado      VARCHAR(255)  

    --Inicializa la información para llevar a cabo la consulta de un rango de facturas.
    CALL Enlace_Archivo_bbl.f_ConsultarRegistrosIAManual_Agrega(
                  999            --consecutivoFinal
             ,    123            --consecutivoInicial
             ,"1992-01-01 00:00" --fechaFinal
             ,"1990-01-01 00:00" --fechaIncial
             ,    488            --idEmpresa
             ,"Texto"            --numeroIdentificacion
             ,"SETT"             --prefijo
    )

    --Consume el WS
    CALL Enlace_Archivo_bbl.f_RegistrosIAManual_Recupera() RETURNING wsstatus

   DISPLAY "Código de error:  ", SQLCA.sqlerrm

   FOR indice = 1 TO Enlace_Archivo_bbl.f_RespuestaTamanoConsultarRegistrosIAManual_Recupera()
      CALL Enlace_Archivo_bbl.f_RespuestaConsultarRegistrosIAManual_Recupera(indice)
           RETURNING resultado
      DISPLAY "Resultado = ", resultado
   END FOR
   
END FUNCTION