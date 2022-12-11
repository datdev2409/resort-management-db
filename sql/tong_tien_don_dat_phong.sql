-- Đơn đặt phòng (Mã đặt phòng, ngày giờ đặt, số khách, ngày nhận phòng, ngày trả phòng,
-- tình trạng, tổng tiền, mã khách hàng, tên gói dịch vụ)

-- Tien = Tien goc - giam gia

-- Tien goc
-- Ma dat phong -> lookup table phong thue -> Ma chi nhanh + so phong -> lookup tale phong -> ma loai phong
-- Ma Loai phong + Ma chi nhanh -> gia thue/1 ngay
-- gia thue 1/ngay * so ngay = tien goc
-- so ngay = ngay nhan phong - ngay tra phong
 -- gio tra phong > 12 gio trua => so ngay + 1
 -- gio tra phong <= 12 gio trua => so ngay
 
 
-- LẤY GIÁ THUÊ 1 NGÀY DỰA VÀO MÃ LOẠI PHÒNG + MÃ CHI NHÁNH
DROP FUNCTION IF EXISTS get_rental_price;
DELIMITER %%
CREATE FUNCTION get_rental_price(PMaLoaiPhong INT, PMaChiNhanh VARCHAR(6))
	RETURNS INT
	BEGIN
		DECLARE price INT;
        SET price = 0;
        SELECT GiaThue FROM ChiNhanh_LoaiPhong 
			WHERE MaChiNhanh = PMaChiNhanh AND MaLoaiPhong = PMaLoaiPhong
			LIMIT 1
			INTO price;
        RETURN price;

	END %%
DELIMITER ;

-- Lấy giá thuê 1 ngày dưa vào booking_id
DROP FUNCTION IF EXISTS get_rental_price_from_booking_id;
DELIMITER %%
CREATE FUNCTION get_rental_price_from_booking_id(PMaDatPhong VARCHAR(16))
	RETURNS INT
    BEGIN
		DECLARE price INT;
        DECLARE VMaChiNhanh VARCHAR(6);
        DECLARE VSoPhong VARCHAR(3);
        DECLARE VMaLoaiPhong INT;
        SET price = 0;
        SET VMaLoaiPhong = 0;
        
        -- Find MaChiNhanh, SoPhong FROM table PhongThue based on MaDatPhong
        SELECT MaChiNhanh, SoPhong FROM PhongThue
			WHERE MaDatPhong = PMaDatPhong
            LIMIT 1
            INTO VMaChiNhanh, VSoPhong;
            
		-- Find MaLoaiPhong FROM table Phong based on MaChiNhanh va SoPhong
        SELECT MaLoaiPhong FROM Phong
			WHERE MaChiNhanh = VMaChiNhanh AND SoPhong = VSoPhong
            LIMIT 1
            INTO VMaLoaiPhong;
		
        SET price = get_rental_price(VMaLoaiPhong, VMaChiNhanh);
        RETURN price;
    END %%

DELIMITER ;

SELECT get_rental_price(1, "CN1");

SELECT get_rental_price_from_booking_id('DP08032022000001');

-- Tinh so ngay thue phong
DROP FUNCTION IF EXISTS get_rental_days;
DELIMITER %%
CREATE FUNCTION get_rental_days(PMaDatPhong VARCHAR(16))
	RETURNS INT
	BEGIN 
		DECLARE num_days INT;
        SET num_days = 0;
        
        SELECT DATEDIFF(NgayTraPhong, NgayNhanPhong) FROM DonDatPhong
        WHERE PMaDatPhong = MaDatPhong
        LIMIT 1
        INTO num_days;
        RETURN num_days;
	END %%

DELIMITER ;

-- Tính giảm giá
DROP FUNCTION IF EXISTS get_net_price;
DELIMITER %%
CREATE FUNCTION get_net_price(PMaDatPhong VARCHAR(16))
RETURNS INT
BEGIN
	DECLARE price INT;
    DECLARE customer_type INT;
    SET price = get_rental_days(PMaDatPhong) * get_rental_price_from_booking_id(PMaDatPhong);
    
	SELECT Loai  FROM (SELECT Loai, DonDatPhong.MaDatPhong FROM KhachHang JOIN DonDatPhong
		ON KhachHang.MaKhachHang = DonDatPhong.MaKhachHang) AS TYPE
		WHERE TYPE.MaDatPhong = PMaDatPhong
		LIMIT 1
		INTO customer_type;
--     
	IF customer_type = 2 THEN
		RETURN price / 100 * 90;
	ELSEIF customer_type = 3 THEN
		RETURN price / 100 * 85;
	ELSEIF customer_type = 4 THEN
		RETURN price / 100 * 80;
	ELSE 
		RETURN price;
	END IF;
    
    RETURN price;
END %%
DELIMITER ;

SELECT get_net_price('DP08032022000001');

