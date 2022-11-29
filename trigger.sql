-- Trigger Insert tên gói nếu đc áp dụng tại Khách Hàng
DROP TRIGGER IF EXISTS tg_TenGoiKH;
DELIMITER %%
CREATE TRIGGER tgTenGoiKH
BEFORE INSERT ON DonDatPhong FOR EACH ROW
BEGIN
	IF(EXISTS(SELECT * FROM HoaDonGoiDichVu WHERE HoaDonGoiDichVu.MaKhachHang = NEW.MaKhachHang)
    AND (NEW.NgayNhanPhong > HoaDonGoiDichVu.NgayBatDau) OR 
		 NEW.NgayTraPhong < ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR )) THEN
		IF (NOT EXISTS (SELECT * FROM HoaDonGoiDichVu WHERE NEW.TenGoiDichVu = hoadongoidichvu.TenGoi)) THEN
			SET NEW.TenGoiDiChVu = hoadongoidichvu.TenGoi;
		END IF;
    ELSE
		SET NEW.TenGoiDichVu = NULL;
    END IF;
END%%
DELIMITER ;