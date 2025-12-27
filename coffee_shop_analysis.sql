use coffee_shop;
-- 1.1 Jumlah data
select COUNT(*) as total_transaksi from transactions;

-- 1.2 Cek nilai kosong
select 
	SUM(transaction_id is null) as null_transaction_id,
	SUM(transaction_date is null) as null_transaction_date,
	SUM(transaction_time is null) as null_transaction_time,
	SUM(transaction_qty is null) as null_transaction_qty,
	SUM(store_id is null) as null_store_id,
	SUM(store_location is null) as null_store_location,
	SUM(product_id is null) as null_product_id,
	SUM(unit_price is null) as null_unit_price,
	SUM(product_category is null) as null_product_category,
	SUM(product_type is null) as null_product_type,
	SUM(product_detail is null) as null_product_detail
from transactions;

-- 1.3 Rentang harga
select 
	MIN(unit_price) as harga_terendah,
	MAX(unit_price) as harga_tertingggi,
	MIN(transaction_qty) as qty_min,
	MAX(transaction_qty) as qty_max
from transactions;

-- 2.1 Produk terlaris
select 
	product_detail,
	SUM(transaction_qty) as total_terjual
from transactions
group by product_detail 
order by total_terjual desc;

-- 2.2 Pendapatan harian
select 
	transaction_date,
	SUM(transaction_qty * unit_price) as total_pendapatan
from transactions
group by transaction_date 
order by transaction_date;

-- 2.3 Kategori produk dengan pendapatan tertinggi
select 
	product_category,
	SUM(transaction_qty * unit_price) as total_pendapatan
from transactions
group by product_category 
order by total_pendapatan desc;

-- 2.4 Rata_rata per hari
select 
	AVG(total_harian) as rata_rata_pendapatan
from (
	select 
		transaction_date,
		SUM(transaction_qty * unit_price) as total_harian
	from transactions
	group by transaction_date 
) t;

-- 2.5 Pola jam penjualan
select 
	HOUR(transaction_time) as jam,
	SUM(transaction_qty) as jumlah_terjual
from transactions
group by jam 
order by jumlah_terjual desc;

-- 2.6 Tren penjualan berdasarkan hari dalam seminggu
select 
	DAYNAME(transaction_date) as hari,
	SUM(transaction_qty * unit_price) as total_pendapatan
from transactions
group by hari 
order by total_pendapatan desc;

-- 3.1 Hari dengan transaksi lebih dari nilai tertentu
select
    transaction_date,
    SUM(transaction_qty) as total_transaksi
from transactions
group by transaction_date
having total_transaksi > 1000
order by total_transaksi desc;

-- 3.2 Produk dengan total penjualannya melewati jumlah tertentu
select 
    product_detail,
    SUM(transaction_qty) as total_terjual
from  transactions
group by product_detail
having total_terjual > 1000
order by total_terjual desc;
 