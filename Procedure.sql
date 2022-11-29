DROP PROCEDURE IF EXISTS proc_getSoNgayDaO;
DELIMITER %%
CREATE PROCEDURE proc_getSoNgayDaO(
	IN MaKhachHang VARCHAR(8)
)
BEGIN
    SELECT 
		DonDatPhong.NgayNhanPhong,
		DonDatPhong.NgayTraPhong,
        DonDatPhong.TongTien,
        HoaDonGoiDichVu.NgayBatDau,
		ADDDATE(HoaDonGoiDichVu.NgayBatDau, INTERVAL 1 YEAR ) AS NgayHetHan,
		HoaDonGoiDichVu.TenGoi
	FROM DonDatPhong
	LEFT JOIN HoaDonGoiDichVu ON HoaDonGoiDichVu.MaKhachHang = DonDatPhong.MaKhachHang;
END%%
DELIMITER ;

CALL proc_getSoNgayDaO("KH000001");

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
            DATEDIFF(ADDDATE(HoaDonGoiDichVu.NgayBatDau, GoiDichVu.SoNgay), CURRENT_TIMESTAMP()) AS SoNgayConLai
            
		FROM HoaDonGoiDichVu 
        LEFT JOIN GoiDichVu ON GoiDichVu.TenGoi = HoaDonGoiDichVu.TenGoi
        WHERE 
			HoaDonGoiDichVu.MaKhachHang = MaKhachHang;
	ELSE 
		SELECT CONCAT("Khong tim thay khach hang co ma '", MaKhachHang,"' trong Hoa Don Goi Dich Vu") AS Message;
	END IF;
END %%
DELIMITER ;

CALL proc_GoiDichVu("KH000001");

SELECT func_getSoNgayDaO("KH000001");
