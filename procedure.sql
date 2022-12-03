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