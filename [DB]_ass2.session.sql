#########################################################
####### 			CREATE DATABASE				#########
#########################################################
-- ----------------------------------- Chi nhánh --------------------------------------------------

CREATE TABLE ChiNhanh (
  MaChiNhanh INT NOT NULL AUTO_INCREMENT,
  Tinh VARCHAR(127),
  DiaChi VARCHAR(127),
  DienThoai VARCHAR(32),
  Email VARCHAR(127),
  PRIMARY KEY (MaChiNhanh)
);

INSERT INTO ChiNhanh (Tinh, DiaChi, DienThoai, Email)
VALUES 
  ('Long An', '48, Truong Dinh, P1', '01234', 'user@gmail.com'),
  ('Dong Thap', '48, Truong Dinh, P1', '0828696919', 'congdat2409@gmail.com'),
  ('Ho Chi Minh', '268 Ly Thuong Kiet, P12, Q10', '0828696919', 'congdat2409@gmail.com'),
  ('Ho Chi Minh', '497 Hoa Hao, P7, Q10', '0828696919', 'datdev2409@gmail.com');

-- ------------------------------ Hình Ảnh Chi Nhánh ---------------------------------------------
CREATE TABLE HinhAnhChiNhanh(
  MaChiNhanh INT,
  HinhAnh VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, HinhAnh)
);

ALTER TABLE HinhAnhChiNhanh
	ADD CONSTRAINT fk_HinhAnh_ChiNhanh FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
																ON UPDATE CASCADE
                                                                ON DELETE CASCADE;

INSERT INTO  HinhAnhChiNhanh (MaChiNhanh, HinhAnh)
VALUES
  (1, '/path/to/img1'),
  (1, '/path/to/img2'),
  (2, '/path/to/img3'),
  (2, '/path/to/img4'),
  (3, '/path/to/img1'),
  (4, '/path/to/img1');
  
-- Khu ---------------------------------------------
CREATE TABLE Khu (
  MaChiNhanh INT NOT NULL,
  TenKhu VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, TenKhu)
);

ALTER TABLE Khu
	ADD CONSTRAINT fk_Khu_ChiNhanh FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
															ON UPDATE CASCADE
                                                            ON DELETE CASCADE;

INSERT INTO Khu (MaChiNhanh, TenKhu)
VALUES 
  (1, 'Ten Khu 1'),
  (1, 'Ten Khu 2'),
  (2, 'Ten Khu 3'),
  (2, 'Ten Khu 4'),
  (3, 'Ten Khu 4'),
  (3, 'Ten Khu 5'),
  (4, 'Ten Khu 6'),
  (4, 'Ten Khu 7');
-- -------------------------------------Loại phòng ---------------------------------------------
CREATE TABLE LoaiPhong (
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  TenLoaiPhong VARCHAR(127) NOT NULL UNIQUE,
  DienTich FLOAT,
  SoKhach INT NOT NULL,
  MoTa TEXT,
  PRIMARY KEY (MaLoaiPhong)
);

ALTER TABLE LoaiPhong
	ADD CONSTRAINT ck_SoKhachLoaiPhong CHECK (SoKhach >= 1 AND SoKhach <= 10);

INSERT INTO LoaiPhong(TenLoaiPhong, DienTich, SoKhach, MoTa)
VALUES
  ('President', 100, '1', 'Room for VIP only'),
  ('King Room', 80, '1', 'Room for VIP only'),
  ('Queen Room', 60, '1', 'Room for VIP only'),
  ('Family', 100, '4', 'Room for family'),
  ('Couple', 50, '2', 'Room for couple'),
  ('Single', 35, '1', 'Single room');

-- --------------------------------Thông Tin Giường ---------------------------------------------
CREATE TABLE ThongTinGiuong (
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  KichThuoc FLOAT(2, 1) NOT NULL,
  SoLuong INT NOT NULL DEFAULT 1,
  PRIMARY KEY (MaLoaiPhong, KichThuoc)
);

ALTER TABLE ThongTinGiuong
	ADD CONSTRAINT fk_ThongTinGiuong_ChiNhanh FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
																		ON UPDATE CASCADE
																		ON DELETE CASCADE;

INSERT INTO ThongTinGiuong(MaLoaiPhong, KichThuoc, SoLuong)
VALUES
  (1, 1.8, 1),
  (2, 1.6, 1),
  (3, 1.4, 1),
  (4, 1.2, 2),
  (4, 1, 1),
  (5, 1.2, 1),
  (6, 1, 1);
  
-- ----------------------------Chi Nhánh có Loại Phòng ---------------------------------------------
CREATE TABLE ChiNhanhLoaiPhong (
  MaLoaiPhong INT NOT NULL,
  MaChiNhanh INT NOT NULL,
  GiaThue INT NOT NULL,
  PRIMARY KEY (MaLoaiPhong, MaChiNhanh) 
);

ALTER TABLE ChiNhanhLoaiPhong
	ADD CONSTRAINT fk_CNLoaiPhong_LoaiPhong FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
																	  ON UPDATE CASCADE
																	  ON DELETE CASCADE,
	ADD CONSTRAINT fk_CNLoaiPhong_ChiNhanh  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
																	 ON UPDATE CASCADE
																	 ON DELETE CASCADE;															

INSERT INTO ChiNhanhLoaiPhong (MaLoaiPhong, MaChiNhanh, GiaThue)
VALUES
  (1, 3, 2000),
  (1, 4, 3000),
  (2, 1, 1000),
  (3, 1, 1000),
  (4, 1, 1000),
  (5, 1, 1000),
  (2, 2, 1000),
  (3, 2, 1000),
  (6, 3, 1200);
-- --------------------------------------Phòng ---------------------------------------------
CREATE TABLE Phong (
  MaChiNhanh INT NOT NULL,
  SoPhong VARCHAR(16) NOT NULL,
  TenKhu VARCHAR(127) NOT NULL,
  MaLoaiPhong INT NOT NULL,

  PRIMARY KEY (MaChiNhanh, SoPhong)
);

ALTER TABLE Phong
	ADD CONSTRAINT fk_Phong_Khu FOREIGN KEY (MaChiNhanh, TenKhu) REFERENCES Khu(MaChiNhanh, TenKhu)
																 ON UPDATE CASCADE
																 ON DELETE CASCADE,
	ADD CONSTRAINT fk_Phong_LoaiPhong FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
																ON UPDATE CASCADE
																ON DELETE CASCADE;		
-- -------------------------------Loại Vật Tư ---------------------------------------------
CREATE TABLE LoaiVatTu (
  MaLoaiVatTu INT NOT NULL,
  TenLoaiVatTu VARCHAR(127) NOT NULL,

  PRIMARY KEY (MaLoaiVatTu)
);

-- -----------------------------Loại Vật Tư Trong Loại Phòng ---------------------------------------------
CREATE TABLE LoaiVatTuLoaiPhong (
  MaLoaiPhong INT NOT NULL,
  MaLoaiVatTu INT NOT NULL,
  SoLuong INT DEFAULT 1,

  PRIMARY KEY (MaLoaiPhong, MaLoaiVatTu)
);

ALTER TABLE LoaiVatTuLoaiPhong
	ADD CONSTRAINT fk_LVTPhong_LoaiPhong FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE,
	ADD CONSTRAINT fk_LVTPhong_LoaiVatTu FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE;
-- --------------------------------------- Vật Tư ---------------------------------------------
CREATE TABLE  VatTu (
  MaChiNhanh INT NOT NULL,
  MaLoaiVatTu INT NOT NULL,
  STTVatTu INT UNSIGNED NOT NULL,
  SoPhong VARCHAR(16) NOT NULL,
  TinhTrang TEXT,

  PRIMARY KEY (MaChiNhanh, MaLoaiVatTu, STTVatTu)
);

ALTER TABLE VatTu
	ADD CONSTRAINT fk_VatTu_ChiNhanh FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
															  ON UPDATE CASCADE
															  ON DELETE CASCADE,
	ADD CONSTRAINT fk_LVTPhong_Phong FOREIGN KEY (MaChiNhanh, SoPhong) REFERENCES Phong(MaChiNhanh, SoPhong)
																	   ON UPDATE CASCADE
																	   ON DELETE CASCADE;
-- ------------------------------------- Nhà Cung Cấp ---------------------------------------------
CREATE TABLE NhaCungCap (
  MaNhaCungCap INT NOT NULL AUTO_INCREMENT,
  TenNhaCungCap VARCHAR(127) NOT NULL,
  EMAIL VARCHAR(127),
  DiaChi VARCHAR(127),

  PRIMARY KEY (MaNhaCungCap)
);

-- ------------------------------------ Cung Cấp Vật Tư ---------------------------------------------
CREATE TABLE CungCapVatTu (
  MaNhaCungCap INT NOT NULL,
  MaLoaiVatTu INT NOT NULL AUTO_INCREMENT,
  MaChiNhanh INT NOT NULL,

  PRIMARY KEY  (MaLoaiVatTu, MaChiNhanh)
);

ALTER TABLE CungCapVatTu
	ADD CONSTRAINT fk_CCVatTu_ChiNhanh FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
															    ON UPDATE CASCADE
															    ON DELETE CASCADE,
	ADD CONSTRAINT fk_CCVatTu_LVatTu FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu)
															   ON UPDATE CASCADE
															   ON DELETE CASCADE,
    ADD CONSTRAINT fk_CCVatTu_NhaCungCap FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
																	ON UPDATE CASCADE
																	ON DELETE CASCADE;												
                                                               
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
CREATE TABLE DoanhNghiep(
	Prefix VARCHAR(2) DEFAULT "DN",
	MaDoanhNghiep INT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    TenDoanhNghiep VARCHAR(127) NOT NULL,
    
    PRIMARY KEY (MaDoanhNghiep)
);

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
