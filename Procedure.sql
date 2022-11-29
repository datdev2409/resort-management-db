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
            ADDDATE(HoaDonGoiDichVu.NgayBatDau, GoiDichVu.SoNgay) AS NgayHetHan,
            DATEDIFF(ADDDATE(HoaDonGoiDichVu.NgayBatDau, GoiDichVu.SoNgay), CURRENT_TIMESTAMP()) AS SoNgayConLai
		FROM HoaDonGoiDichVu 
        LEFT JOIN GoiDichVu ON GoiDichVu.TenGoi = HoaDonGoiDichVu.TenGoi
        WHERE 
			HoaDonGoiDichVu.MaKhachHang = MaKhachHang AND
            DATEDIFF(ADDDATE(HoaDonGoiDichVu.NgayBatDau, GoiDichVu.SoNgay), CURRENT_TIMESTAMP()) > 0
			;
	ELSE 
		SELECT CONCAT("Khong tim thay khach hang co ma '", MaKhachHang,"' trong Hoa Don Goi Dich Vu") AS Message;
	END IF;
END %%
DELIMITER ;

CALL proc_GoiDichVu("KH000001");

