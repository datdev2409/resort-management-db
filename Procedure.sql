DROP FUNCTION IF EXISTS func_getSoNgayDaO;
DELIMITER %%
CREATE FUNCTION func_getSoNgayDaO(
	MaKhachHang VARCHAR(8),
    TenGoi VARCHAR(30)
)
RETURNS INT
BEGIN
	DECLARE SoNgayDaO INT DEFAULT 0;
	IF(EXISTS(SELECT * FROM DonDatPhong WHERE DonDatPhong.MaKhachHang = MaKhachHang AND DonDatPhong.MaKhachHang = TenGoi)) THEN
        SELECT 
        -- DonDatPhong.MaKhachHang,
-- 		DonDatPhong.NgayNhanPhong,
-- 		DonDatPhong.NgayTraPhong,
--         DonDatPhong.TongTien,
--         HoaDonGoiDichVu.NgayBatDau,
-- 		ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR ) AS NgayHetHan,
-- 		HoaDonGoiDichVu.TenGoi,
--         DATEDIFF(DonDatPhong.NgayTraPhong, DonDatPhong.NgayNhanPhong) AS SoNgayO
        SUM(DATEDIFF(DonDatPhong.NgayTraPhong, DonDatPhong.NgayNhanPhong)) INTO SoNgayDaO 
		FROM DonDatPhong
		LEFT JOIN HoaDonGoiDichVu ON HoaDonGoiDichVu.MaKhachHang = DonDatPhong.MaKhachHang
		WHERE
			DonDatPhong.MaKhachHang = MaKhachHang AND
            HoaDonGoiDichVu.TenGoi = TenGoi AND
			DonDatPhong.NgayNhanPhong > HoaDonGoiDichVu.NgayBatDau;
	ELSE
		RETURN 0;
    END IF;
    RETURN SoNgayDaO;
END%%
DELIMITER ;


-- Procedure for remaining time
DROP PROCEDURE IF EXISTS proc_GoiDichVu;
DELIMITER %%
CREATE PROCEDURE proc_GoiDichVu(
	IN MaKhachHang varchar(8)
)
BEGIN
	IF(EXISTS (SELECT * FROM HoaDonGoiDichVu WHERE HoaDonGoiDichVu.MaKhachHang = MaKhachHang)) THEN
		SELECT 
			HoaDonGoiDichVu.TenGoi, 
            GoiDichVu.SoKhach,
            HoaDonGoiDichVu.NgayBatDau,
            ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR ) AS NgayHetHan,
            (GoiDichVu.SoNgay - func_getSoNgayDao(MaKhachHang, HoaDonGoiDichVu.TenGoi)) AS SoNgayConLai
		FROM HoaDonGoiDichVu 
        LEFT JOIN GoiDichVu ON GoiDichVu.TenGoi = HoaDonGoiDichVu.TenGoi
        WHERE 
			HoaDonGoiDichVu.MaKhachHang = MaKhachHang;
	ELSE 
		SELECT CONCAT("Khong tim thay khach hang co ma '", MaKhachHang,"' trong Hoa Don Goi Dich Vu") AS Message;
	END IF;
END %%

DELIMITER ;

DROP PROCEDURE IF EXISTS proc_KTGoiDichVu;
DELIMITER %%
CREATE PROCEDURE proc_KTGoiDichVu(
	IN MaKhachHang varchar(8),
    IN NgayBatDau DATETIME,
    IN TenGoi VARCHAR(20)
)
BEGIN
	DECLARE msg VARCHAR(128);
        DECLARE goiHientai INT;
--     SELECT * FROM HoaDonGoiDichVu;
    
	SELECT * FROM HoaDonGoiDichVu 
           WHERE (HoaDonGoiDichVu.MaKhachHang = MaKhachHang
				AND ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR) > NgayBatDau     
 				AND HoaDonGoiDichVu.TenGoi = TenGoi);
		
    SELECT COUNT(*) INTO goiHientai
    FROM 
    (
		SELECT * 
		FROM HoaDonGoiDichVu 
		WHERE (HoaDonGoiDichVu.MaKhachHang = MaKhachHang     
			AND ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR) > NgayBatDau     
			AND HoaDonGoiDichVu.TenGoi = TenGoi)
    )AS tmp;
    
    IF (goiHienTai <> 0) THEN
		SET msg = CONCAT("before_HoaDonGoiDichVu_insert: Goi Dich Vu con han Su Dung");
        SIGNAL sqlstate "12345" SET message_text = msg;
	END IF;
    
	-- IF(EXiSTS(SELECT * FROM HoaDonGoiDichVu WHERE (HoaDonGoiDichVu.MaKhachHang = MaKhachHang     
-- 													AND ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR) > NgayBatDau     
-- 													AND HoaDonGoiDichVu.TenGoi = TenGoi))) THEN
-- 			SELECT * FROM HoaDonGoiDichVu 
--             WHERE (HoaDonGoiDichVu.MaKhachHang = MaKhachHang     
-- 				AND ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR) > NgayBatDau     
-- 				AND HoaDonGoiDichVu.TenGoi = TenGoi);
-- 			SET msg = CONCAT("before_HoaDonGoiDichVu_insert: Goi Dich Vu con han Su Dung");
-- 			SIGNAL sqlstate "45000" SET message_text = msg;
--     END IF;
END %%
DELIMITER ;


CALL proc_KTGoiDichVu("KH000001",'2023-3-28 10:00:00',  'FAMILY PACKAGE');
CALL proc_GoiDichVu("KH000001");

