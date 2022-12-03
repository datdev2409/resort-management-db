SELECT *
FROM PhongThue 
INNER JOIN Phong ON PhongThue.MaChiNhanh = Phong.MaChiNhanh AND PhongThue.SoPhong = Phong.SoPhong
INNER JOIN ChiNhanh_LoaiPhong
ON Phong.MaLoaiPhong = ChiNhanh_LoaiPhong.MaLoaiPhong AND ChiNhanh_LoaiPhong.MaChiNhanh = Phong.MaChiNhanh;



SELECT SUM(GiaThue)
FROM PhongThue 
INNER JOIN Phong ON PhongThue.MaChiNhanh = Phong.MaChiNhanh AND PhongThue.SoPhong = Phong.SoPhong
INNER JOIN ChiNhanh_LoaiPhong ON Phong.MaLoaiPhong = ChiNhanh_LoaiPhong.MaLoaiPhong AND ChiNhanh_LoaiPhong.MaChiNhanh = Phong.MaChiNhanh
WHERE PhongThue.MaDatPhong = 'DP08032022000003';

CALL get_rental_price('DP30082022000005', @price);
SELECT @price;
