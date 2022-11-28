SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS ChiNhanh;
CREATE TABLE ChiNhanh (
    MaChiNhanh VARCHAR(5) NOT NULL,
    Tinh VARCHAR(16),
    DiaChi VARCHAR(50),
    DienThoai VARCHAR(12),
    Email VARCHAR(30),
    PRIMARY KEY (MaChiNhanh)
);

DROP TABLE IF EXISTS ChiNhanh_ID;
CREATE TABLE ChiNhanh_ID (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DROP TRIGGER IF EXISTS before_chinhanh_insert;
DELIMITER %%
CREATE TRIGGER before_chinhanh_insert BEFORE INSERT ON ChiNhanh
	FOR EACH ROW
	BEGIN
		INSERT INTO ChiNhanh_ID () VALUES ();
    SET NEW.MaChiNhanh = CONCAT ("CN", LAST_INSERT_ID());
	END %%

DELIMITER ;

INSERT INTO ChiNhanh (Tinh, DiaChi, DienThoai, Email)
VALUES 
	("Dong Thap", "48, Truong Dinh, P1", "0828696919", "dt_48@gmail.com"),
  ("Can Tho", "20, Ninh Kieu, P3", "0982872456", "ct_20@gmail.com"),
  ("Ho Chi Minh", "497, Hoa Hao, P7", "08286964569", "hcm_497@gmail.com"),
  ("Ho Chi Minh", "267, Ly Thuong Kiet, P15", "0828624919", "hcm_267@gmail.com"),
  ("Binh Thuan", "11, Ly Thai To, P1", "0238696919", "bt_11@gmail.com");
  
SELECT * FROM ChiNhanh;

DROP TABLE IF EXISTS HinhAnhChiNhanh;
CREATE TABLE HinhAnhChiNhanh(
  MaChiNhanh VARCHAR(5),
  HinhAnh VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, HinhAnh),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

INSERT INTO HinhAnhChiNhanh (MaChiNhanh, HinhAnh)
VALUES 
	("CN1", "/home/image/cn1/room.png"),
  ("CN1", "/home/image/cn1/beach.png"),
  ("CN2", "/home/image/cn2/room.png"),
	("CN2", "/home/image/cn2/beach.png"),
  ("CN3", "/home/image/cn3/room.png"),
	("CN3", "/home/image/cn3/beach.png"),
	("CN4", "/home/image/cn4/room.png"),
	("CN4", "/home/image/cn4/beach.png"),
	("CN5", "/home/image/cn5/room.png"),
	("CN5", "/home/image/cn5/beach.png");


DROP TABLE IF EXISTS Khu;
CREATE TABLE Khu (
  MaChiNhanh VARCHAR(10),
  TenKhu VARCHAR(16) NOT NULL,
  PRIMARY KEY (MaChiNhanh, TenKhu),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

INSERT INTO Khu (MaChiNhanh, TenKhu)
VALUES
	("CN1", "Economic"),
	("CN1", "Vip"),
	("CN1", "Couple"),
  
	("CN2", "Economic"),
	("CN2", "Vip"),
	("CN2", "Couple"),

	("CN3", "Economic"),
	("CN3", "Vip"),
	("CN3", "Couple"),
  
  ("CN4", "Economic"),
	("CN4", "Vip"),
	("CN4", "Couple"),
  
  ("CN5", "Economic"),
	("CN5", "Vip"),
	("CN5", "Couple");


DROP TABLE IF EXISTS LoaiPhong;
CREATE TABLE LoaiPhong(
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  TenLoaiPhong VARCHAR(16) NOT NULL UNIQUE,
  DienTich FLOAT(5,2),
  SoKhach INT NOT NULL,
  MoTa VARCHAR(255),
  PRIMARY KEY (MaLoaiPhong),
  CHECK (SoKhach >= 1 AND SoKhach <= 10)
);
  
INSERT INTO LoaiPhong(TenLoaiPhong, DienTich, SoKhach, MoTa)
VALUES
  ('President', 60.5, '1', 'The most ornate rooms in the resort'),
  ('King Room', 50, '1', 'A room with a king-size bed'),
  ('Queen Room', 40, '1', 'A room with a queen-size bed'),
  ('Family', 30, '4', 'Room for standard family (4 people)'),
  ('Couple', 28, '2', 'The romantic asmosphere for couple'),
  ('Double', 25, '2', 'Standard room for 2 people'),
  ('Single', 20, '1', 'Standard room for 1 person');


DROP TABLE IF EXISTS ThongTinGiuong;
CREATE TABLE ThongTinGiuong (
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  KichThuoc FLOAT(2, 1) NOT NULL,
  SoLuong INT NOT NULL DEFAULT 1,
  PRIMARY KEY (MaLoaiPhong, KichThuoc),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
  
  CHECK (SoLuong >= 1 AND SoLuong <= 10)
);

INSERT INTO ThongTinGiuong(MaLoaiPhong, KichThuoc, SoLuong)
VALUES
  (1, 2.5, 1),
  (2, 2, 1),
  (3, 1.8, 1),
  (4, 1.6, 1),
  (4, 1.2, 1),
  (5, 1.6, 1),
  (6, 1.2, 2),
  (7, 1.2, 1);

DROP TABLE IF EXISTS ChiNhanh_LoaiPhong;
CREATE TABLE ChiNhanh_LoaiPhong (
	MaChiNhanh VARCHAR(5),
  MaLoaiPhong INT,
  GiaThue INT NOT NULL,
  PRIMARY KEY (MaLoaiPhong, MaChiNhanh),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

INSERT INTO ChiNhanh_LoaiPhong (MaChiNhanh, MaLoaiPhong, GiaThue)
VALUES
  ("CN1", 4, 500),
  ("CN1", 5, 350),
	("CN1", 6, 300),
  ("CN1", 7, 200),
  
  ("CN2", 4, 500),
  ("CN2", 5, 350),
  ("CN2", 6, 300),
  ("CN2", 7, 200),
  
  ("CN3", 2, 1000),
  ("CN3", 3, 900),
	("CN3", 4, 500),
  ("CN3", 5, 350),
  ("CN3", 6, 300),
  ("CN3", 7, 200),
	
  ("CN4", 2, 1000),
  ("CN4", 3, 900),
	("CN4", 4, 500),
  ("CN4", 5, 350),
  ("CN4", 6, 300),
  ("CN4", 7, 200),
  
  ("CN5", 1, 7000),
  ("CN5", 2, 1200),
  ("CN5", 3, 1000),
	("CN5", 4, 700),
  ("CN5", 5, 450),
  ("CN5", 6, 300),
  ("CN5", 7, 200);
  
  
SELECT * FROM ChiNhanh_LoaiPhong
INNER JOIN LoaiPhong ON ChiNhanh_LoaiPhong.MaLoaiPhong = LoaiPhong.MaLoaiPhong
WHERE ChiNhanh_LoaiPhong.MaChiNhanh = "CN1";

DROP TABLE IF EXISTS Phong;
CREATE TABLE Phong (
  MaChiNhanh VARCHAR(5),
  SoPhong VARCHAR(3) NOT NULL,
  TenKhu VARCHAR(16) NOT NULL,
  MaLoaiPhong INT NOT NULL,

  PRIMARY KEY (MaChiNhanh, SoPhong),
  FOREIGN KEY (MaChiNhanh, TenKhu) REFERENCES Khu(MaChiNhanh, TenKhu),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
);

INSERT INTO Phong (MaChiNhanh, SoPhong, TenKhu, MaLoaiPhong)	
VALUES
	("CN1", "101", "Couple", 5),
  ("CN1", "102", "Couple", 5),
  ("CN1", "103", "Couple", 5),
  ("CN2", "101", "Couple", 5),
  ("CN2", "102", "Couple", 5),
  ("CN4", "101", "Economic", 4),
  ("CN4", "102", "Economic", 6),
  ("CN3", "201", "Economic", 7),
  ("CN3", "202", "Economic", 7),
  ("CN5", "501", "Vip", 3),
  ("CN5", "505", "Vip", 2),
  ("CN5", "601", "Vip", 1);

SELECT * FROM Phong;

DROP TABLE IF EXISTS LoaiVatTu;
CREATE TABLE LoaiVatTu (
  MaLoaiVatTu VARCHAR(6),
  TenLoaiVatTu VARCHAR(16) NOT NULL,

  PRIMARY KEY (MaLoaiVatTu)
);

DROP TABLE IF EXISTS LoaiVatTu_ID;
CREATE TABLE LoaiVatTu_ID (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DELIMITER %%
CREATE TRIGGER before_loaivattu_insert BEFORE INSERT ON LoaiVatTu
	FOR EACH ROW
		BEGIN
			INSERT INTO LoaiVatTu_ID VALUE ();
      SET NEW.MaLoaiVatTu = CONCAT ("VT", LPAD(LAST_INSERT_ID(), 4, "0"));
    END %%
	
DELIMITER ;

INSERT INTO LoaiVatTu (TenLoaiVatTu)
VALUES
	("Ghe"), 
  ("Nem"), 
  ("Giuong"), 
  ("Sofa"),
  ("TV"),
  ("TuLanh"),
  ("PS5");
    

DROP TABLE IF EXISTS LoaiVatTu_LoaiPhong;
CREATE TABLE LoaiVatTu_LoaiPhong (
  MaLoaiVatTu VARCHAR(6),
  MaLoaiPhong INT NOT NULL,
  SoLuong INT DEFAULT 1,

  PRIMARY KEY (MaLoaiPhong, MaLoaiVatTu),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
  FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu),
  CHECK (SoLuong >= 1 AND SoLuong <= 20)
);

DROP TABLE IF EXISTS VatTu;
CREATE TABLE  VatTu (
  MaChiNhanh VARCHAR(10),
  MaLoaiVatTu VARCHAR(6),
  STTVatTu INT UNSIGNED NOT NULL,
  SoPhong VARCHAR(16) NOT NULL,
  TinhTrang TEXT,

  PRIMARY KEY (MaChiNhanh, MaLoaiVatTu, STTVatTu),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh),
  FOREIGN KEY (MaChiNhanh, SoPhong) REFERENCES Phong(MaChiNhanh, SoPhong),
  FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu)
);

DROP TABLE IF EXISTS NhaCungCap;
CREATE TABLE NhaCungCap (
  MaNhaCungCap VARCHAR(7) NOT NULL,
  TenNhaCungCap VARCHAR(127) NOT NULL,
  email VARCHAR(127),
  DiaChi VARCHAR(127),

  PRIMARY KEY (MaNhaCungCap)
);

DROP TABLE IF EXISTS NhaCungCap_ID;
CREATE TABLE NhaCungCap_ID (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DELIMITER %%
CREATE TRIGGER before_nhacungcap_insert BEFORE INSERT ON NhaCungCap
	FOR EACH ROW
		BEGIN
			INSERT INTO NhaCungCap_ID VALUE ();
      SET NEW.MaNhaCungCap = CONCAT ("NCC", LPAD(LAST_INSERT_ID(), 4, "0"));
    END %%
	
DELIMITER ;


DROP TABLE IF EXISTS CungCapVatTu;
CREATE TABLE CungCapVatTu (
  MaNhaCungCap VARCHAR(7) NOT NULL,
  MaLoaiVatTu VARCHAR(6) NOT NULL,
  MaChiNhanh VARCHAR(10) NOT NULL,

  PRIMARY KEY  (MaLoaiVatTu, MaChiNhanh),
	
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh),
  FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu),
  FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
);

                                                               
-- ---------------------------------- Khách Hàng ---------------------------------------------
DROP TABLE IF EXISTS KhachHang;
CREATE TABLE KhachHang(
    MaKhachHang VARCHAR(8),
    CCCD VARCHAR(12) NOT NULL UNIQUE,
    HoVaTen VARCHAR(50) NOT NULL,
    DienThoai VARCHAR(12) NOT NULL UNIQUE,
    Email VARCHAR(127) UNIQUE,
    Username VARCHAR(127) UNIQUE,
    Password VARCHAR(50) NOT NULL,
    Diem INT NOT NULL DEFAULT 0,
    Loai INT NOT NULL DEFAULT 1,
    
    PRIMARY KEY (MaKhachHang),
    
    CHECK (Loai >= 1 and Loai <= 4)
);

DROP TABLE IF EXISTS KhachHang_ID;
CREATE TABLE KhachHang_ID (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

DROP TRIGGER IF EXISTS before_khachhang_insert;
DELIMITER %%
CREATE TRIGGER before_khachhang_insert BEFORE INSERT ON KhachHang
	FOR EACH ROW
		BEGIN
			INSERT INTO KhachHang_ID VALUE ();
      SET NEW.MaKhachHang = CONCAT("KH", LPAD(LAST_INSERT_ID(), 6, "0"));
    END %%
	
DELIMITER ;

INSERT INTO KhachHang (CCCD, HoVaTen, DienThoai, Email, Username, Password, Diem, Loai)
VALUES
	('342056301', 'Nguyen Cong Dat', '0828696919', 'datdev2409@gmail.com', 'congdat2409', 'idontsay', 0, 1),
  ('123654987', 'Nguyen Van A', '0982872456', 'vana123@gmail.com', 'vana123', 'hiddenpass', 500, 2),
  ('098123845', 'Tran Thi B', '082813426', 'thib098@gmail.com', 'thib098', 'password456', 800, 3),
  ('333444555', 'Le Van C', '082838920', 'vanc3344@gmail.com', 'vanc3344', 'password123', 1000, 4);


-- --------------------------------- Gói Dich Vụ ---------------------------------------------
DROP TABLE IF EXISTS GoiDichVu;
CREATE TABLE GoiDichVu(
	TenGoi VARCHAR(30) NOT NULL UNIQUE,
	SoNgay INT NOT NULL,
	SoKhach INT NOT NULL,
	Gia INT NOT NULL,
    
	PRIMARY KEY (TenGoi),
	CONSTRAINT ck_SoNgay CHECK (SoNgay >=1 and SoNgay <= 100),
	CONSTRAINT ck_SoKhach CHECK (SoKhach >= 1 and SoKhach <= 10)
);	

INSERT INTO GoiDichVu (TenGoi, SoNgay, SoKhach, Gia)
VALUES
	('BUSINESS PACKAGE', 30, 2, 20000),
  ('PERSONAL PACKAGE', 10, 1, 5000),
  ('FAMILY PACKAGE', 20, 4, 10000);
  
-- -------------------------------- Hóa Đơn Gói Dịch Vụ ---------------------------------------------
DROP TABLE IF EXISTS HoaDonGoiDichVu;
CREATE TABLE HoaDonGoiDichVu(
	MaKhachHang VARCHAR(8) NOT NULL,
	TenGoi VARCHAR(30) NOT NULL,
	NgayGioMua DATETIME,
	NgayBatDau DATETIME,
	TongTien INT NOT NULL,
    
	PRIMARY KEY (MaKhachHang, TenGoi, NgayGioMua),
	CONSTRAINT fk_HoaDonGoiDV_KH FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
															 ON UPDATE CASCADE
															 ON DELETE NO ACTION,
	CONSTRAINT fk_HoaDonGoiDV_GoiDV FOREIGN KEY (TenGoi) REFERENCES GoiDichVu(TenGoi)
														 ON UPDATE CASCADE
														 ON DELETE NO ACTION,
    
	CONSTRAINT ck_BatDau_KetThuc CHECK (NgayBatDau > NgayGioMua)
);

INSERT INTO HoaDonGoiDichVu (MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
VALUES
	("KH000001", 'FAMILY PACKAGE', '2022-11-28 08:00:00', '2022-11-28 10:00:00', 10000),
  ("KH000002", 'BUSINESS PACKAGE', '2022-11-25 08:00:00', '2022-11-25 15:00:00', 20000),
  ("KH000003", 'PERSONAL PACKAGE', '2022-11-28 12:00:00', '2022-11-28 14:00:00', 5000);

-- --------------------------------- Đơn Đặt Phòng ---------------------------------------------
DROP TABLE IF EXISTS DonDatPhong;
CREATE TABLE DonDatPhong(
	MaDatPhong VARCHAR(16) NOT NULL,
	NgayGioDat DATETIME NOT NULL,
  SoKhach INT NOT NULL,
	NgayNhanPhong DATE NOT NULL,
	NgayTraPhong DATE NOT NULL,
	TinhTrang INT(1) NOT NULL DEFAULT 0,
	TongTien INT UNSIGNED NOT NULL DEFAULT 0,
	MaKhachHang VARCHAR(8),
	TenGoiDichVu VARCHAR(127) NOT NULL,
    
	PRIMARY KEY (MaDatPhong),
	CONSTRAINT fk_DonDatPhong_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
																  ON UPDATE CASCADE
																  ON DELETE NO ACTION,
	CONSTRAINT fk_DonDatPhong_GoiDichVu FOREIGN KEY (TenGoiDichVu) REFERENCES GoiDichVu(TenGoi)
																   ON UPDATE CASCADE
																   ON DELETE NO ACTION,
                         
	CONSTRAINT ck_NhanPhong_DatPhong CHECK (NgayNhanPhong > NgayGioDat),
	CONSTRAINT ck_TraPhong_NhanPhong CHECK (NgayTraPhong > NgayNhanPhong),
	CONSTRAINT ck_TinhTrang CHECK (TinhTrang >= 0 AND TinhTrang <= 3)
);

DROP TABLE IF EXISTS DonDatPhong_ID;
CREATE TABLE DonDatPhong_ID (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);


DROP TRIGGER IF EXISTS before_dondatphong_insert; 
DELIMITER %%
CREATE TRIGGER before_dondatphong_insert BEFORE INSERT ON DonDatPhong
FOR EACH ROW
	BEGIN
		INSERT INTO DonDatPhong_ID VALUE ();
    SET NEW.MaDatPhong = CONCAT("DP", DATE_FORMAT(NEW.NgayGioDat, '%d%m%Y'), LPAD(LAST_INSERT_ID(), 6, '0'));
  END %%
DELIMITER ;

INSERT INTO DonDatPhong(NgayGioDat, SoKhach, NgayNhanPhong, NgayTraPhong, TinhTrang, TongTien, MaKhachHang, TenGoiDichVu)
VALUES
  ('2022-03-8 23:56:29', 92, '2022-03-10', '2022-03-12', 0, 3508, 'KH000001', 'FAMILY PACKAGE'),
  ('2022-8-13 03:58:21', 71, '2022-09-19', '2022-11-21', 3, 4103, 'KH000003', 'FAMILY PACKAGE'),
  ('2022-8-30 19:50:54', 19, '2022-10-17', '2022-11-17', 3, 2069, 'KH000004', 'FAMILY PACKAGE'),
  ('2022-2-28 01:37:17', 17, '2022-03-11', '2022-05-10', 3, 1363, 'KH000002', 'BUSINESS PACKAGE'),
  ('2022-02-22 15:51:52', 7, '2022-02-23', '2022-02-24', 3, 3365, 'KH000002', 'BUSINESS PACKAGE');
  

-- --------------------------------- Phòng Thuê ----------------------------------------------------
DROP TABLE IF EXISTS PhongThue;
CREATE TABLE PhongThue(
	MaDatPhong VARCHAR(16),
	MaChiNhanh VARCHAR(5),
	SoPhong VARCHAR(3) NOT NULL,
	
    
	PRIMARY KEY (MaDatPhong, SoPhong, MaChiNhanh),
	CONSTRAINT fk_PhongThue_DDPhong FOREIGN KEY (MaDatPhong) REFERENCES DonDatPhong(MaDatPhong)
															 ON UPDATE CASCADE
															 ON DELETE CASCADE,
	CONSTRAINT fk_PhongThue_Phong FOREIGN KEY (MaChiNhanh, SoPhong) REFERENCES Phong(MaChiNhanh, SoPhong)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE
);

INSERT INTO PhongThue (MaDatPhong, MaChiNhanh, SoPhong)
VALUES
	('DP08032022000003', 'CN1', '101'),
  ('DP13082022000004', 'CN2', '101'),
  ('DP22022022000007', 'CN3', '201'),
  ('DP28022022000006', 'CN4', '102'),
  ('DP30082022000005', 'CN5', '501');

-- ------------------------------------- Hóa Đơn ---------------------------------------------

DROP TABLE IF EXISTS HoaDon;
CREATE TABLE HoaDon(
	MaHoaDon VARCHAR(16),
	ThoiGianNhanPhong TIME NOT NULL,
  ThoiGianTraPhong TIME NOT NULL,
	MaDatPhong VARCHAR(16),
    
	PRIMARY KEY (MaHoaDon),
	CONSTRAINT fk_HoaDon_DDPhong FOREIGN KEY (MaDatPhong) REFERENCES DonDatPhong(MaDatPhong)
);

DROP TABLE IF EXISTS HoaDon_ID;
CREATE TABLE HoaDon_ID (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

DROP TRIGGER IF EXISTS before_hoadon_insert; 
DELIMITER %%
CREATE TRIGGER before_hoadon_insert BEFORE INSERT ON HoaDon
FOR EACH ROW
	BEGIN
		INSERT INTO HoaDon_ID VALUE ();
    SET NEW.MaHoaDon = CONCAT("HD", DATE_FORMAT(NOW(), '%d%m%Y'), LPAD(LAST_INSERT_ID(), 6, '0'));
--     SET NEW.ThoiGianNhanPhong = CONCAT(NEW.ThoiGianNhanPhong, ':00');
-- 		SET NEW.ThoiGianTraPhong = CONCAT(NEW.ThoiGianTraPhong, ':00');
  END %%
DELIMITER ;

INSERT INTO HoaDon (MaDatPhong, ThoiGianNhanPhong, ThoiGianTraPhong)
VALUES
	('DP08032022000003', '8:30', '12:00'),
  ('DP13082022000004', '13:00', '17:00'),
  ('DP22022022000007', '7:40', '12:20'),
  ('DP28022022000006', '6:50', '8:30'),
  ('DP30082022000005', '9:40', '10:10');


-- ---------------------------------- Doanh Nghiệp ---------------------------------------------
DROP TABLE IF EXISTS DoanhNghiep;
CREATE TABLE DoanhNghiep(
	MaDoanhNghiep VARCHAR(6),
	TenDoanhNghiep VARCHAR(30) NOT NULL,
    
	PRIMARY KEY (MaDoanhNghiep)
);

DROP TABLE IF EXISTS DoanhNghiep_ID;
CREATE TABLE DoanhNghiep_ID(
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DROP TRIGGER IF EXISTS before_doanhnghiep_insert;
DELIMITER %%
CREATE TRIGGER before_doanhnghiep_insert BEFORE INSERT ON DoanhNghiep
FOR EACH ROW
	BEGIN
		INSERT INTO DoanhNghiep_ID VALUE ();
        SET NEW.MaDoanhNghiep = CONCAT("DN", LPAD(LAST_INSERT_ID(), 4, '0'));
    END %%
    
DELIMITER ;

INSERT INTO DoanhNghiep (TenDoanhNghiep)
VALUES
	('Lotte'), ('KichiKichi'), ('SUMO BBQ'), 
  ('Hoang Gia'), ('Heaven'),
  ('Circile K'), ('Vinmart'), ('GS25'),
  ('Alibaba'), ('Kitty Store'), ('XPOSE');

-- ------------------------------------- Dịch Vụ ------------------------------------------------
DROP TABLE IF EXISTS DichVu;
CREATE TABLE DichVu(
	MaDichVu VARCHAR(6),
	LoaiDichVu VARCHAR(1) NOT NULL,
	SoKhach INT,
	PhongCach VARCHAR(127),
	MaDoanhNghiep VARCHAR(6),
    
	PRIMARY KEY (MaDichVu),
  FOREIGN KEY (MaDoanhNghiep) REFERENCES DoanhNghiep(MaDoanhNghiep)
);

DROP TABLE IF EXISTS DichVu_ID;
CREATE TABLE DichVu_ID(
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DROP TRIGGER IF EXISTS before_dichvu_insert;
DELIMITER %%
CREATE TRIGGER before_dichvu_insert BEFORE INSERT ON DichVu
FOR EACH ROW
	BEGIN
		INSERT INTO DichVu_ID VALUE ();
			SET NEW.MaDichVu = CONCAT("DN", NEW.LoaiDichVu, LPAD(LAST_INSERT_ID(), 3, '0'));
	END %%
    
DELIMITER ;

INSERT INTO DichVu (LoaiDichVu, SoKhach, PhongCach, MaDoanhNghiep)
VALUES 
	('R', '30', 'fast food', 'DN0001'),
  ('R', '40', 'hotpot', 'DN0002'),
	('R', '50', 'bbq and beer', 'DN0003'),
	('S', '10', 'spa, massage', 'DN0004'),
	('S', '8', 'spa, massage, meditation', 'DN0005'),
	('C', '10', 'convenience store', 'DN0006'),
	('C', '12', 'convenience store', 'DN0007'),
	('C', '20', 'convenience store', 'DN0008'),
	('M', '7', 'boy shop', 'DN0009'),
	('M', '5', 'kitty shop', 'DN0010'),
  ('B', '20', 'buffet bear and bar', 'DN0011');
  


-- Dịch Vụ Spa ---------------------------------------------
-- Loại Hàng Đồ Lưu Niệm ---------------------------------------------
-- Thương Hiệu Đồ Lưu Niệm ---------------------------------------------
-- Mặt Bằng ---------------------------------------------
CREATE TABLE MatBang(
	MaChiNhanh INT,
    STTMatBang INT UNSIGNED UNIQUE NOT NULL DEFAULT 1,
	GiaThue INT NOT NULL,
    MaDichVu INT(3) UNSIGNED ZEROFILL,
    
    PRIMARY KEY (MaChiNhanh, STTMatBang)
);

ALTER TABLE MatBang
	ADD CONSTRAINT fk_MatBang_ChiNhanh FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
																ON UPDATE CASCADE
																ON DELETE CASCADE,
	ADD CONSTRAINT fk_MatBang_DichVu FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu)
															ON UPDATE CASCADE
															ON DELETE SET NULL,
	ADD CONSTRAINT ck_STTMatBang CHECK (STTMatBang <= 50);
-- Hình Ảnh Cửa Hàng ---------------------------------------------
CREATE TABLE HinhAnhCuaHang(
	MaChiNhanh INT,
    STTMatBang INT UNSIGNED NOT NULL,
    HinhAnh VARCHAR(255),
    
    PRIMARY KEY (MaChiNhanh, STTMatBang, HinhAnh)
);

 ALTER TABLE HinhAnhCuaHang
	ADD CONSTRAINT fk_HinhAnhCH_MatBang FOREIGN KEY (MaChiNhanh, STTMatBang) REFERENCES MatBang(MaChiNhanh, STTMatBang)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE;
                                                                   
-- ----------------------------- Khung Giờ Hoạt Động Cửa Hàng ---------------------------------------------
CREATE TABLE KhungGioHoatDong(
	MaChiNhanh INT,
    STTMatBang INT UNSIGNED NOT NULL,
    GioBatDau TIME,
    GioKetThuc TIME,
    
    PRIMARY KEY (MaChiNhanh,STTMatBang, GioBatDau)
);

ALTER TABLE KhungGioHoatDong
	ADD CONSTRAINT fk_GioHD_MatBang FOREIGN KEY (MaChiNhanh, STTMatBang) REFERENCES MatBang(MaChiNhanh, STTMatBang)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE;


