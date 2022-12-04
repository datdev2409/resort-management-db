-- PROCEDURE 1: GoiDichVu
SET GLOBAL log_bin_trust_function_creators = 1;
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













-- PROCEDURE 2: ThongKeLuotKhach
DROP PROCEDURE IF EXISTS ThongKeLuotKhach;

DELIMITER %%
CREATE PROCEDURE ThongKeLuotKhach(IN MaChiNhanh VARCHAR(5), IN NamThongKe YEAR)
BEGIN
	SELECT MONTH(NgayGioDat) as Thang, SUM(SoKhach) as 'Tong so luot khach'
    FROM PhongThue 
    INNER JOIN DonDatPhong
    ON PhongThue.MaDatPhong = DonDatPhong.MaDatPhong
    WHERE YEAR(NgayGioDat) = NamThongKe AND PhongThue.MaChiNhanh = MaChiNhanh AND TinhTrang = 1
    GROUP BY MONTH(NgayGioDat);

END %%
DELIMITER ;



CALL ThongKeLuotKhach('CN1', '2022');