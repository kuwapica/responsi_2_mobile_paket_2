# RESPONSI 2 MOBILE PAKE 2 (H1D023070)
Nama : Annida Aiska Humairoh <br>
NIM : H1D023070 <br>
SHIFT : D (baru), I (awal)<br><br>
link drive untuk demo aplikasi: https://drive.google.com/drive/folders/11ulAtL8JutQhkCJ8jAOkRs-_j4nlL7bT?usp=drive_link 


https://github.com/user-attachments/assets/a0a7a4a6-14c6-4caf-94bd-315e40e5d580


<br><br>


## Spesifikasi API
RESTful API yang dibangun menggunakan CodeIgniter 4 untuk backend aplikasi mobile flutter Inventaris Bahan Makanan.

### Endpoint
- Autentikasi
  | Method | Endpoint | Deskripsi |  
  | ---         |     ---      |          --- |
  | POST  | /registrasi     | Mendaftarkan user baru   |
  | POST     | /login      | Login user & ambil token   |
- Proses Crud
  | Method | Endpoint | Deskripsi |  
  | ---         |     ---      |          --- |
  | GET  | /bahan    | Menampilkan semua inventaris bahan makanan |
  | POST     | /bahan     | Menambah bahan makanan baru   |
  | GET     | /bahan/{id}     | Menampilkan detail bahan makanan   |
  | PUT     | /bahan/{id}     | Mengubah data bahan makanan   |
  | DELETE     | /bahan/{id}     | Menghapus data bahan makanan   |

### Setup Database
Buat database bernama inventaris_bahan, dan buat tabel member, member_token, bahan.
<br><br>
## Penjelasan Kode Flutter 
### /helpers
#### user_info.dart
Berfungsi menyimpan dan mengambil data login menggunakan SharedPreferences.<br>
Isi fungsinya:
- `setToken()` → menyimpan token login.
- `getToken()` → mengambil token.
- `setUserID()` → menyimpan id user.
- `getUserID()` → mengambil id user.
- `logout()` → menghapus semua data login.<br>
#### app_exception.dart
Berisi kelas-kelas error custom:
- `BadRequestException`
- `UnauthorisedException`
- `InvalidInputException`<br>
Fungsinya untuk:
- Menangkap error ketika request API gagal
- Memberikan pesan error yang lebih jelas
#### api.dart
Ini adalah modul inti untuk komunikasi REST API.<br>
Isi fungsinya:
- `post()`
- `get()`
- `put()`
- `delete()`
#### api_url.dart
Berisi kumpulan endpoint API, seperti:
- registrasi
- login
- listBahan
- updateBahan(id)
- showBahan(id)
- deleteBahan(id)

### /model
berisi 3 file yaitu:
- `login.dart`
- `registrasi.dart`
- `bahan.dart`<br>
Fungsi model: menyimpan struktur data, mempermudah konversi JSON menjadi Object Dart (fromJson), menjadi objek yang dipakai UI dan bloc

### /bloc
#### registrasi_bloc.dart
Fungsi:
- Mengirim POST ke endpoint registrasi
- Mengubah JSON respons menjadi objek `Registrasi`
#### login_bloc.dart
Fungsi:
- Mengirim POST login
- Mengembalikan objek Login
- Menyimpan token & userID ke UserInfo
#### logout_bloc.dart
Fungsi:
- Menghapus token dan userID di SharedPreferences
#### bahan_bloc.dart
Fungsi CRUD lengkap:
- `getBahans()` -> ambil data bahan makanan
- `addBahan()` -> POST tambah bahan makanan
- `updateBahan()` -> PUT update bahan makanan
- `deleteBahan()` -> DELETE bahan makanan

### /widget
#### success_dialog.dart
Dialog popup ketika operasi berhasil, contohnya ketika registrasi atau login berhasil
#### warning_dialog.dart
Dialog popup ketika operasi gagal, contohnya ketika registrasi gagal.

### /ui
#### login_page.dart
berisi:
- Form email & password
- Validasi input
- Memanggil `LoginBloc.login()`
- Jika sukses, simpan token & masuk ke BahanPage
#### registrasi_page.dart
berisi:
- Form nama, email, password, dan konfirmasi password
- Validasi input
- Memanggil `RegustrasiBloc.registrasi()`
- Jika sukses, akan muncul pop up sukses kemudian dialihkan ke halaman login
#### bahan_page.dart
Halaman utama setelah login.<br>
Fungsinya:
- Menampilkan list bahan makanan dari API
- Ada button “+” yang menuju form tambah bahan
- Drawer dengan tombol Logout
- Setiap item list bisa ditekan akan menuju BahanDetail<br>
Data ditampilkan menggunakan:
```
FutureBuilder<List>
```
yang memanggil:
```
BahanBloc.getBahans()
```
#### bahan_form.dart
Digunakan untuk tambah dan edit bahan.<br>
alur:
- Jika dipanggil tanpa parameter, menjadi mode tambah
- Jika membawa objek Bahan menjadi mode edit
- Tombol submit memanggil:
  - `BahanBloc.addBahan()` (tambah)
  - `BahanBloc.updateBahan()` (ubah)
#### bahan_detail.dart
Menampilkan detail satu bahan yang isinya nama, harga, jumlah, tanggal masuk, dan tanggal kedaluwarsa.<br>
Fitur tombol:
- EDIT BAHAN NIDA -> membuka BahanForm
- DELETE BAHAN NIDA -> memanggil BahanBloc.deleteBahan()

### main.dart
Bagian ini mengatur halaman pertama yang akan dibuka. <br>
Alur:
- Saat app dibuka -> cek UserInfo().getToken()
- Jika token ada -> buka BahanPage
- Jika token tidak ada -> buka LoginPage
