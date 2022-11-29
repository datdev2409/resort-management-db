INSERT INTO ChiNhanh (Tinh, DiaChi, DienThoai, Email)
VALUES 
	("Dong Thap", "48, Truong Dinh, P1", "0828696919", "dt_48@gmail.com"),
	("Can Tho", "20, Ninh Kieu, P3", "0982872456", "ct_20@gmail.com"),
	("Ho Chi Minh", "497, Hoa Hao, P7", "08286964569", "hcm_497@gmail.com"),
	("Ho Chi Minh", "267, Ly Thuong Kiet, P15", "0828624919", "hcm_267@gmail.com"),
	("Binh Thuan", "11, Ly Thai To, P1", "0238696919", "bt_11@gmail.com");

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

INSERT INTO LoaiPhong(TenLoaiPhong, DienTich, SoKhach, MoTa)
VALUES
	('President', 60.5, '1', 'The most ornate rooms in the resort'),
	('King Room', 50, '1', 'A well-furnished room with king-size bed'),
	('Queen Room', 40, '1', 'A well-furnished room with queen-size bed'),
	('Family', 30, '4', 'Standard room for family (4 people)'),
	('Couple', 28, '2', 'The romantic asmosphere for couple'),
	('Double', 25, '2', 'Standard room for 2 people'),
	('Single', 20, '1', 'Standard room for 1 person');

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

INSERT INTO LoaiVatTu (TenLoaiVatTu)
VALUES
	("Ghe"), ("Sofa"), ("TV"), ("May Lanh"), ("Tu Lanh"),
  ("PS5"), ("Khăn"), ("Bo ve sinh ca nhan");
    
INSERT INTO LoaiVatTu_LoaiPhong(MaLoaiPhong, MaLoaiVatTu, SoLuong)
VALUE
	("7", "VT0002", 1), ("7", "VT0003", 1), ("7", "VT0006", 1), ("7", "VT0007", 1),
    ("6", "VT0002", 1), ("6", "VT0003", 1), ("6", "VT0004", 1), ("6", "VT0006", 2), ("6", "VT0007", 2),
    ("5", "VT0001", 1), ("5", "VT0002", 1), ("5", "VT0003", 1), ("5", "VT0004", 1), ("5", "VT0005", 1), ("5", "VT0006", 2), ("5", "VT0007", 2),
    ("4", "VT0002", 1), ("4", "VT0003", 1), ("4", "VT0004", 1), ("4", "VT0005", 1), ("4", "VT0006", 2), ("4", "VT0007", 2),
    ("3", "VT0002", 1), ("3", "VT0003", 1), ("3", "VT0004", 1), ("3", "VT0005", 1), ("3", "VT0006", 2), ("3", "VT0007", 2),
    ("2", "VT0002", 1), ("2", "VT0003", 1), ("2", "VT0004", 1), ("2", "VT0005", 1), ("2", "VT0006", 2), ("2", "VT0007", 2),
    ("1", "VT0002", 1), ("1", "VT0003", 1), ("1", "VT0004", 1), ("1", "VT0005", 1), ("1", "VT0006", 2), ("1", "VT0007", 2);

INSERT INTO VatTu(MaChiNhanh, MaLoaiVatTu, STTVatTu, SoPhong, TinhTrang)
VALUES
	("CN1", "VT0001", 1, "101", "Nguyen Ven"), ("CN1", "VT0001", 2, "102", "Nguyen Ven"), ("CN1", "VT0001", 3, "103", "Hoi phai mau ben canh phai"),
	("CN1", "VT0002", 1, "101", "Nguyen Ven"), ("CN1", "VT0002", 2, "102", "Hoi phai mau ben canh trai"), ("CN1", "VT0002", 3, "103", "Nguyen Ven"),

    ("CN2", "VT0001", 1, "101", "Nguyen Ven"), ("CN2", "VT0001", 2, "102", "Nguyen Ven"),
    ("CN2", "VT0002", 1, "101", "Nguyen Ven"), ("CN2", "VT0002", 2, "102", "Nguyen Ven"),
    ("CN2", "VT0003", 1, "101", "Nguyen Ven"), ("CN2", "VT0003", 2, "102", "Nguyen Ven"),
    
    ("CN3", "VT0006", 1, "201", "Da thay moi"), ("CN3", "VT0006", 2, "202", "Da thay moi"),
    ("CN3", "VT0007", 1, "201", "Da thay moi"), ("CN3", "VT0007", 2, "202", "Da thay moi"),
    
    ("CN4", "VT0005", 1, "101", "Nguyen Ven"), ("CN4", "VT0005", 2, "102", "Bi hu 1 controller"),
    ("CN4", "VT0003", 1, "101", "Nguyen Ven"), ("CN4", "VT0003", 2, "102", "Nguyen Ven"),
    
	("CN5", "VT0006", 1, "501", "Da thay moi"), ("CN5", "VT0006", 2, "501", "Da thay moi"), ("CN5", "VT0006", 3, "505", "Nguyen Ven"),
	("CN5", "VT0004", 1, "501", "Day du thuc pham"), ("CN5", "VT0004", 2, "505", "Day du thuc pham"), ("CN5", "VT0004", 3, "601", "Thieu ruou vang, nuoc ngot"),
	("CN5", "VT0005", 1, "501", "Nguyen Ven"), ("CN5", "VT0005", 2, "505", "Nguyen Ven"), ("CN5", "VT0005", 3, "601", "Nguyen Ven");
    
INSERT INTO NhaCungCap(TenNhaCungCap, Email, DiaChi)
VALUES
	('Quitzon Group', 'holley6@stumbleupon.com', '5670 Morrow Pass'),
	('Fahey, Pfannerstill and Beatty', 'htomkys5@unc.edu', '2 Sunbrook Parkway'),
	('Maggio, O''Hara and Brakus', 'rrenzini4@slashdot.org', '2228 Autumn Leaf Avenue'),
	('Brekke LLC', 'rlockery3@cornell.edu', '0807 Little Fleur Way'),
	('Feil-Hegmann', 'jbetjeman2@lycos.com', '11416 Susan Court'),
    ('Ortiz-Schmidt', 'ejewell1@tinyurl.com', '40 Karstens Lane'),
    ('Turner Group', 'ntolley0@blogtalkradio.com', '5 Onsgard Avenue');

INSERT INTO CungCapVatTu(MaNhaCungCap, MaLoaiVatTu, MaChiNhanh)
VALUES
	('NCC0001', 'VT0001', 'CN1'), ('NCC0001', 'VT0002', 'CN1'),
    ('NCC0001', 'VT0001', 'CN2'), ('NCC0001', 'VT0002', 'CN2'),
    ('NCC0002', 'VT0001', 'CN3'), ('NCC0002', 'VT0002', 'CN3'),
    ('NCC0002', 'VT0001', 'CN4'), ('NCC0002', 'VT0002', 'CN4'),
    ('NCC0003', 'VT0001', 'CN5'), ('NCC0003', 'VT0002', 'CN5'),
    
    ('NCC0004', 'VT0004', 'CN1'), ('NCC0004', 'VT0005', 'CN1'),
    ('NCC0004', 'VT0004', 'CN2'), ('NCC0004', 'VT0005', 'CN2'),
    ('NCC0005', 'VT0004', 'CN3'), ('NCC0005', 'VT0005', 'CN3'),
    ('NCC0005', 'VT0004', 'CN4'), ('NCC0005', 'VT0005', 'CN4'),
    ('NCC0006', 'VT0004', 'CN5'), ('NCC0006', 'VT0005', 'CN5'),
    
    ('NCC0007', 'VT0006', 'CN1'), ('NCC0007', 'VT0007', 'CN1'),
    ('NCC0007', 'VT0006', 'CN2'), ('NCC0007', 'VT0007', 'CN2'),
    ('NCC0007', 'VT0006', 'CN3'), ('NCC0007', 'VT0007', 'CN3'),
    ('NCC0007', 'VT0006', 'CN4'), ('NCC0007', 'VT0007', 'CN4'),
    ('NCC0007', 'VT0006', 'CN5'), ('NCC0007', 'VT0007', 'CN5');
    
INSERT INTO KhachHang (CCCD, HoVaTen, DienThoai, Email, Username, Password, Diem, Loai)
VALUES
	('342056301', 'Nguyen Cong Dat', '0828696919', 'datdev2409@gmail.com', 'congdat2409', 'idontsay', 60, 1),
	('123654987', 'Nguyen Van A', '0982872456', 'vana123@gmail.com', 'vana123', 'hiddenpass', 0, 1),
	('098123845', 'Tran Thi B', '082813426', 'thib098@gmail.com', 'thib098', 'password456', 0, 1),
	('333444555', 'Le Van C', '082838920', 'vanc3344@gmail.com', 'vanc3344', 'password123', 0, 1);

INSERT INTO GoiDichVu (TenGoi, SoNgay, SoKhach, Gia)
VALUES
	('BUSINESS PACKAGE', 30, 2, 20000),
	('PERSONAL PACKAGE', 10, 1, 5000),
	('FAMILY PACKAGE', 20, 4, 10000);

INSERT INTO HoaDonGoiDichVu (MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
VALUES
	("KH000001", 'FAMILY PACKAGE', '2022-11-28 08:00:00', '2022-11-28 10:00:00', 10000),
	("KH000002", 'BUSINESS PACKAGE', '2022-11-25 08:00:00', '2022-11-25 15:00:00', 20000),
	("KH000003", 'PERSONAL PACKAGE', '2022-11-28 12:00:00', '2022-11-28 14:00:00', 5000);

INSERT INTO DonDatPhong(NgayGioDat, SoKhach, NgayNhanPhong, NgayTraPhong, TinhTrang, TongTien, MaKhachHang, TenGoiDichVu)
VALUES
	('2022-03-8 23:56:29', 92, '2022-03-10', '2022-03-12', 1, 3508, 'KH000001', 'FAMILY PACKAGE'),
	('2022-8-13 03:58:21', 71, '2022-09-19', '2022-11-21', 1, 4103, 'KH000003', 'FAMILY PACKAGE'),
	('2022-8-30 19:50:54', 19, '2022-10-17', '2022-11-17', 1, 2069, 'KH000004', 'FAMILY PACKAGE'),
	('2022-2-28 01:37:17', 17, '2022-03-11', '2022-05-10', 1, 1363, 'KH000002', 'BUSINESS PACKAGE'),
	('2022-02-22 15:51:52', 7, '2022-02-23', '2022-02-24', 1, 3365, 'KH000002', 'BUSINESS PACKAGE');
  
INSERT INTO PhongThue (MaDatPhong, MaChiNhanh, SoPhong)
VALUES
	('DP08032022000003', 'CN1', '101'),
	('DP13082022000004', 'CN2', '101'),
	('DP22022022000007', 'CN3', '201'),
	('DP28022022000006', 'CN4', '102'),
	('DP30082022000005', 'CN5', '501');

INSERT INTO HoaDon (MaDatPhong, ThoiGianNhanPhong, ThoiGianTraPhong)
VALUES
	('DP08032022000003', '8:30', '12:00'),
	('DP13082022000004', '13:00', '17:00'),
	('DP22022022000007', '7:40', '12:20'),
	('DP28022022000006', '6:50', '8:30'),
	('DP30082022000005', '9:40', '10:10');

INSERT INTO DoanhNghiep (TenDoanhNghiep)
VALUES
	('Lotte'), ('KichiKichi'), ('SUMO BBQ'), 
	('Hoang Gia'), ('Heaven'),
	('Circile K'), ('Vinmart'), ('GS25'),
	('Alibaba'), ('Kitty Store'), ('XPOSE');

INSERT INTO DichVu (LoaiDichVu, MaDoanhNghiep)
VALUES 
	('R', 'DN0001'),
	('R', 'DN0002'),
	('R', 'DN0003'),
	('S', 'DN0004'),
	('S', 'DN0005'),
	('C', 'DN0006'),
	('C', 'DN0007'),
	('C', 'DN0008'),
	('M', 'DN0009'),
	('M', 'DN0010'),
	('B', 'DN0011');

INSERT INTO DichVuNhaHang (MaDichVu, SoKhach, PhongCach)
VALUES
	('DNR001', '30', 'fast food'),
	('DNR002', '40', 'hotpot'),
	('DNR003', '50', 'bbq and beer');

INSERT INTO DichVuSpa (MaDichVu, DichVuSpa)
VALUES
	('DNS004', 'massage'),
	('DNS004', 'hair salon'),
	('DNS004', 'skin improvement'),
	('DNS005', 'massage'),
	('DNS005', 'hair salon'),
	('DNS005', 'skin improvement');

INSERT INTO LoaiHangDoLuuNiem (MaDichVu, LoaiHang)
VALUES
	('DNM009', 'batman toy'),
	('DNM009', 'car toy'),
	('DNM009', 'watch'),
  
	('DNM010', 'hello kitty'),
	('DNM010', 'dress'),
	('DNM010', 'hat');

INSERT INTO ThuongHieuDoLuuNiem (MaDichVu, ThuongHieu)
VALUES
	('DNM009', 'H&M'),
	('DNM009', 'Coomate'),
	('DNM009', 'Uniqlo'),
  
	('DNM010', 'Elise'),
	('DNM010', 'CANVAS'),
	('DNM010', 'LV');

INSERT INTO MatBang(MaChiNhanh, STTMatBang, GiaThue, MaDichVu)
VALUES
	('CN1',1, '39719', 'DVR001'),
	('CN1',2, '20534', 'DVR002'),
    ('CN2',1, '84479', 'DVR003'),
    ('CN3',1, '36734', 'DNS005'),
    ('CN3',2, '48631', 'DVM010'),
    ('CN4',1, '36734', 'DVB011'),
    ('CN4',2, '36734', 'DNC007'),
    ('CN5',1, '90321', 'DVS004');

INSERT INTO HinhAnhCuaHang(MaChiNhanh, STTMatBang, HinhAnh)
VALUES
	('CN1',1, '/home/image/cn1/1.png'),
	('CN1',2, '/home/image/cn1/2.png'),
    ('CN2',1, '/home/image/cn2/1.png'),
    ('CN3',1, '/home/image/cn3/1.png'),
    ('CN3',2, '/home/image/cn3/2.png'),
    ('CN4',1, '/home/image/cn4/1.png'),
    ('CN4',2, '/home/image/cn4/2.png'),
    ('CN5',1, '/home/image/cn5/1.png');

INSERT INTO KhungGioHoatDong(MaChiNhanh, STTMatBang, GioBatDau, GioKetThuc)
VALUES
	('CN1',1, '7:30:00', "9:30:00"),
	('CN1',2, '7:30:00', "9:30:00"),
    ('CN2',1, '7:30:00', "9:30:00"),
    ('CN3',1, '7:30:00', "9:30:00"),
    ('CN3',2, '7:30:00', "9:30:00"),
    ('CN4',1, '7:30:00', "9:30:00"),
    ('CN4',2,'00:00:00', "24:00:00"),
    ('CN5',1, '7:30:00', "9:30:00");
