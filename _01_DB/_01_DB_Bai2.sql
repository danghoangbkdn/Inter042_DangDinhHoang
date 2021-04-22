-- 1/ Thêm mới thông tin cho tất cả các bảng có trong CSDL để có thể thõa mãn các yêu cầu bên dưới.(Done)

-- 2/ Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
select *
from nhanvien
where left(HoTen, 1) in ('H', 'T', 'P') and length(HoTen) < 30;

-- 3/ Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select *
from khachhang
where DiaChi like '%Da Nang%' or DiaChi like '%Quang Tri%' and year(current_date()) - year(NgaySinh) between 18 and 50;

-- 4/ Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của
-- khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
select kh.HoTen, count(*) SoHopDong
from hopdong hd
join khachhang kh on kh.IdKH = hd.KhachHang_IdKH
join loaikhach lk on lk.IdLK = kh.LoaiKhach_IdLK
where lk.TenLK = 'Diamond'
group by kh.IdKH
order by count(*) asc;

-- 5/ Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien (Với TongTien được tính theo
-- công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả các Khách hàng đã từng đặt phỏng.
-- (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
with dp_cte as (
	select kh.IdKH, kh.HoTen, (dvdk.Gia*dvdk.DonVi + dv.GiaThue) TongTien, lk.TenLK, hd.IdHD, dv.TenDV, hd.NgayLamHD, hd.NgayKetThuc
	from khachhang kh
	join loaikhach lk on lk.IdLK = kh.LoaiKhach_IdLK
	join hopdong hd on kh.IdKh = hd.khachhang_IdKH
	join dichvu dv on dv.IdDV = hd.DichVu_IdDV
	join hopdongchitiet hdct on hd.IdHD = hdct.HopDong_IdHD
	join dichvudikem dvdk on dvdk.IdDVDK = hdct.DichVuDiKem_IdDVDK
	group by kh.IdKH
)
select kh.IdKH, kh.HoTen, cte.TenLK, cte.IdHD, cte.TenDV, cte.NgayLamHD, cte.NgayKetThuc, cte.TongTien
from khachhang kh
left join dp_cte cte on kh.IdKH = cte.IdKH;

-- 6/ Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu của tất cả các loại Dịch vụ chưa từng được Khách hàng thực hiện
-- đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3).
with ldv_cte as (
	select distinct ldv.IdLDV IdLDV, dv.IdDV, dv.TenDV, dv.DienTich, dv.GiaThue
	from dichvu dv
	join hopdong hd on dv.IdDV = hd.dichvu_IdDV
	join loaidichvu ldv on ldv.IdLDV = dv.loaidichvu_IdLDV
    where hd.NgayLamHD between '2021-01-01' and '2021-02-28'
)
select cte.IdDV, cte.TenDV, cte.DienTich, cte.GiaThue,ldv.IdLDV, ldv.TenLDV
from ldv_cte cte
right join loaidichvu ldv on cte.IdLDV = ldv.IdLDV
where cte.IdLDV is null or ldv.IdLDV is null;

-- 7/ Hiển thị thông tin IDDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, TenLoaiDichVu của tất cả các loại dịch vụ đã từng được
-- Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách hàng đặt phòng trong năm 2019.
with dv_cte as (
	select distinct ldv.IdLDV, ldv.TenLDV
	from dichvu dv
	join loaidichvu ldv on ldv.IdLDV = dv.loaidichvu_IdLDV
	join hopdong hd on dv.IdDV = hd.dichvu_IdDV
	where month(hd.NgayLamHD) = '02'
)
select ldv.IdLDV, ldv.TenLDV
from dv_cte cte
right join loaidichvu ldv on ldv.IdLDV = cte.IdLDV
where cte.IdLDV is null or ldv.IdLDV is null;

-- 8/ Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoTenKhachHang không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên
-- C1:
select *
from khachhang
group by HoTen
having count(*) < 2;

-- C2:

-- C3:

-- 9/ Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2019 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
select month(NgayLamHD) `Thang(2021)`, sum(TongTien) DoanhThu
from hopdong
where year(NgayLamHD) = '2021'
group by DATE_FORMAT(NgayLamHD, '%Y %m');

-- 10/ Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. Kết quả hiển thị bao gồm IDHopDong,
-- NgayLamHopDong, NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem (được tính dựa trên việc count các IDHopDongChiTiet).
select hd.IdHD, count(dvdk.DonVi) SoLuongDV, group_concat(concat(dvdk.TenDVDK, ': ', dvdk.DonVi) separator ', ') CacDichVu
from hopdong hd
join hopdongchitiet hdct on hd.IdHD = hdct.hopdong_IdHD
join dichvudikem dvdk on dvdk.IdDVDK = hdct.dichvudikem_IdDVDK
group by hd.IdHD;

-- 11/ Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang là “Diamond” và có địa chỉ là “Vinh”
-- hoặc “Quảng Ngãi”.
select kh.IdKH, kh.HoTen, group_concat(dvdk.TenDVDK separator ', ') DichVuDiKem
from khachhang kh
join loaikhach lk on kh.loaikhach_IdLK = lk.IdLK
join hopdong hd on kh.IdKH = hd.khachhang_IdKH
join hopdongchitiet hdct on hd.IdHD = hdct.hopdong_IdHD
join dichvudikem dvdk on dvdk.IdDVDK = hdct.dichvudikem_IdDVDK
where kh.DiaChi like ('%Da Nang%') and lk.TenLK = 'Diamond'
group by kh.IdKH;

-- 12/ Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang, SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem (được tính dựa trên
-- tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa
-- từng được khách hàng đặt vào 6 tháng đầu năm 2019.
with dv_cte as (
	select distinct dv.TenDV, hd.IdHD, dv.IdDV
	from hopdong hd
    join khachhang kh on kh.IdKH = hd.khachhang_IdKH
	join nhanvien nv on hd.nhanvien_IdNV = nv.IdNV
	join dichvu dv on dv.IdDV = hd.dichvu_IdDV
	join hopdongchitiet hdct on hd.IdHD = hdct.hopdong_IdHD
	where month(NgayLamHD) between '01' and '02'
	group by dv.TenDV
)
select hd.IdHD, nv.HoTen NhanVien, kh.HoTen, hd.NgayLamHD, dv.TenDV, hdct.SoLuong SoLuongDichVuDiKem, group_concat(dvdk.TenDVDK separator ', ') CacDichVu
from hopdong hd
join khachhang kh on kh.IdKH = hd.khachhang_IdKH
join nhanvien nv on hd.nhanvien_IdNV = nv.IdNV
join dichvu dv on dv.IdDV = hd.dichvu_IdDV
join hopdongchitiet hdct on hd.IdHD = hdct.hopdong_IdHD
join dichvudikem dvdk on dvdk.IdDVDK = hdct.dichvudikem_IdDVDK
left join dv_cte cte on dv.IdDV = cte.IdDV
where cte.IdDV is null or dv.IdDV is null and month(hd.NgayLamHD) = '03'
group by hd.idHD;

-- 13/ Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
with max_cte as (
	select dvdk.IdDVDK, count(dvdk.IdDVDK) SoLanDat, dvdk.TenDVDK  -- group_concat(dvdk.TenDVDK separator ', ') DichVuChiTiet
	from hopdong hd
	join hopdongchitiet cthd on hd.IdHD = cthd.hopdong_IdHD
	join dichvudikem dvdk on dvdk.IdDVDK = cthd.dichvudikem_IdDVDK
	group by dvdk.IdDVDK
)
select max_cte.IdDVDK, max(max_cte.SoLanDat) SoLanDat, max_cte.TenDVDK
from max_cte;

-- 14/ Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu,
-- TenDichVuDiKem, SoLanSuDung.
select hd.IdHD, dvdk.IdDVDK, count(*) SoLanDat, dvdk.TenDVDK
from hopdong hd
join hopdongchitiet hdct on hd.IdHD = hdct.hopdong_IdHD
join dichvudikem dvdk on dvdk.IdDVDK = hdct.dichvudikem_IdDVDK
group by dvdk.IdDVDK
having count(*) = 1;


-- 15/ Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, DiaChi mới chỉ lập được tối đa 3
-- hợp đồng từ năm 2018 đến 2019.
select nv.IdNV, nv.HoTen, count(*) SoHopDong, td.TrinhDo, bp.TenBP, nv.SDT, nv.DiaChi
from nhanvien nv
join hopdong hd on nv.IdNV = hd.nhanvien_IdNV
join trinhdo td on td.IdTD = nv.trinhdo_IdTD
join bophan bp on bp.IdBP = nv.bophan_IdBP
group by nv.IdNV
having count(*) < 3;



-- 16/ Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2017 đến năm 2019.
with del_cte as (
	select nv.IdNV
	from nhanvien nv
	left join hopdong hd on nv.IdNV = hd.nhanvien_IdNV
	where hd.nhanvien_IdNV is null
)
delete
from nhanvien nv
where IdNV = ( select IdNV
			   from del_cte cte
               where nv.IdNV = cte.IdNV
) and IdNV <> 1;


-- 17/ Cập nhật thông tin những khách hàng có TenLoaiKhachHang từ Platinium lên Diamond, chỉ cập nhật những khách hàng đã từng đặt
-- phòng với tổng Tiền thanh toán trong năm 2019 là lớn hơn 10.000.000 VNĐ.
with upd_cte as (
	select kh.IdKH
	from khachhang kh
	join hopdong hd on kh.IdKH = hd.khachhang_IdKH
	join loaikhach lk on lk.IdLK = kh.loaikhach_IdLK
	where year(hd.NgayLamHD) = '2021' and hd.TongTien > 10000000 and lk.TenLK = 'Platinium'
)
update khachhang kh
set loaikhach_IdLK = 1 -- id: 1 => 'Diamond'
where IdKH = ( select cte.IdKH
			   from upd_cte cte
               where kh.IdKH = cte.IdKH
);


-- 18/ Xóa những khách hàng có hợp đồng trước năm 2016 (chú ý ràng buộc giữa các bảng).
with del_cte as (
	select kh.IdKH, hd.IdHD
	from khachhang kh
	join hopdong hd on kh.IdKH = hd.khachhang_IdKH
	where hd.NgayLamHD between '2021-01-01' and '2021-01-31'
)
delete 
from khachhang kh
where kh.IdKH = ( select cte.IdKH
				  from del_cte cte
                  where cte.IdKH = kh.IdKH
);


-- 19/ Cập nhật giá cho các Dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2019 lên gấp đôi.
with upd_cte as (
	select dvdk.IdDVDK, count(dvdk.IdDVDK) SoLanDat, dvdk.TenDVDK
	from hopdong hd
	join hopdongchitiet cthd on hd.IdHD = cthd.hopdong_IdHD
	join dichvudikem dvdk on dvdk.IdDVDK = cthd.dichvudikem_IdDVDK
	group by dvdk.IdDVDK
)
update dichvudikem dvdk
set dvdk.Gia = dvdk.Gia + dvdk.Gia
where dvdk.IdDVDK = ( select cte.IdDVDK
					  from upd_cte cte
					  where cte.SoLanDat >= 3 and cte.IdDVDK = dvdk.IdDVDK
);



-- 20/ Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, thông tin hiển thị bao gồm ID (IDNhanVien, IDKhachHang),
-- HoTen, Email, SoDienThoai, NgaySinh, DiaChi.
-- TO DO


-- 21/ Tạo khung nhìn có tên là V_NHANVIEN để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu” và đã từng lập hợp đồng cho 1
-- hoặc nhiều Khách hàng bất kỳ với ngày lập hợp đồng là “12/12/2019”
create view V_NHANVIEN as
select *
from nhanvien nv
where nv.IdNV = ( select distinct(hd.nhanvien_IdNV)
				  from hopdong hd
                  where nv.IdNV = hd.nhanvien_IdNV and hd.NgayLamHD = '2021-03-04'
);


-- 22/ Thông qua khung nhìn V_NHANVIEN thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các Nhân viên được nhìn thấy bởi khung nhìn này.
update v_nhanvien
set DiaChi = 'Lien Chieu District, Da Nang City'
where DiaChi = 'Hai Chau District, Da Nang City';


-- 23/ Tạo Clustered Index có tên là IX_KHACHHANG trên bảng Khách hàng. Giải thích lý do và thực hiện kiểm tra tính hiệu quả của việc sử dụng INDEX
create index `IX_KHACHHANG` on khachhang (`HoTen`, `NgaySinh`, `SoCMND`, `SDT`, `Email`, `DiaChi`) visible;
-- Lý do: index được sử dụng để tăng tốc độ truy vấn và sẽ được sử dụng bởi cơ sở dữ liệu tìm kiếm để xác định vị trí bản ghi rất nhanh.


-- 24/ Tạo Non-Clustered Index có tên là IX_SoDT_DiaChi trên các cột SODIENTHOAI và DIACHI trên bảng KHACH HANG và kiểm tra tính
-- hiệu quả tìm kiếm sau khi tạo Index.



-- 25/ Tạo Store procedure Sp_1 Dùng để xóa thông tin của một Khách hàng nào đó với Id Khách hàng được truyền vào như là 1 tham số của Sp_1
DELIMITER //
create procedure Sp_1 (in id int, out message varchar(50))
if (id in (select IdKH from khachhang)) then
begin
	delete from khachhang where IdKH = id;
    set message = 'Đã xóa khách hàng';
end;
else
begin
	set message = 'Khách hàng không tồn tại';
end;
end if;
// DELIMITER ;

call Sp_1(1, @message);
select @message;



-- 26/ Tạo Store procedure Sp_2 Dùng để thêm mới vào bảng HopDong với yêu cầu Sp_2 phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, với
-- nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.
DELIMITER //
create procedure Sp_2 (in id int, in `start` datetime, in `end` datetime, in tiendatcoc int, in tongtien int,
					   in nv int, in kh int, in dv int,
					   out message varchar(50)
)
if ((id in (select IdHD from hopdong)) or (nv not in (select IdNV from nhanvien)) or (kh not in (select IdKH from khachhang))
or (dv not in (select IdDV from dichvu))) then
begin
	set message = 'Thông tin không hợp lệ';
end;
else
begin
	insert into hopdong value (id, `start`, `end`, tiendatcoc, tongtien, nv, kh, dv);
    set message = 'insert value thành công!';
end;
end if;
// DELIMITER ;

call Sp_2(9, '2021-04-01 00:00:00', '2021-04-04 00:00:00', 25000000, 50000000, 2, 3, 2, @message);
select @message;



-- 27/ Tạo triggers có tên Tr_1 Xóa bản ghi trong bảng HopDong thì hiển thị tổng số lượng bản ghi còn lại có trong bảng HopDong ra giao diện
-- console của database
drop table if exists `hopdong_del`;
create table if not exists `hopdong_del` (
  `IdHD` INT NOT NULL,
  `NgayLamHD` DATETIME NOT NULL,
  `NgayKetThuc` DATETIME NOT NULL,
  `TienDatCoc` INT NOT NULL,
  `TongTien` INT NOT NULL,
  `NhanVien_IdNV` INT NOT NULL,
  `KhachHang_IdKH` INT NOT NULL,
  `DichVu_IdDV` INT NOT NULL,
  `date` datetime,
  action VARCHAR(50),
  CONSTRAINT PK_HopDong PRIMARY KEY (`IdHD`),
  CONSTRAINT FK_HopDong_NhanVien FOREIGN KEY (`NhanVien_IdNV`) REFERENCES NhanVien(`IdNV`),
  CONSTRAINT FK_HopDong_KhachHang FOREIGN KEY (`KhachHang_IdKH`) REFERENCES KhachHang(`IdKH`),
  CONSTRAINT FK_HopDong_DichVu FOREIGN KEY (`DichVu_IdDV`) REFERENCES DichVu(`IdDV`)
) engine = InnoDB;

drop trigger if exists `Tr_1`;
DELIMITER //
create trigger Tr_1
after delete on hopdong
for each row
begin
	insert into hopdong_del
    set action = 'delete',
    IdHD = old.IdHD,
    NgayLamHD = old.NgayLamHD,
    NgayKetThuc = old.NgayKetThuc,
    TienDatCoc = old.TienDatCoc,
    TongTien = old.TongTien,
    NhanVien_IdNV = old.NhanVien_IdNV,
    KhachHang_IdKH = old.KhachHang_IdKH,
    DichVu_IdDV = old.DichVu_IdDV,
    `date` = now();
end;
// DELIMITER ;

delete
from hopdong
where IdHD = 8;

select count(*) SoLuongHopDongConLai from hopdong;


-- 28/ Tạo triggers có tên Tr_2 Khi cập nhật Ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập nhật có phù hợp hay không, với quy tắc sau: Ngày
-- kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra
-- thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database
drop trigger if exists Tr_2;
DELIMITER //
create trigger Tr_2
before update on hopdong
for each row
if datediff(NgayKetThuc, NgayLamHD) > 2 then
begin
	insert into hopdong_upd
    set action = 'update',
    IdHD = old.IdHD,
    NgayLamHD = old.NgayLamHD,
    NgayKetThuc = old.NgayKetThuc,
    TienDatCoc = old.TienDatCoc,
    TongTien = old.TongTien,
    NhanVien_IdNV = old.NhanVien_IdNV,
    KhachHang_IdKH = old.KhachHang_IdKH,
    DichVu_IdDV = old.DichVu_IdDV,
    `date` = now();
end;
else
begin
	insert into hopdong_upd
    set action = 'update not unsuccessful!';
end;
end if;
// DELIMITER ;




-- 29/ Tạo user function thực hiện yêu cầu sau:
-- a/ Tạo user function func_1: Đếm các dịch vụ đã được sử dụng với Tổng tiền là &gt; 2.000.000 VNĐ.

-- b/ Tạo user function Func_2: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng mà Khách hàng đã
-- thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần
-- làm hợp đồng). Mã của Khách hàng được truyền vào như là 1 tham số của function này.

-- 30/ Tạo Stored procedure Sp_3 để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ là “Room” từ đầu năm 2015 đến hết năm 2019 để xóa
-- thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng DichVu) và xóa những HopDong sử dụng dịch vụ liên quan (tức là phải xóa những
-- bản gi trong bảng HopDong) và những bản liên quan khác.