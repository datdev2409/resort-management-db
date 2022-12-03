SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS ChiNhanh;
CREATE TABLE IF NOT EXISTS ChiNhanh (
    MaChiNhanh VARCHAR(6) NOT NULL,
    Tinh VARCHAR(16),
    DiaChi VARCHAR(50),
    DienThoai VARCHAR(12),
    Email VARCHAR(30),
    PRIMARY KEY (MaChiNhanh)
);

DROP TABLE IF EXISTS HinhAnhChiNhanh;
CREATE TABLE IF NOT EXISTS HinhAnhChiNhanh (
    MaChiNhanh VARCHAR(5),
    HinhAnh VARCHAR(127) NOT NULL,
    PRIMARY KEY (MaChiNhanh, HinhAnh),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh (MaChiNhanh)
);

DROP TABLE IF EXISTS Khu;
CREATE TABLE IF NOT EXISTS Khu (
    MaChiNhanh VARCHAR(10),
    TenKhu VARCHAR(16) NOT NULL,
    PRIMARY KEY (MaChiNhanh , TenKhu),
    FOREIGN KEY (MaChiNhanh)
	REFERENCES ChiNhanh (MaChiNhanh)
);

DROP TABLE IF EXISTS LoaiPhong;
CREATE TABLE IF NOT EXISTS LoaiPhong (
    MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
    TenLoaiPhong VARCHAR(16) NOT NULL UNIQUE,
    DienTich FLOAT(5 , 2 ),
    SoKhach INT NOT NULL,
    MoTa VARCHAR(255),
    PRIMARY KEY (MaLoaiPhong),
    CHECK (SoKhach >= 1 AND SoKhach <= 10)
);
  
DROP TABLE IF EXISTS ThongTinGiuong;
CREATE TABLE IF NOT EXISTS ThongTinGiuong (
    MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
    KichThuoc FLOAT(2 , 1 ) NOT NULL,
    SoLuong INT NOT NULL DEFAULT 1,
    PRIMARY KEY (MaLoaiPhong , KichThuoc),
    FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong (MaLoaiPhong),
    CHECK (SoLuong >= 1 AND SoLuong <= 10)
);

DROP TABLE IF EXISTS ChiNhanh_LoaiPhong;
CREATE TABLE IF NOT EXISTS ChiNhanh_LoaiPhong (
    MaChiNhanh VARCHAR(5),
    MaLoaiPhong INT,
    GiaThue INT NOT NULL,
    PRIMARY KEY (MaLoaiPhong , MaChiNhanh),
    FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong (MaLoaiPhong),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh (MaChiNhanh)
);

DROP TABLE IF EXISTS Phong;
CREATE TABLE IF NOT EXISTS Phong (
    MaChiNhanh VARCHAR(5),
    SoPhong VARCHAR(3) NOT NULL,
    TenKhu VARCHAR(16) NOT NULL,
    MaLoaiPhong INT NOT NULL,
    PRIMARY KEY (MaChiNhanh , SoPhong),
    FOREIGN KEY (MaChiNhanh , TenKhu) REFERENCES Khu (MaChiNhanh , TenKhu),
    FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong (MaLoaiPhong)
);

DROP TABLE IF EXISTS LoaiVatTu;
CREATE TABLE IF NOT EXISTS LoaiVatTu (
    MaLoaiVatTu VARCHAR(6),
    TenLoaiVatTu VARCHAR(25) NOT NULL,
    PRIMARY KEY (MaLoaiVatTu)
);

DROP TABLE IF EXISTS LoaiVatTu_LoaiPhong;
CREATE TABLE IF NOT EXISTS LoaiVatTu_LoaiPhong (
    MaLoaiVatTu VARCHAR(6),
    MaLoaiPhong INT NOT NULL,
    SoLuong INT DEFAULT 1,
    PRIMARY KEY (MaLoaiPhong , MaLoaiVatTu),
    FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong (MaLoaiPhong),
    FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu (MaLoaiVatTu),
    CHECK (SoLuong >= 1 AND SoLuong <= 20)
);

DROP TABLE IF EXISTS VatTu;
CREATE TABLE IF NOT EXISTS VatTu (
    MaChiNhanh VARCHAR(5),
    MaLoaiVatTu VARCHAR(6),
    STTVatTu INT UNSIGNED NOT NULL,
    SoPhong VARCHAR(3) NOT NULL,
    TinhTrang TEXT,
    PRIMARY KEY (MaChiNhanh , MaLoaiVatTu , STTVatTu),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh (MaChiNhanh),
    FOREIGN KEY (MaChiNhanh , SoPhong) REFERENCES Phong (MaChiNhanh , SoPhong),
    FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu (MaLoaiVatTu)
);

DROP TABLE IF EXISTS NhaCungCap;
CREATE TABLE IF NOT EXISTS NhaCungCap (
    MaNhaCungCap VARCHAR(7) NOT NULL,
    TenNhaCungCap VARCHAR(50) NOT NULL,
    Email VARCHAR(30),
    DiaChi VARCHAR(50),
    PRIMARY KEY (MaNhaCungCap)
);

DROP TABLE IF EXISTS CungCapVatTu;
CREATE TABLE IF NOT EXISTS CungCapVatTu (
    MaNhaCungCap VARCHAR(7) NOT NULL,
    MaLoaiVatTu VARCHAR(6) NOT NULL,
    MaChiNhanh VARCHAR(5) NOT NULL,
    PRIMARY KEY (MaLoaiVatTu , MaChiNhanh),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh (MaChiNhanh),
    FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu (MaLoaiVatTu),
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap (MaNhaCungCap)
);

-- ---------------------------------- Khách Hàng ---------------------------------------------
DROP TABLE IF EXISTS KhachHang;
CREATE TABLE IF NOT EXISTS KhachHang(
    MaKhachHang VARCHAR(8),
    CCCD VARCHAR(12) NOT NULL UNIQUE,
    HoVaTen VARCHAR(50) NOT NULL,
    DienThoai VARCHAR(12) NOT NULL UNIQUE,
    Email VARCHAR(127) UNIQUE,
    Username VARCHAR(127) NOT NULL UNIQUE,
    Password VARCHAR(127) NOT NULL,
    Diem INT NOT NULL DEFAULT 0,
    Loai INT NOT NULL DEFAULT 1,
    
    PRIMARY KEY (MaKhachHang),
    
    CHECK (Loai >= 1 and Loai <= 4)
);

-- --------------------------------- Gói Dich Vụ ---------------------------------------------
DROP TABLE IF EXISTS GoiDichVu;
CREATE TABLE IF NOT EXISTS GoiDichVu(
	TenGoi VARCHAR(30) NOT NULL UNIQUE,
	SoNgay INT NOT NULL,
	SoKhach INT NOT NULL,
	Gia INT NOT NULL,
    
	PRIMARY KEY (TenGoi),
	CONSTRAINT ck_SoNgay CHECK (SoNgay >=1 and SoNgay <= 100),
	CONSTRAINT ck_SoKhach CHECK (SoKhach >= 1 and SoKhach <= 10)
);	
  
-- -------------------------------- Hóa Đơn Gói Dịch Vụ ---------------------------------------------
DROP TABLE IF EXISTS HoaDonGoiDichVu;
CREATE TABLE IF NOT EXISTS HoaDonGoiDichVu(
	MaKhachHang VARCHAR(8) NOT NULL,
	TenGoi VARCHAR(30) NOT NULL,
	NgayGioMua DATETIME,
	NgayBatDau DATETIME,
	TongTien INT NOT NULL,
    
	PRIMARY KEY (MaKhachHang, TenGoi, NgayGioMua),
    FOREIGN KEY (TenGoi) REFERENCES GoiDichVu(TenGoi),
	CONSTRAINT fk_HoaDonGoiDV_KH FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
															 ON UPDATE CASCADE
															 ON DELETE CASCADE,
-- 	CONSTRAINT fk_HoaDonGoiDV_GoiDV FOREIGN KEY (TenGoi) REFERENCES GoiDichVu(TenGoi)
-- 														 ON UPDATE CASCADE
-- 														 ON DELETE NO ACTION,
    
	CONSTRAINT ck_BatDau_KetThuc CHECK (NgayBatDau > NgayGioMua)
);

-- --------------------------------- Đơn Đặt Phòng ---------------------------------------------

DROP TABLE IF EXISTS DonDatPhong;
CREATE TABLE IF NOT EXISTS DonDatPhong(
	MaDatPhong VARCHAR(16) NOT NULL,
	NgayGioDat DATETIME NOT NULL,
	SoKhach INT NOT NULL,
	NgayNhanPhong DATE NOT NULL,
	NgayTraPhong DATE NOT NULL,
	TinhTrang INT(1) NOT NULL DEFAULT 0,
	TongTien INT UNSIGNED NOT NULL DEFAULT 0,
	MaKhachHang VARCHAR(8),
	TenGoiDichVu VARCHAR(127) DEFAULT NULL,
    
	PRIMARY KEY (MaDatPhong),
    FOREIGN KEY (MaKhachHang, TenGoiDichVu) REFERENCES HoaDonGoiDichVu(MaKhachHang, TenGoi),
	-- CONSTRAINT fk_DonDatPhong_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
-- 																  ON UPDATE CASCADE
-- 																  ON DELETE NO ACTION,
-- 	CONSTRAINT fk_DonDatPhong_GoiDichVu FOREIGN KEY (TenGoiDichVu) REFERENCES GoiDichVu(TenGoi)
-- 																   ON UPDATE CASCADE
-- 																   ON DELETE NO ACTION,
                         
	-- CONSTRAINT ck_NhanPhong_DatPhong CHECK (NgayNhanPhong > DATE(NgayGioDat)),
	CONSTRAINT ck_TraPhong_NhanPhong CHECK (NgayTraPhong > NgayNhanPhong),
	CONSTRAINT ck_TinhTrang CHECK (TinhTrang >= 0 AND TinhTrang <= 3)
);


-- --------------------------------- Phòng Thuê ----------------------------------------------------
DROP TABLE IF EXISTS PhongThue;
CREATE TABLE IF NOT EXISTS PhongThue(
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

-- ------------------------------------- Hóa Đơn ---------------------------------------------

DROP TABLE IF EXISTS HoaDon;
CREATE TABLE IF NOT EXISTS HoaDon(
	MaHoaDon VARCHAR(16),
	ThoiGianNhanPhong TIME NOT NULL,
	ThoiGianTraPhong TIME NOT NULL,
	MaDatPhong VARCHAR(16),
    
	PRIMARY KEY (MaHoaDon),
	CONSTRAINT fk_HoaDon_DDPhong FOREIGN KEY (MaDatPhong) REFERENCES DonDatPhong(MaDatPhong)

);

-- ---------------------------------- Doanh Nghiệp ---------------------------------------------
DROP TABLE IF EXISTS DoanhNghiep;
CREATE TABLE IF NOT EXISTS DoanhNghiep(
	MaDoanhNghiep VARCHAR(6),
	TenDoanhNghiep VARCHAR(30) NOT NULL,
    
	PRIMARY KEY (MaDoanhNghiep)
);

-- ------------------------------------- Dịch Vụ ------------------------------------------------
DROP TABLE IF EXISTS DichVu;
CREATE TABLE IF NOT EXISTS DichVu(
	MaDichVu VARCHAR(6),
	LoaiDichVu VARCHAR(1) NOT NULL,
	MaDoanhNghiep VARCHAR(6),
    
	PRIMARY KEY (MaDichVu),
	FOREIGN KEY (MaDoanhNghiep) REFERENCES DoanhNghiep(MaDoanhNghiep)
);


DROP TABLE IF EXISTS DichVuNhaHang;
CREATE TABLE IF NOT EXISTS DichVuNhaHang (
	MaDichVu VARCHAR(6),
	SoKhach INT,
	PhongCach VARCHAR(127),
  
	PRIMARY KEY (MaDichVu),
	FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu),
  
	CHECK (MaDichVu LIKE 'DNR%')
);

DROP TABLE IF EXISTS DichVuSpa;
CREATE TABLE IF NOT EXISTS DichVuSpa (
	MaDichVu VARCHAR(6),
	DichVuSpa VARCHAR(255),
  
	PRIMARY KEY (MaDichVu, DichVuSpa),
	FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu),
  
	CHECK (MaDichVu LIKE 'DNS%')
);

DROP TABLE IF EXISTS LoaiHangDoLuuNiem;
CREATE TABLE IF NOT EXISTS LoaiHangDoLuuNiem (
	MaDichVu VARCHAR(6),
	LoaiHang VARCHAR(30),
  
	PRIMARY KEY (MaDichVu, LoaiHang),
	FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu),
  
	CHECK (MaDichVu LIKE 'DNM%')
);

DROP TABLE IF EXISTS ThuongHieuDoLuuNiem;
CREATE TABLE IF NOT EXISTS ThuongHieuDoLuuNiem (
	MaDichVu VARCHAR(6),
	ThuongHieu VARCHAR(30),
  
	PRIMARY KEY (MaDichVu, ThuongHieu),
	FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu),
  
	CHECK (MaDichVu LIKE 'DNM%')
);

DROP TABLE IF EXISTS MatBang;
CREATE TABLE IF NOT EXISTS MatBang(
	MaChiNhanh VARCHAR(5) NOT NULL,
    STTMatBang INT UNSIGNED NOT NULL,
	GiaThue INT NOT NULL,
    MaDichVu VARCHAR(6) DEFAULT NULL,
    
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
DROP TABLE IF EXISTS HinhAnhCuaHang;
CREATE TABLE IF NOT EXISTS HinhAnhCuaHang(
	MaChiNhanh VARCHAR(5),
    STTMatBang INT UNSIGNED NOT NULL,
    HinhAnh VARCHAR(128),
    
    PRIMARY KEY (MaChiNhanh, STTMatBang, HinhAnh)
);

 ALTER TABLE HinhAnhCuaHang
	ADD CONSTRAINT fk_HinhAnhCH_MatBang FOREIGN KEY (MaChiNhanh, STTMatBang) REFERENCES MatBang(MaChiNhanh, STTMatBang)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE;

                                                        
-- ----------------------------- Khung Giờ Hoạt Động Cửa Hàng ---------------------------------------------
DROP TABLE IF EXISTS KhungGioHoatDong;
CREATE TABLE IF NOT EXISTS KhungGioHoatDong(
	MaChiNhanh VARCHAR(5),
    STTMatBang INT UNSIGNED NOT NULL,
    GioBatDau TIME,
    GioKetThuc TIME,
    
    PRIMARY KEY (MaChiNhanh,STTMatBang, GioBatDau)
);

ALTER TABLE KhungGioHoatDong
	ADD CONSTRAINT fk_GioHD_MatBang FOREIGN KEY (MaChiNhanh, STTMatBang) REFERENCES MatBang(MaChiNhanh, STTMatBang)
																   ON UPDATE CASCADE
																   ON DELETE CASCADE;

