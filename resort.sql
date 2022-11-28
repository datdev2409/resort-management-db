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
  ('King Room', 50, '1', 'A well-furnished room with king-size bed'),
  ('Queen Room', 40, '1', 'A well-furnished room with queen-size bed'),
  ('Family', 30, '4', 'Standard room for family (4 people)'),
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

DROP TABLE IF EXISTS LoaiVatTu;
CREATE TABLE LoaiVatTu (
  MaLoaiVatTu VARCHAR(6),
  TenLoaiVatTu VARCHAR(25) NOT NULL,

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
	("Sofa"),
	("TV"),
    ("May Lanh"),
	("Tu Lanh"),
	("PS5"),
    ("Khăn"),
    ("Bo ve sinh ca nhan");
    
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

INSERT INTO LoaiVatTu_LoaiPhong(MaLoaiPhong, MaLoaiVatTu, SoLuong)
VALUE
	("7", "VT0002", 1), ("7", "VT0003", 1), ("7", "VT0006", 1), ("7", "VT0007", 1),
    ("6", "VT0002", 1), ("6", "VT0003", 1), ("6", "VT0004", 1), ("6", "VT0006", 2), ("6", "VT0007", 2),
    ("5", "VT0001", 1), ("5", "VT0002", 1), ("5", "VT0003", 1), ("5", "VT0004", 1), ("5", "VT0005", 1), ("5", "VT0006", 2), ("5", "VT0007", 2),
    ("4", "VT0002", 1), ("4", "VT0003", 1), ("4", "VT0004", 1), ("4", "VT0005", 1), ("4", "VT0006", 2), ("4", "VT0007", 2),
    ("3", "VT0002", 1), ("3", "VT0003", 1), ("3", "VT0004", 1), ("3", "VT0005", 1), ("3", "VT0006", 2), ("3", "VT0007", 2),
    ("2", "VT0002", 1), ("2", "VT0003", 1), ("2", "VT0004", 1), ("2", "VT0005", 1), ("2", "VT0006", 2), ("2", "VT0007", 2),
    ("1", "VT0002", 1), ("1", "VT0003", 1), ("1", "VT0004", 1), ("1", "VT0005", 1), ("1", "VT0006", 2), ("1", "VT0007", 2);

DROP TABLE IF EXISTS VatTu;
CREATE TABLE  VatTu (
  MaChiNhanh VARCHAR(5),
  MaLoaiVatTu VARCHAR(6),
  STTVatTu INT UNSIGNED NOT NULL,
  SoPhong VARCHAR(3) NOT NULL,
  TinhTrang TEXT,

  PRIMARY KEY (MaChiNhanh, MaLoaiVatTu, STTVatTu),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh),
  FOREIGN KEY (MaChiNhanh, SoPhong) REFERENCES Phong(MaChiNhanh, SoPhong),
  FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu)
);

INSERT INTO VatTu(MaChiNhanh, MaLoaiVatTu, STTVatTu, SoPhong, TinhTrang)
VALUES
	("CN1", "VT0001", 1, "101", "Nguyen Ven"), ("CN1", "VT0001", 2, "102", "Nguyen Ven"), ("CN1", "VT0001", 3, "103", "Hoi phai mau ben canh phai"),	
    ("CN1", "VT0002", 1, "101", "Nguyen Ven"), ("CN1", "VT0002", 2, "102", "Hoi phai mau ben canh trai"), ("CN1", "VT0002", 3, "103", "Nguyen Ven"),	

    ("CN2", "VT0001", 1, "101", "Nguyen Ven"), ("CN2", "VT0001", 2, "101", "Nguyen Ven"),
    ("CN2", "VT0002", 1, "101", "Nguyen Ven"), ("CN2", "VT0002", 2, "101", "Nguyen Ven"),
    ("CN2", "VT0003", 1, "101", "Nguyen Ven"), ("CN2", "VT0003", 2, "101", "Nguyen Ven"),
    
    ("CN3", "VT0006", 1, "101", "Da thay moi"), ("CN2", "VT0006", 2, "101", "Da thay moi"),
    ("CN3", "VT0007", 1, "101", "Da thay moi"), ("CN2", "VT0007", 2, "101", "Da thay moi"),
    
    ("CN4", "VT0005", 1, "101", "Nguyen Ven"), ("CN2", "VT0005", 2, "101", "Bi hu 1 controller"),
    ("CN4", "VT0003", 1, "101", "Nguyen Ven"), ("CN2", "VT0003", 2, "101", "Nguyen Ven"),
    
    ("CN5", "VT0006", 1, "101", "Da thay moi"), ("CN5", "VT0006", 2, "101", "Da thay moi"), ("CN5", "VT0005", 1, "102", "Nguyen Ven"),
    ("CN5", "VT0004", 1, "101", "Day du thuc pham"), ("CN5", "VT0004", 2, 102, "Day du thuc pham"), ("CN5", "VT0004", 3, 103, "Thieu ruou vang, nuoc ngot"),
    ("CN5", "VT0005", 1, "101", "Nguyen Ven"), ("CN5", "VT0005", 2, "102", "Nguyen Ven"), ("CN5", "VT0005", 3, "103", "Nguyen Ven");
    
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
create table KhachHang(
    MaKhachHang int(6) unsigned zerofill not null auto_increment,
	prefix char(2) not null,
    CCCD varchar(12) not null unique,
    SoDienThoai varchar(12) not null unique,
    Email varchar(127) unique,
    Username varchar(127) unique,
    Diem int not null default 0,
    Loai int not null default 1,
    
    primary key (MaKhachHang),
    unique key (prefix, MaKhachHang),
    
    Constraint ck_Diem check (Diem >= 1 and Diem <= 4)
);

-- --------------------------------- Gói Dich Vụ ---------------------------------------------
CREATE TABLE GoiDichVu(
	TenGoi VARCHAR(127) NOT NULL UNIQUE,
    SoNgay INT NOT NULL,
    SoKhach INT NOT NULL,
    Gia DOUBLE,
    
    PRIMARY KEY (TenGoi),
    CONSTRAINT ck_SoNgay CHECK (SoNgay >=1 and SoNgay <= 100),
    CONSTRAINT ck_SoKhach CHECK (SoKhach >= 1 and SoKhach <= 10)
);
-- -------------------------------- Hóa Đơn Gói Dịch Vụ ---------------------------------------------
CREATE TABLE HoaDonGoiDichVu(
	MaKhachHang INT(6) unsigned zerofill not null,
	TenGoi VARCHAR(127) NOT NULL,
    NgayGioMua DATETIME ,
    NgayBatDau DATETIME ,
    TongTien DOUBLE NOT NULL,
    
    PRIMARY KEY (MaKhachHang, TenGoi, NgayGioMua),
	CONSTRAINT fk_HoaDonGoiDV_KH FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
															 ON UPDATE CASCADE
															 ON DELETE NO ACTION,
    CONSTRAINT fk_HoaDonGoiDV_GoiDV FOREIGN KEY (TenGoi) REFERENCES GoiDichVu(TenGoi)
														 ON UPDATE CASCADE
														 ON DELETE NO ACTION,
    
    CONSTRAINT ck_BatDau_KetThuc CHECK (NgayBatDau > NgayGioMua)
);

-- --------------------------------- Đơn Đặt Phòng ---------------------------------------------
CREATE TABLE DonDatPhong(
	Prefix CHAR(2) NOT NULL,
    MaDatPhong INT(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    NgayGioDat DATETIME NOT NULL,
    NgayNhanPhong DATETIME NOT NULL,
    NgayTraPhong DATETIME NOT NULL,
    TinhTrang INT(1) NOT NULL DEFAULT 0,
    TongTien INT UNSIGNED NOT NULL DEFAULT 0,
    MaKhachHang INT(6) UNSIGNED ZEROFILL NOT NULL,
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

-- --------------------------------- Phòng Thuê ----------------------------------------------------
CREATE TABLE PhongThue(
	MaDatPhong INT(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    MaChiNhanh INT NOT NULL,
    SoPhong VARCHAR(16) NOT NULL,
	
    
    PRIMARY KEY (MaDatPhong, SoPhong, MaChiNhanh),
    CONSTRAINT fk_PhongThue_DDPhong FOREIGN KEY (MaDatPhong) REFERENCES DonDatPhong(MaDatPhong)
															 ON UPDATE CASCADE
															 ON DELETE NO ACTION,
	CONSTRAINT fk_PhongThue_Phong FOREIGN KEY (MaChiNhanh, SoPhong) REFERENCES Phong(MaChiNhanh, SoPhong)
																   ON UPDATE CASCADE
																   ON DELETE NO ACTION
);
-- ------------------------------------- Hóa Đơn ---------------------------------------------
CREATE TABLE HoaDon(
	MaHoaDon INT(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    NgayNhanPhong DATETIME NOT NULL, 
    NgayTraPhong DATETIME NOT NULL,
    MaDatPhong INT(6) UNSIGNED ZEROFILL NOT NULL,
    -- Tạo Trigger
    
    PRIMARY KEY (MaHoaDon),
    CONSTRAINT fk_HoaDon_DDPhong FOREIGN KEY (MaDatPhong) REFERENCES DonDatPhong(MaDatPhong)
);
-- ---------------------------------- Doanh Nghiệp ---------------------------------------------
DROP TABLE IF EXISTS DoanhNghiep;
CREATE TABLE DoanhNghiep(
	MaDoanhNghiep VARCHAR(6),
    TenDoanhNghiep VARCHAR(30) NOT NULL,
    
    PRIMARY KEY (MaDoanhNghiep)
);

CREATE TABLE DoanhNghiep_ID(
	ID INT NOT NULL AUTO_INCREMENT
);

DELIMITER %%
CREATE TRIGGER before_doanhnghiep_insert BEFORE INSERT ON DoanhNghiep
FOR EACH ROW
	BEGIN
		INSERT INTO DoanhNghiep_ID VALUE ();
        SET NEW.MaDoanhNghiep = CONCAT("DN", LPAD(LAST_INSERT_ID(), 6, '0'));
    END %%
    
DELIMITER ;

-- ------------------------------------- Dịch Vụ ------------------------------------------------
CREATE TABLE DichVu(
	Prefix VARCHAR(2) DEFAULT "DV",
	MaDichVu INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
	LoaiDichVu CHAR NOT NULL,
    SoKhach INT,
    PhongCach VARCHAR(127),
    MaDoanhNghiep INT(4) UNSIGNED ZEROFILL NOT NULL,
    
    PRIMARY KEY (MaDichVu)
);

ALTER TABLE DichVu
	ADD CONSTRAINT ck_DichVu CHECK (STRCMP(LoaiDichVu,"R")
									OR STRCMP(LoaiDichVu,"S") 
                                    OR STRCMP(LoaiDichVu,"C") 
                                    OR STRCMP(LoaiDichVu,"M") 
                                    OR STRCMP(LoaiDichVu,"B")),
	ADD CONSTRAINT fk_DichVu FOREIGN KEY (MaDoanhNghiep) REFERENCES DoanhNghiep(MaDoanhNghiep)
														 ON UPDATE CASCADE
                                                         ON DELETE CASCADE;

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


