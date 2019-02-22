# Laporan Soal Shift Modul 1
Laporan pengerjaan soal shift modul pertama kelas SISOP E  
Oleh Kelompok E10 


---

## Nomor 1
### Soal  
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah
nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh
file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari
jumat pada bulan Februari.  
Hint: Base64, Hexdump   
### Jawab
Pertama-tama file _nature.zip_ di extract dengan menggunakan perintah _unzip_ .

    unzip nature.zip

Setelah dilakukan pengekstrakan file, ditemukan bahwa file-file didalam *zip* tersebut adalah hexdump dari file jpg yang telah di encode ke dalam bentuk base 64. Oleh karena itu, dilakukan peng-dekode-an base64 yang dilanjutkan dengan peng-dekode-an hexdump menjadi file gambar. Kedua hal ini masing-masing dilakukan dengan perintah *base64 -d* dan *xxd -r*
```sh
    base64 -d $namafile | xxd -r > "$fileoutput.jpg"
```
Karena jumlah file sangat banyak, maka peng-dekode-an dilakukan secara looping
    
```sh
    for i in ~/nature/*.jpg
    do
	    bas="`basename $i`"
	    base64 -d $i | xxd -r > ./decoded/$bas
    done
```
Disini perintah *basename* dipakai untuk mendapatkan nama file dari path file tersebut

---

## Nomor 2
### Soal
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun  
b. Tentukan tiga product line yang memberikan penjualan(quantity)
terbanyak pada soal poin a.  
c. Tentukan tiga product yang memberikan penjualan(quantity)
terbanyak berdasarkan tiga product line yang didapatkan pada soal
poin b.
### Jawab

---
## Nomor 3
### Soal
Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

a. Jika tidak ditemukan file password1.txt maka password acak tersebut
disimpan pada file bernama password1.txt  
b. Jika file password1.txt sudah ada maka password acak baru akan
disimpan pada file bernama password2.txt dan begitu seterusnya.  
c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya
dihapus.  
d. Password yang dihasilkan tidak boleh sama.  

### Jawab

---

## Nomor 4

### Soal

Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan
pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki
urutan ke 12+2 = 14.  
b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
empat belas, dan seterusnya.  
c. setelah huruf z akan kembali ke huruf a  
d. Backup file syslog setiap jam.  
e. dan buatkan juga bash script untuk dekripsinya.  

### Jawab

---

## Nomor 5

### Soal

Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”,
serta buatlah pencarian stringnya tidak bersifat case sensitive,
sehingga huruf kapital atau tidak, tidak menjadi masalah.  
b. Jumlah field (number of field) pada baris tersebut berjumlah kurang
dari 13.  
c. Masukkan record tadi ke dalam file logs yang berada pada direktori
/home/\[user\]/modul1.  
d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh
13:02, 13:08, 13:14, dst.  

### Jawab

---