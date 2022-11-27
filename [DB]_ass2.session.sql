DROP TABLE LoaiPhong;
--@block
DROP TABLE KhuChiNhanh;
DROP TABLE HinhAnhChiNhanh;
DROP TABLE ChiNhanh;

--@block create ChiNhanh table
CREATE TABLE ChiNhanh (
  MaChiNhanh INT NOT NULL AUTO_INCREMENT,
  Tinh VARCHAR(127),
  DiaChi VARCHAR(127),
  DienThoai VARCHAR(32),
  Email VARCHAR(127),
  PRIMARY KEY (MaChiNhanh)
);

--@block
INSERT INTO ChiNhanh (Tinh, DiaChi, DienThoai, Email)
VALUES 
  ('Long An', '48, Truong Dinh, P1', '01234', 'user@gmail.com'),
  ('Dong Thap', '48, Truong Dinh, P1', '0828696919', 'congdat2409@gmail.com'),
  ('Ho Chi Minh', '268 Ly Thuong Kiet, P12, Q10', '0828696919', 'congdat2409@gmail.com'),
  ('Ho Chi Minh', '497 Hoa Hao, P7, Q10', '0828696919', 'datdev2409@gmail.com');

--@block
CREATE TABLE HinhAnhChiNhanh(
  MaChiNhanh INT,
  HinhAnh VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, HinhAnh),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);
--@block
INSERT INTO  HinhAnhChiNhanh (MaChiNhanh, HinhAnh)
VALUES
  (1, '/path/to/img1'),
  (1, '/path/to/img2'),
  (2, '/path/to/img3'),
  (2, '/path/to/img4'),
  (3, '/path/to/img1'),
  (4, '/path/to/img1');

--@block
CREATE TABLE Khu (
  MaChiNhanh INT NOT NULL,
  TenKhu VARCHAR(127) NOT NULL,
  PRIMARY KEY (MaChiNhanh, TenKhu),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

--@block
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

--@block
CREATE TABLE LoaiPhong (
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  TenLoaiPhong VARCHAR(127) NOT NULL UNIQUE,
  DienTich FLOAT,
  SoKhach INT NOT NULL,
  MoTa TEXT,
  PRIMARY KEY (MaLoaiPhong),
  CHECK (SoKhach >= 1 AND SoKhach <= 10)
);

--@block
INSERT INTO LoaiPhong(TenLoaiPhong, DienTich, SoKhach, MoTa)
VALUES
  ('President', 100, '1', 'Room for VIP only'),
  ('King Room', 80, '1', 'Room for VIP only'),
  ('Queen Room', 60, '1', 'Room for VIP only'),
  ('Family', 100, '4', 'Room for family'),
  ('Couple', 50, '2', 'Room for couple'),
  ('Single', 35, '1', 'Single room');


--@block
CREATE TABLE ThongTinGiuong (
  MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
  KichThuoc FLOAT(2, 1) NOT NULL,
  SoLuong INT NOT NULL DEFAULT 1,
  PRIMARY KEY (MaLoaiPhong, KichThuoc),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
);

--@block
INSERT INTO ThongTinGiuong(MaLoaiPhong, KichThuoc, SoLuong)
VALUES
  (1, 1.8, 1),
  (2, 1.6, 1),
  (3, 1.4, 1),
  (4, 1.2, 2),
  (4, 1, 1),
  (5, 1.2, 1),
  (6, 1, 1);

--@block
CREATE TABLE ChiNhanhLoaiPhong (
  MaLoaiPhong INT NOT NULL,
  MaChiNhanh INT NOT NULL,
  GiaThue INT NOT NULL,
  PRIMARY KEY (MaLoaiPhong, MaChiNhanh),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
);

--@block
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

--@block
CREATE TABLE Phong (
  MaChiNhanh INT NOT NULL,
  SoPhong VARCHAR(16) NOT NULL,
  TenKhu VARCHAR(127) NOT NULL,
  MaLoaiPhong INT NOT NULL,

  PRIMARY KEY (MaChiNhanh, SoPhong),
  FOREIGN KEY (MaChiNhanh, TenKhu) REFERENCES Khu(MaChiNhanh, TenKhu),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
)

--@block
CREATE TABLE LoaiVatTu (
  MaLoaiVatTu INT NOT NULL,
  TenLoaiVatTu VARCHAR(127) NOT NULL,

  PRIMARY KEY (MaLoaiVatTu)
)

--@block
CREATE TABLE LoaiVatTuLoaiPhong (
  MaLoaiPhong INT NOT NULL,
  MaLoaiVatTu INT NOT NULL,
  SoLuong INT DEFAULT 1,

  PRIMARY KEY (MaLoaiPhong, MaLoaiVatTu),
  FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),
  FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu)
)

--@block
CREATE TABLE  VatTu (
  MaChiNhanh INT NOT NULL,
  MaLoaiVatTu INT NOT NULL,
  STTVatTu INT UNSIGNED NOT NULL,
  SoPhong VARCHAR(16) NOT NULL,
  TinhTrang TEXT,

  PRIMARY KEY (MaChiNhanh, MaLoaiVatTu, STTVatTu),
  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh),
  FOREIGN KEY (MaChiNhanh, SoPhong) REFERENCES Phong(MaChiNhanh, SoPhong)
)

--@block
CREATE TABLE NhaCungCap (
  MaNhaCungCap INT NOT NULL AUTO_INCREMENT,
  TenNhaCungCap VARCHAR(127) NOT NULL,
  EMAIL VARCHAR(127),
  DiaChi VARCHAR(127),

  PRIMARY KEY (MaNhaCungCap)
)

--@block
CREATE TABLE CungCapVatTu (
  MaNhaCungCap INT NOT NULL,
  MaLoaiVatTu INT NOT NULL AUTO_INCREMENT,
  MaChiNhanh INT NOT NULL,

  PRIMARY KEY  (MaLoaiVatTu, MaChiNhanh),

  FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh),
  FOREIGN KEY (MaLoaiVatTu) REFERENCES LoaiVatTu(MaLoaiVatTu),
  FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
)
