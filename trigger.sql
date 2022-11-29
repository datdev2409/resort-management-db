DROP TABLE IF EXISTS ChiNhanh_ID;
CREATE TABLE ChiNhanh_ID (
    ID INT AUTO_INCREMENT PRIMARY KEY
);

DROP TRIGGER IF EXISTS before_chinhanh_insert;
DELIMITER %%
CREATE TRIGGER before_chinhanh_insert BEFORE INSERT ON ChiNhanh
	FOR EACH ROW
	BEGIN
		INSERT INTO ChiNhanh_ID () VALUES ();
    SET NEW.MaChiNhanh = CONCAT ("CN", LAST_INSERT_ID());
	END %%

DELIMITER ;

DROP TABLE IF EXISTS LoaiVatTu_ID;
CREATE TABLE IF NOT EXISTS LoaiVatTu_ID (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DELIMITER %%
CREATE TRIGGER before_loaivattu_insert BEFORE INSERT ON LoaiVatTu
	FOR EACH ROW
		BEGIN
			INSERT INTO LoaiVatTu_ID VALUE ();
			SET NEW.MaLoaiVatTu = CONCAT ("VT", LPAD(LAST_INSERT_ID(), 4, "0"));
		END %%
	
DELIMITER ;

DROP TABLE IF EXISTS NhaCungCap_ID;
CREATE TABLE IF NOT EXISTS NhaCungCap_ID (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DELIMITER %%
CREATE TRIGGER before_nhacungcap_insert BEFORE INSERT ON NhaCungCap
	FOR EACH ROW
		BEGIN
			INSERT INTO NhaCungCap_ID VALUE ();
      SET NEW.MaNhaCungCap = CONCAT ("NCC", LPAD(LAST_INSERT_ID(), 4, "0"));
    END %%
	
DELIMITER ;

DROP TABLE IF EXISTS KhachHang_ID;
CREATE TABLE IF NOT EXISTS KhachHang_ID (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

DROP TRIGGER IF EXISTS before_khachhang_insert;
DELIMITER %%
CREATE TRIGGER before_khachhang_insert BEFORE INSERT ON KhachHang
FOR EACH ROW
	BEGIN
		INSERT INTO KhachHang_ID VALUE ();
		SET NEW.MaKhachHang = CONCAT("KH", LPAD(LAST_INSERT_ID(), 6, "0"));
		IF NEW.Diem < 50 THEN SET NEW.Loai = 1;
        ELSEIF NEW.Diem < 100 THEN SET NEW.Loai = 2;
        ELSEIF NEW.Diem < 1000 THEN SET NEW.Loai = 3;
        ELSE SET NEW.Loai = 4;
        END IF;
    END %%
	
DELIMITER ;

DROP TABLE IF EXISTS DonDatPhong_ID;
CREATE TABLE IF NOT EXISTS DonDatPhong_ID (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

DROP TRIGGER IF EXISTS before_dondatphong_insert; 
DELIMITER %%
CREATE TRIGGER before_dondatphong_insert BEFORE INSERT ON DonDatPhong
FOR EACH ROW
	BEGIN
		INSERT INTO DonDatPhong_ID VALUE ();
		SET NEW.MaDatPhong = CONCAT("DP", DATE_FORMAT(NEW.NgayGioDat, '%d%m%Y'), LPAD(LAST_INSERT_ID(), 6, '0'));
	END %%
DELIMITER ;

DROP TABLE IF EXISTS HoaDon_ID;
CREATE TABLE IF NOT EXISTS HoaDon_ID (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);


DROP TRIGGER IF EXISTS before_hoadon_insert; 
DELIMITER %%
CREATE TRIGGER before_hoadon_insert BEFORE INSERT ON HoaDon
FOR EACH ROW
	BEGIN
		INSERT INTO HoaDon_ID VALUE ();
		SET NEW.MaHoaDon = CONCAT("HD", DATE_FORMAT(NOW(), '%d%m%Y'), LPAD(LAST_INSERT_ID(), 6, '0'));
	END %%
DELIMITER ;

DROP TABLE IF EXISTS DoanhNghiep_ID;
CREATE TABLE IF NOT EXISTS DoanhNghiep_ID(
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DROP TRIGGER IF EXISTS before_doanhnghiep_insert;
DELIMITER %%
CREATE TRIGGER before_doanhnghiep_insert BEFORE INSERT ON DoanhNghiep
FOR EACH ROW
	BEGIN
		INSERT INTO DoanhNghiep_ID VALUE ();
        SET NEW.MaDoanhNghiep = CONCAT("DN", LPAD(LAST_INSERT_ID(), 4, '0'));
    END %%
    
DELIMITER ;

DROP TABLE IF EXISTS DichVu_ID;
CREATE TABLE IF NOT EXISTS DichVu_ID(
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DROP TRIGGER IF EXISTS before_dichvu_insert;
DELIMITER %%
CREATE TRIGGER before_dichvu_insert BEFORE INSERT ON DichVu
FOR EACH ROW
	BEGIN
		INSERT INTO DichVu_ID VALUE ();
		SET NEW.MaDichVu = CONCAT("DV", NEW.LoaiDichVu, LPAD(LAST_INSERT_ID(), 3, '0'));
	END %%
    
DELIMITER ;


-- ########################### TRIGGER AUTO ADD POINT FOR CUSTOMER #############################################
DROP PROCEDURE IF EXISTS addBonusPoint;
DELIMITER %%
CREATE PROCEDURE addBonusPoint(IN MaKhachHang VARCHAR(8), IN TongTien INT)
BEGIN
	DECLARE OLD_SCORE INT DEFAULT 0;
    DECLARE BONUS INT DEFAULT 0;
    DECLARE NEW_SCORE INT DEFAULT 0;
	SET OLD_SCORE = 0;
    SET BONUS = TongTien DIV 1000;
	SELECT Diem INTO OLD_SCORE FROM KhachHang WHERE KhachHang.MaKhachHang = MaKhachHang LIMIT 1;
	SET NEW_SCORE = OLD_SCORE + BONUS;
    UPDATE KhachHang SET Diem = NEW_SCORE WHERE KhachHang.MaKhachHang = MaKhachHang;
	
    IF NEW_SCORE < 50 THEN 
		UPDATE KhachHang SET Loai = 1 WHERE KhachHang.MaKhachHang = MaKhachHang;

    ELSEIF NEW_SCORE < 100 THEN
		UPDATE KhachHang SET Loai = 2 WHERE KhachHang.MaKhachHang = MaKhachHang;
        
    ELSEIF NEW_SCORE < 1000 THEN
		UPDATE KhachHang SET Loai = 3 WHERE KhachHang.MaKhachHang = MaKhachHang;
        
    ELSE UPDATE KhachHang SET Loai = 4 WHERE KhachHang.MaKhachHang = MaKhachHang;
    END IF;
END %%
DELIMITER ;


DROP TRIGGER IF EXISTS after_dondatphong_thanhtoan;
DELIMITER %%
CREATE TRIGGER after_dondatphong_thanhtoan BEFORE UPDATE ON DonDatPhong
FOR EACH ROW
	BEGIN
		IF OLD.TinhTrang = 1 AND NEW.TinhTrang = 2 THEN
			CALL addBonusPoint(NEW.MaKhachHang, NEW.TongTien);
        END IF;
    
    END %%
DELIMITER ;

DROP TRIGGER IF EXISTS after_dondatphong_insert;
DELIMITER %%
CREATE TRIGGER after_dondatphong_insert BEFORE INSERT ON DonDatPhong
FOR EACH ROW
	BEGIN
		IF NEW.TinhTrang = 2 THEN CALL addBonusPoint(NEW.MaKhachHang, NEW.TongTien);
        END IF;
    END %%
DELIMITER ;


DROP TRIGGER IF EXISTS add_point_when_buy_package;
DELIMITER %%
CREATE TRIGGER add_point_when_buy_package BEFORE INSERT ON HoaDonGoiDichVu
FOR EACH ROW 
BEGIN
	CALL addBonusPoint(NEW.MaKhachHang, NEW.TongTien);
END %%
DELIMITER ;

-- ######################UPDATE CUSTOMER TYPE ##############################################
DROP PROCEDURE IF EXISTS updateCustomerType;
DELIMITER %%
CREATE PROCEDURE updateCustomerType(IN MaKhachHang VARCHAR(8), IN score INT)
BEGIN
	IF score < 50 THEN 
		UPDATE KhachHang SET Loai = 1 WHERE KhachHang.MaKhachHang = MaKhachHang;

    ELSEIF score < 100 THEN
		UPDATE KhachHang SET Loai = 2 WHERE KhachHang.MaKhachHang = MaKhachHang;
        
    ELSEIF score < 1000 THEN
		UPDATE KhachHang SET Loai = 3 WHERE KhachHang.MaKhachHang = MaKhachHang;
        
    ELSE UPDATE KhachHang SET Loai = 4 WHERE KhachHang.MaKhachHang = MaKhachHang;
    END IF;
END %%
DELIMITER ;

DROP TRIGGER IF EXISTS after_point_change;
-- DELIMITER %%
-- CREATE TRIGGER after_point_change AFTER UPDATE ON KhachHang
-- FOR EACH ROW
-- BEGIN
-- 	IF OLD.Diem != NEW.Diem THEN 
-- 		CALL updateCustomerType(NEW.MaKhachHang, NEW.Diem); 
--     END IF;
-- END %%

-- DELIMITER ;
