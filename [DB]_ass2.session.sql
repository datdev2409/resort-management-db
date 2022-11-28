SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS ChiNhanh;
CREATE TABLE ChiNhanh (
    MaChiNhanh VARCHAR(10) NOT NULL,
    Tinh VARCHAR(127),
    DiaChi VARCHAR(127),
    DienThoai VARCHAR(32),
    Email VARCHAR(127),
    PRIMARY KEY (MaChiNhanh)
);

DROP TABLE IF EXISTS ChiNhanh_ID;
CREATE TABLE ChiNhanh_ID (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

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
  MaChiNhanh VARCHAR(10),
  HinhAnh VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, HinhAnh),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

INSERT INTO HinhAnhChiNhanh (MaChiNhanh, HinhAnh)
VALUES 
	("CN1", "/home/image/cn1/room.png"),
  ("CN1", "/home/image/cn1/beach.png"),
  ("CN2", "/home/image/cn2/room.png"),
  ("CN3", "/home/image/cn3/room.png"),
	("CN3", "/home/image/cn3/river.png"),
	("CN4", "/home/image/cn4/room.png"),
	("CN5", "/home/image/cn5/room.png"),
	("CN6", "/home/image/cn6/room.png");
  
  
SELECT * FROM HinhAnhChiNhanh;

DROP TABLE IF EXISTS Khu;
CREATE TABLE Khu (
  MaChiNhanh VARCHAR(10),
  TenKhu VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, TenKhu),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

INSERT INTO Khu (MaChiNhanh, TenKhu)
VALUES
	("CN1", "Khu bien"),
  ("CN1", "Khu view nui"),
  ("CN2", "Khu bien"),
  ("CN2", "Khu view nui"),
  ("CN2", "Khu noi o"),
	("CN3", "Khu thac"),
  ("CN3", "Khu rung"),
  ("CN4", "Khu biet thu"),
  ("CN5", "Khu view nui"),
  ("CN5", "Khu thac"),
  ("CN6", "Khu trang trai");
  
SELECT * FROM Khu;


DROP TABLE IF EXISTS LoaiPhong;
CREATE TABLE LoaiPhong (
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  TenLoaiPhong VARCHAR(127) NOT NULL UNIQUE,
  DienTich FLOAT,
  SoKhach INT NOT NULL,
  MoTa TEXT,
  PRIMARY KEY (MaLoaiPhong),
  CHECK (SoKhach >= 1 AND SoKhach <= 10)
);
  
INSERT INTO LoaiPhong(TenLoaiPhong, DienTich, SoKhach, MoTa)
VALUES
  ('President', 100, '1', 'Room for VIP only'),
  ('King Room', 80, '1', 'Room for VIP only'),
  ('Queen Room', 60, '1', 'Room for VIP only'),
  ('Family', 100, '4', 'Room for family'),
  ('Couple', 50, '2', 'Room for couple'),
  ('Single', 35, '1', 'Single room');

SELECT * FROM LoaiPhong;

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
  (1, 1.8, 1),
  (2, 1.6, 1),
  (3, 1.4, 2),
  (4, 1.2, 2),
  (4, 1, 1),
  (5, 1.2, 1),
  (6, 1, 1);

SELECT * FROM ThongTinGiuong;

DROP TABLE IF EXISTS ChiNhanh_LoaiPhong;
CREATE TABLE ChiNhanh_LoaiPhong (
	MaChiNhanh VARCHAR(10),
  MaLoaiPhong INT,
  GiaThue INT NOT NULL,
  PRIMARY KEY (MaLoaiPhong, MaChiNhanh),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

INSERT INTO ChiNhanh_LoaiPhong (MaChiNhanh, MaLoaiPhong, GiaThue)
VALUES
  ("CN1", 3, 2000),
  ("CN1", 1, 3000),
	("CN2", 2, 1000),
  ("CN2", 4, 4000),
  ("CN3", 4, 2000),
  ("CN3", 3, 3000),
	("CN4", 5, 1000),
  ("CN4", 2, 4000),
	("CN5", 6, 2000),
  ("CN5", 3, 3000),
	("CN6", 5, 1000),
  ("CN6", 2, 4000);
  
SELECT * FROM ChiNhanh_LoaiPhong
INNER JOIN LoaiPhong ON ChiNhanh_LoaiPhong.MaLoaiPhong = LoaiPhong.MaLoaiPhong
WHERE ChiNhanh_LoaiPhong.MaChiNhanh = "CN1";

DROP TABLE IF EXISTS Phong;
CREATE TABLE Phong (
  MaChiNhanh VARCHAR(10),
  SoPhong VARCHAR(3) NOT NULL,
  TenKhu VARCHAR(127) NOT NULL,
  MaLoaiPhong INT NOT NULL,

  PRIMARY KEY (MaChiNhanh, SoPhong),
  FOREIGN KEY (MaChiNhanh, TenKhu) REFERENCES Khu(MaChiNhanh, TenKhu),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
);

INSERT INTO Phong (MaChiNhanh, SoPhong, TenKhu, MaLoaiPhong)	
VALUES
	("CN1", "101", "Khu bien", 3),
  ("CN1", "102", "Khu bien", 1);

SELECT * FROM Phong;

DROP TABLE IF EXISTS LoaiVatTu;
CREATE TABLE LoaiVatTu (
  MaLoaiVatTu VARCHAR(6),
  TenLoaiVatTu VARCHAR(127) NOT NULL,

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

SELECT * FROM LoaiVatTu;

INSERT INTO LoaiVatTu (TenLoaiVatTu)
VALUES
	("ghe"), ("nem"), ("giuong"), ("sofa");
    

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

SELECT * FROM NhaCungCap;
	

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




