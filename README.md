# Laporan Soal Shift Modul 1
Laporan pengerjaan soal shift modul pertama  
Kelas Sistem Operasi E Jurusan Informatika Institut Teknologi Sepuluh Nopember  
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

Setelah dilakukan pengekstrakan file, ditemukan bahwa file-file didalam *zip* tersebut adalah hexdump dari file jpg yang telah di encode ke dalam bentuk base 64. Oleh karena itu, dilakukan peng-dekode-an base64 yang dilanjutkan dengan peng-dekode-an hexdump menjadi file gambar. Kedua hal ini masing-masing dilakukan dengan perintah *base64 \-d* dan *xxd \-r*
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
Disini perintah *basename* dipakai untuk mendapatkan nama file dari path file tersebut.

Setelah itu, dilakukan penyettingan crontab sesuai keinginan soal :

    14 14 14 2 5 ~/soal1.sh

---

## Nomor 2
### Soal
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.  
b. Tentukan tiga product line yang memberikan penjualan(quantity)
terbanyak pada soal poin a.  
c. Tentukan tiga product yang memberikan penjualan(quantity)
terbanyak berdasarkan tiga product line yang didapatkan pada soal
poin b.
### Jawab

Pertama-tama dicari dahulu negara dengan penjualan terbanyak pada tahun 2012 dengan menggunakan *awk*

Hal yang dilakukan adalah dengan mendapatkan semua entri yang bertahun 2012 terlebih dahulu, lalu menjumlahkannya sesuai dengan nama negara seperti ini :

```sh
awk -F ',' '$7=="2012"{array[$1]=array[$1]+$10}END{for(i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv
```

Hasil outputnya lalu di sort sesuai dengan jumlah penjualan menggunakan perintah *sort*

```sh
sort -t ',' -nrk2 
```
>Keterangan argumen :   
>* \-t   : men-set field separator(disini ',' )
>* \-n   : men-sort angka
>* \-r   : hasil sort di reverse(karena dicari yang terbesar)
>* \-k2   : menspesifikasi bahwa penyortingan dilakukan sesuai nilai di kolom dua
  
Hasil output sortnya lalu di masukkan lagi ke dalam perintah *awk* untuk diambil nilai terbesarnya seperi ini : 

```sh
awk -F ',' 'NR==1{print $1}
```

Jika ketiga perintah tersebut disatukan, akan menjadi seperti ini :

```sh
awk -F ',' '$7=="2012"{array[$1]=array[$1]+$10}END{for(i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2  | awk -F ',' 'NR==1{print $1}'
```

Hasil output dari perintah tersebut lalu dimasukkan ke dalam sebuah variabel untuk dipakai di masalah selanjutnya

```sh
 data=`awk -F ',' '$7=="2012"{array[$1]=array[$1]+$10}END{for(i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2  | awk -F ',' 'NR==1{print $1}'`
```

Setelah didapatkan negara dengan penjualan terbesar, maka masalah selanjutnya adalah mencari tiga *product line* dengan *quantity* tertinggi. 

Penyelesaian masalah ini kurang lebih sama dengan masalah sebelumnya, hanya di *awk* nya ditambahkan nama negara sebelumnya sebagai pola.

```sh
awk -F ',' -v add="$data" '($1 ~ add)&&($7=="2012"){array[$4]=array[$4]+$10}END{for (i in array) print i "," array[i]}
```
Argumen -v diatas dipakai untuk memasukkan variabel *$data* ke dalam *awk* lalu memisalkannya dengan nama *add*. variabel *add* ini lalu dipakai sebagai pola pencarian dari *awk*. Hasil outputnya lalu di sort, diambil 3 teratas lalu dimasukkan ke dalam variabel untuk dijadikan input untuk masalah berikutnya

```sh
dataraw=`awk -F ',' -v add="$data" '($1 ~ add)&&($7=="2012"){array[$4]=array[$4]+$10}END{for (i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2 | awk  -F ',' 'NR<3 {print $1 ", "} NR==3{print $1}'`
```
Masalah ketiga kurang lebih sama dengan masalah-masalah sebelumnya, hanya saja karena diambil tiga produk terbanyak dari tiga produk sebelumnya maka prosedur diulangi tiga kali.

Data *product line* terbanyak dipakai lagi sebagai pola di dalam perintah *awk*.

```sh
awk -F ',' -v add="$data" -v add1="$data1" '($1 ~ add)&&($4 ~ add1)&&($7=="2012") {array[$6]=array[$6]+$10}END{for (i in array) print i "," array[i]}' WA_Sales_Products_2012-14.csv | sort -t ',' -nrk2 | awk  -F ',' 'NR<3 {print $1 ", "} NR==3{print $1}'
```
Variabel *\$data1* diatas adalah hasil pemisahan dari variabel *\$dataraw*. Prosedur diatas lalu dulangi tiga kali dan didapatkan tiga *product* di masing-masing *product line*


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

Untuk menghasilkan password random, pertama-tama dibuat tiga array berbeda, yaitu array angka 0-9, huruf a-z, dan huruf A-Z, dan juga variabel panjang karakter.

```sh
length=12
digit=({0..9})
lower=({a..z})
upper=({A..Z})
```
Selanjutnya pendeklarasian variable array charArray yang berisi gabungan array
integer, huruf kecil, dan huruf besar juga pendeklarasian variabel string password,
variabel minimum, dan variabel pass sebagai flag.

```sh
charArray=(${digit[*]}${lower[*]}${upper[*]})
arrayLength=${#charArray[*]}
password=""
let minimum=$length-5
pass=0
```
Selanjutnya terdapat variabel counter dan variabel flag sebagai penanda karakter
yang terpilih.

```sh
cnt=0;
isUp=0
isLo=0
isNum=0
```
Kemudian masuk keperulangan sejumlah panjang karakter untuk men-generate password,

```sh
for i in `seq 1 $length`
```
dimana dalam perulangan itu terdapat beberapa kondisi, yaitu

1. ika nilai variabel minimum (dalam hal ini berisi 7) lebih besar sama dengan nilai counter, maka variabel char akan memilih satu karakter dimana nilai indexnya akan dipilih secara random. Ubah nilai dari flag suatu karakter untuk menandai. Kemudian karakter tersebut dimasukkan kedalam variabel password.

```sh        
        if [[ $minimum -ge $cnt ]]; then
            index=$((RANDOM%arrayLength))
            char=${charArray[$index]}
            if [[ $char =~ [A-Z] ]]; then
                isUp=1
            elif [[ $char =~ [a-z] ]]; then
                isLo=1
            elif [[ $char =~ [0-9] ]]; then
                isNum=1
            fi
            password=${password}${char}
```

2. Kondisi kedua akan berjalan jika kondisi pertama tidak memenuhi syarat. Dalam kondisi ini juga terdapat beberapa kondisi. Pertama jika belum ada karakter uppercase yang dipilih, yang akan di random hanya index yang berisi karakter uppercase saja. Begitu juga dengan kondisi selanjutnya, kecuali jika semua karakter sudah terpilih, maka karakter akan dipilih secara random. Di akhir perulangan counter akan bertambah.

```sh   
     else
            if [[ isUp -eq 0 ]]; then
                index=$((RANDOM%26))
                char=${upper[$index]}
                password=${password}${char}
                isUp=1;
            elif [[ isLo -eq 0 ]]; then
                index=$((RANDOM%26))
                char=${lower[$index]}
                password=${password}${char}
                isLo=1;
            elif [[ isNum -eq 0 ]]; then
                index=$((RANDOM%10))
                char=${digit[$index]}
                password=${password}${char}
                isNum=1
            else
                index=$((RANDOM%arrayLength))
                char=${charArray[$index]}
                password=${password}${char}
            fi
        fi
    (( ++cnt ))
```
Seletah itu buat variabel yang berisi nama file dan angka.

```sh
    file=password
    number=1
```
Kemudian lakukan perulangan untuk mengecek dan menentukan nama file. Jika nama file tersebut telah ada atau jika password tersebut telah dibuat sebelumnya, maka number akan increment sampai kedua kondisi tersebut tidak terpenuhi.

```sh
    while test -e "$file$number.txt"; do
     if [ $(cat "$file$number.txt") == $password ]; then
            pass=0
        fi
        (( ++number ))
    done
```
Terakhir password yang telah dibuat disimpan ke dalam file .txt dengan nama yang telah ditentukan.

```sh
fname="$file$number.txt"

echo $password > "$fname"
```

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

Pertama-tama dibuat fungsi dan *chr()* sebagai fungsi pembantu untuk mengubah ASCII ke karakter.

```sh
chr(){
    printf "\x$(printf %x $1)"
}
```
Setelah itu dicari nilai offset nya sesuai dengan jam dengan menggunakan perintah *date*.
```sh
offset=`date "+%-H"`
```
Setelah itu dilakukan penghitungan pergeseran huruf dengan menambahkan offset dengan nilai huruf pertama (yaitu 65).
```sh
let letterb=65+$offset-1
let letterbend=$letterb+1
```
Hal yang sama dilakukan untuk huruf kecil
```sh
let letters=97+$offset-1
let lettersend=$letters+1
```
Hasil perhitungan lalu dimasukkan ke dalam fungsi *tr* seperti ini:
```sh
tr '[A-Za-z]' "[$(chr $letterbend)-ZA-$(chr $letterb)$(chr $lettersend)-za-$(chr $letters)]"
```

>**Keterangan :**  
> 
>Perintah
>```sh 
>tr "[A-Z]" "[Y-ZA-X]" 
>```
>akan mengganti {A,B,C,...,X,Y,Z} dengan {Y,Z,A,...,V,W,X}
>
><br>

Hasilnya lalu di di outputkan menjadi text sesuai dengan waktu dan tanggal pada saat ini seperti ini :
```sh
cat /var/log/syslog | tr '[A-Za-z]' "[$(chr $letterbend)-ZA-$(chr $letterb)$(chr $lettersend)-za-$(chr $letters)]" > ./clog/"$filename".txt
```
Enkripsi akan dilakukan setiap jam, maka cron nya adalah sebagai berikut :
```
0 */1 * * * ~/soal4.sh
```

Untuk melakukan dekripsi, maka harus diketahui jamnya dari nama filenya. Perintah dibawah akan mengambil angka jam dari nama file.
```sh
offset=$(echo -n "$(echo -n $(basename $1) | cut -c1-2)" | tr -d '0')
```
Disini *cut* berfungsi mengambil dua digit pertama nama file, lalu *tr* bertugas untuk menghilangkan leading zero. Pendekripsian lalu di lakukan dengan menggunakan perintah *tr* dengan argumen yang sama seperti sebelumnya, hanya saja ditukar tempatnya.

```sh
tr "[$(chr $letterbend)-ZA-$(chr $letterb)$(chr $lettersend)-za-$(chr $letters)]" '[A-Za-z]'
```
Lalu di export hasilnya dalam bentuk .txt .


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

Bisa dilakukan perintah *awk* seperti ini :
```sh
awk '(tolower($0) ~ /cron/)&&(tolower($0) !~ /sudo/)&&(NF<13) {print}'
```
awk tersebut bekerja dengan membuat seluruh input menjadi *lower case* lalu dibandingkan dengan pola cron dan sudo. Maksud dari pola diatas adalah 
>Print jika terdapat pola /cron/ **dan** tak terdapat pola /sudo/ **dan** jumlah *field* kurang dari 13  

Lalu script akan dijalankan setiap 6 menit dari menit 2 hingga 30, maka cron nya adalah :
```
2-30/6 * * * * ~/soal5.sh
```

---
