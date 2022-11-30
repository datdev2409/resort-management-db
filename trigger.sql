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






-- Trigger kiemtra mua goi dich vu hop le
DROP TRIGGER IF EXISTS before_HoaDonGoiDichVu_insert;
DELIMITER %%
CREATE TRIGGER before_HoaDonGoiDichVu_insert
BEFORE INSERT ON HoaDonGoiDichVu FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(128);
	DECLARE goiHientai INT;
    
--     SELECT * FROM HoaDonGoiDichVu 
--            WHERE (HoaDonGoiDichVu.MaKhachHang = NEW.MaKhachHang
-- 				AND ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR) > NEW.NgayBatDau     
--  				AND HoaDonGoiDichVu.TenGoi = NEW.TenGoi);
		
    SELECT COUNT(*) INTO goiHientai
    FROM 
    (
		SELECT * 
		FROM HoaDonGoiDichVu 
		WHERE (HoaDonGoiDichVu.MaKhachHang = NEW.MaKhachHang     
			AND ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR) > NEW.NgayBatDau     
			AND HoaDonGoiDichVu.TenGoi = NEW.TenGoi)
    )AS tmp;
    
    IF (goiHienTai <> 0) THEN
		SET msg = CONCAT("before_HoaDonGoiDichVu_insert: Goi Dich Vu con han Su Dung");
        SIGNAL sqlstate "12345" SET message_text = msg;
	END IF;
END%%
DELIMITER ;

-- Trigger Tinh Tổng Tiền Thue Phong (Chưa làm)
DROP TRIGGER IF EXISTS trg_TenGoiHopLe;
DELIMITER %% 
CREATE TRIGGER trg_TenGoiHopLe
AFTER INSERT ON DonDatPhong FOR EACH ROW
BEGIN
	-- Check thông tin phòng thuê NEW (MaDP, MaCN, SoPhong)
			-- MADP -> CHon dc row de update trong don
            -- MaCN -> Chong row torng Phong -> laays so Phong
    -- SELECT row có MaDP, join với row có MaCN, Join
    -- SELECT *
--     FROM DonDatPhong
--     LEFT JOIN ChiNhanh_LoaiPhong ON ChiNhanh_LoaiPhong.MaKhachHang = NEW.Ma 
END%%
DELIMITER ;
