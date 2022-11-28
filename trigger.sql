-- Create trigger for id KhachHang
-- CREATE TRIGGER id_KhachHang 
-- 	BEFORE INSERT ON 
--
CREATE TABLE Max_ID(
	ID_ChiNhanh INT UNSIGNED,
    ID_KhachHang INT(6) ZEROFILL UNSIGNED,
    ID_DatPhong INT(6) ZEROFILL UNSIGNED
);

CREATE PROCEDURE last_ID(
	IN nameTable VARCHAR(15)
)
BEGIN
	SELECT concat("ID_", nameTable) FROM nameTable
    WHERE 
END;
  

DROP PROCEDURE IF EXISTS proc_IdInsert;
DELIMITER $$ ;
CREATE PROCEDURE proc_triggerId(
	IN prefix CHAR(2),
    IN nameTable VARCHAR(15),
    IN nameTrigger VARCHAR(10)
)
-- BEGIN
-- 	CREATE TRIGGER triggger_name
--     BEFORE INSERT ON nameTable FOR EACH ROW
-- 		BEGIN
-- 			INSERT NEW.V
--         END
-- END;

