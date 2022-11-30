-- Trigger Insert tên gói nếu đc áp dụng tại Khách Hàng
DROP TRIGGER IF EXISTS trg_TenGoiHopLe;
DELIMITER %%
CREATE TRIGGER trg_TenGoiHopLe
BEFORE INSERT ON DonDatPhong FOR EACH ROW
BEGIN
	IF(EXISTS(SELECT * FROM HoaDonGoiDichVu WHERE HoaDonGoiDichVu.MaKhachHang = NEW.MaKhachHang
											AND NEW.NgayNhanPhong > HoaDonGoiDichVu.NgayBatDau
                                            AND NEW.NgayTraPhong <= HoaDonGoiDichVu.NgayKetThuc)) THEN
			SET NEW.TenGoiDichVu = NEW.TenGoiDichVu; 
    ELSE
		SET NEW.TenGoiDichVu = NULL;
    END IF;
END%%
DELIMITER ;


-- Trigger Tinh Tổng Tiền