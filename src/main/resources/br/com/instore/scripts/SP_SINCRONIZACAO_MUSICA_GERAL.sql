-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SINCRONIZACAO_MUSICA_GERAL`( 
__IDUSUARIO INT , 
__IDGRAVADORA INT , 
__TITULO VARCHAR(255) , 
__INTERPRETE VARCHAR(255) , 
__TIPO_INTERPRETE SMALLINT(6) , 
__TEMPO_TOTAL VARCHAR(30) ,
 __ANO_GRAVACAO INT , 
__AFINIDADE1 VARCHAR(255) , 
__AFINIDADE2 VARCHAR(255) ,
__AFINIDADE3 VARCHAR(255) , 
__AFINIDADE4 VARCHAR(255) ,
__ARQUIVO TEXT)
BEGIN
	IF  __IDUSUARIO IS NOT NULL
		AND __IDGRAVADORA IS NOT NULL
		AND __TITULO IS NOT NULL
		AND __INTERPRETE IS NOT NULL
		AND __TIPO_INTERPRETE IS NOT NULL
		AND __TEMPO_TOTAL IS NOT NULL
		AND __ANO_GRAVACAO IS NOT NULL
		AND __AFINIDADE1 IS NOT NULL
		AND __AFINIDADE2 IS NOT NULL
		AND __AFINIDADE3 IS NOT NULL
		AND __AFINIDADE4 IS NOT NULL
		AND __ARQUIVO IS NOT NULL
	THEN
		INSERT INTO musica_geral VALUES(NULL , 
										0 ,
										__IDUSUARIO , 
										__IDGRAVADORA , 
										__TITULO ,
										__INTERPRETE , 
										__TIPO_INTERPRETE , 
										'',
										120,
										__TEMPO_TOTAL ,
										__ANO_GRAVACAO , 
										__AFINIDADE1 , 
										__AFINIDADE2 , 
										__AFINIDADE3 , 
										__AFINIDADE4 , 
										__ARQUIVO);
	END IF;
END