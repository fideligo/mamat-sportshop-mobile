# Mamat Sportshop

**Mamat Sportshop**, a sports store providing a wide range of sport needs, from apparel and shoes to sports equipment.

---

## Tugas 7: Elemen Dasar Flutter

**Mamat Sportshop kini hadir di Mobile!**

---

### 1. Apa itu widget tree dan hubungan parent-child?

Widget tree adalah susunan atau struktur dari seluruh widget yang digunakan dalam aplikasi Flutter. Struktur ini menyerupai pohon, di mana terdapat akar (seperti `MaterialApp`), cabang (`Scaffold`), dan daun (`Text`, `Button`, dan lain lain).

Hubungan **parent-child** menggambarkan keterkaitan antarwidget, di mana:

- **Parent** adalah widget yang membungkus widget lain.
- **Child** adalah widget yang dibungkus oleh parent.

Contoh sederhana: Widget `Center` (sebagai parent) memiliki satu child `Text`. Selain itu, widget seperti `Column`/`Row` dapat memiliki beberapa children sekaligus. Parent berperan dalam mengatur ukuran, posisi, dan tata letak dari widget-child yang ada di dalamnya.

---

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

- **MaterialApp** (`main.dart`)  
  Sebagai pembungkus aplikasi (root) yang menyediakan konfigurasi global seperti tema dan navigator. Di kode ini `MaterialApp` men-set `home` ke `HomePage`.

- **MyApp** (`main.dart`) — `StatelessWidget`  
  Widget root kustom yang hanya mengembalikan `MaterialApp`.

- **HomePage** (`home_page.dart`) — `StatelessWidget`  
  Halaman utama aplikasi yang menggunakan `Scaffold` dan menata widget `ButtonItem` di dalam `Column`/`Row`.

- **Scaffold** (`home_page.dart`)  
  Menyediakan kerangka halaman: `appBar`, `body`, dan background. Di sini `Scaffold` juga menjadi konteks untuk `ScaffoldMessenger` ketika menampilkan `SnackBar`.

- **AppBar** (`home_page.dart`)  
  Menampilkan judul aplikasi di bagian atas halaman.

- **Column** (`home_page.dart` & di dalam `ButtonItem`)  
  Menyusun widget secara vertikal. Pada `HomePage` `Column` menyusun `ButtonItem` secara vertikal; di `ButtonItem` `Column` menyusun `Text` dan `Icon` secara vertikal.

- **Row** (`home_page.dart`)  
  Menyusun dua `ButtonItem` secara horizontal dan memusatkannya (`mainAxisAlignment: center`).

- **ButtonItem** (`models/button_item.dart`) — `StatelessWidget` (custom)  
  Komponen kartu tombol yang digunakan beberapa kali di `HomePage`. Menerima properti `title`, `icon`, dan `warna` untuk menyesuaikan tampilan.

- **Card** (`models/button_item.dart`)  
  Membuat tampilan kotak/kartu dengan elevasi dan background (di sini `color: Color(0xFFF3F5F7)`).

- **InkWell** (`models/button_item.dart`)  
  Menjadikan `Card` bisa disentuh (tap). Saat ditekan menjalankan callback `onTap`.

- **SizedBox** (`models/button_item.dart`)  
  Menetapkan ukuran tetap `height: 100` dan `width: 100` untuk area tombol.

- **Center** (`models/button_item.dart`)  
  Menempatkan isi `SizedBox` di tengah.

- **Text** (`models/button_item.dart`)  
  Menampilkan judul tombol (`title`) dengan pewarnaan sesuai parameter `warna`.

- **Icon** (`models/button_item.dart`)  
  Menampilkan ikon yang diberikan melalui parameter `icon` (`IconData`) dengan warna `warna`.

- **ScaffoldMessenger.of(context)** (`models/button_item.dart`)  
  Digunakan untuk menampilkan `SnackBar` ketika `ButtonItem` ditekan:
- **SnackBar** (`models/button_item.dart`)
  Notifikasi singkat yang muncul di bagian bawah layar saat tombol ditekan.

- **Colors / Color(0xFF...)** (`main.dart, home_page.dart, models/button_item.dart`)
  Mengatur warna tema, AppBar, dan warna ikon/teks pada ButtonItem.

---

### 3. Apa fungsi dari widget MaterialApp? Mengapa sering jadi root?

Fungsinya: `MaterialApp` itu widget utama yang ngebungkus aplikasi. Fungsinya buat nyediain hal-hal dasar Material Design, kayak:

- Ngatur tema (warna, font)
- Ngatur navigasi (pindah-pindah halaman)

Kenapa sering jadi root:  
Karena dia harus jadi yang paling atas biar semua halaman dan widget di bawahnya bisa pakai tema dan sistem navigasi yang sama.  
Kalau nggak, widget kayak `Scaffold` bakal error karena nggak tahu temanya apa.

---

### 4. Perbedaan StatelessWidget dan StatefulWidget? Kapan memilihnya?

- **StatelessWidget:** Widget "statis". Tampilannya nggak bisa berubah setelah dibuat. Contoh: `Icon`, `Text` biasa.
- **StatefulWidget:** Widget "dinamis". Tampilannya bisa berubah kalau ada interaksi atau data baru. Punya objek `State` buat nyimpen data yang bisa berubah itu. Contoh: `Checkbox`, `TextField`.

**Kapan milih:**

- Pilih **Stateless** kalau halaman/widget-nya cuma nampilin data aja dan nggak ada yang perlu di-update.
- Pilih **Stateful** kalau kamu perlu ngubah sesuatu di layar (misal: nambah counter, ganti warna pas diklik, ngisi form).

---

### 5. Apa itu BuildContext dan mengapa penting?

`BuildContext` itu intinya "lokasi" atau "alamat" sebuah widget di dalam widget tree. Tiap widget punya context-nya sendiri.

**Pentingnya:** Context dipakai buat:

- Ambil data dari widget parent (misal: `Theme.of(context)` buat ambil data tema).
- Pergi ke halaman lain (misal: `Navigator.push(context, ...)`).

Di method `build`, context itu parameter yang dikasih Flutter biar kita bisa pakai fungsi-fungsi di atas.

---

### 6. Perbedaan "hot reload" dan "hot restart"?

**Hot Reload:**

- Super cepat (detikan).
- Cuma nge-build ulang UI yang kodenya diubah.
- State (data) aplikasi nggak hilang.
- Dipakai buat ganti-ganti tampilan cepat.

**Hot Restart:**

- Agak lambat (beberapa detik).
- Mulai ulang aplikasi dari awal.
- State (data) aplikasi hilang semua (direset).
- Dipakai kalau ubahannya besar (kayak `initState`) atau kalau Hot Reload bikin error.

---

## Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements

---

### 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Ini adalah dua cara navigasi dasar di Flutter, tapi punya efek yang beda:

- `Navigator.push()`: Menambah screen ke stack. Ini kayak **numpuk layar baru** di atas layar yang sekarang. Layar lamanya masih ada di bawah tumpukan, jadi kita bisa pencet "Back" (Tombol kembali) untuk kembali ke layar sebelumnya.
- `Navigator.pushReplacement()`: Mengganti screen saat ini di Stack. Ini **mengganti layar** yang sekarang. Layar lamanya (yang kita tinggalkan) langsung dibuang (dihancurkan/destroy). Hasilnya, kita _nggak bisa_ pencet "Back" untuk kembali ke layar itu.

**Kapan Pakainya di Aplikasi Kita?**

- **Pakai `push()` 🛒:**

  - Saat user di **Halaman Utama** lalu mengklik satu item (misal: sepatu bola) untuk melihat **Halaman Detail Produk**.
  - User tentu ingin bisa kembali lagi ke Halaman Utama setelah melihat detail, jadi kita pakai `push()`.

- **Pakai `pushReplacement()` 🔒:**
  - Saat user berhasil di **Halaman Login** atau **Halaman Register**.
  - Setelah sukses, kita bawa mereka ke **Halaman Utama (Home)**. Kita _nggak mau_ user bisa pencet "Back" dan balik lagi ke Halaman Login (karena mereka sudah login). Jadi, kita pakai `pushReplacement()` untuk "membuang" halaman Login dari tumpukan.

---

### 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Ketiga widget ini adalah fondasi (pondasi) utama untuk membangun layout yang konsisten di seluruh aplikasi kita:

- `Scaffold`: Ini adalah **rangka utama** atau "kanvas" kosong untuk setiap halaman baru. Dia yang nyediain tempat buat `AppBar` dan `Drawer`.
- `AppBar`: Ini adalah **header di bagian atas** aplikasi. Kita pakai ini secara konsisten di setiap halaman untuk menampilkan judul halaman (misal: "Add Product" atau nama toko).
- `Drawer`: Ini adalah **menu samping** (yang biasa muncul kalau kita klik ikon hamburger atau simply by geser layar ke kanan). Kita pakai `Drawer` sebagai tempat navigasi utama. Dari mana aja di aplikasi, user bisa buka `Drawer` untuk pindah ke halaman penting (Contoh: "Home", "Add Product").

Dengan memakai struktur ini di semua halaman, user jadi cepat hafal dan nggak bingung waktu pakai aplikasi kita.

---

### 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Saat mendesain form (seperti di Halaman Login, Register, atau Checkout), ketiga widget ini sangat membantu:

1.  **`Padding`**:

    - **Kelebihan**: Memberi gap untuk tiap widget, agar widget tidak terlalu padat.
    - **Contoh**: Tanpa menggunakan `Padding`, `TextField` di app saya, untuk field Nama Product, Price, dan Description akan nempel banget ke satu sama lain maupun ke pinggir layar. Maka dari itu, kita bungkus `TextField` pakai `Padding` (misal: `Padding(padding: EdgeInsets.all(16.0), ...)` ) biar ada jarak dan terlihat rapi.

2.  **`SingleChildScrollView`**:

    - **Kelebihan**: Ini _WAJIB_ ada di form. Saat user ngetik di `TextField`, keyboard HP akan muncul.
    - **Contoh**: Bayangkan form Register kita punya 5-6 isian. Waktu keyboard muncul, sisa layar jadi pendek. Tanpa `SingleChildScrollView`, tombol di bagian bawah form akan **ketutupan keyboard** dan nggak bisa diklik! Dengan membungkus `Column` form kita pakai `SingleChildScrollView`, layarnya jadi bisa di-scroll, dan user tetap bisa akses tombol "Daftar".

3.  **`ListView`**:
    - **Kelebihan**: Mirip `SingleChildScrollView`, `ListView` juga otomatis bisa di-scroll.
    - **Contoh**: Kita bisa pakai `ListView` untuk menggantikan `Column` + `SingleChildScrollView`. Ini cocok kalau isi form-nya banyak banget, atau kalau kita mau nampilin daftar produk di halaman keranjang belanja (yang pada dasarnya adalah "list" elemen).

---

### 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Agar aplikasi Football Shop kita punya identitas visual yang konsisten, kuncinya ada di perencanaan dan konsistensi.

Sebelum membuat aplikasi, saya menentukan **Color Palette** (palet warna) yang akan saya gunakan. Ini mencakup warna primer, warna sekunder, warna latar, dan warna teks yang sesuai dengan brand toko.

Setelah palet warna ditentukan, saya **konsisten menggunakan warna-warna itu** di seluruh aplikasi. Untuk widget yang digunakan berkali-kali, saya mendefinisikan warna pada class model widget tersebut jadi warna dan design bisa konsisten.

---
# Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

---

### 1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model?

Kita perlu membuat model Dart untuk mengubah data JSON (yang tidak terstruktur dan dinamis) menjadi objek Dart yang terstruktur (Strongly Typed).

**Alasannya:**
* **Type Safety:** Memastikan tipe data yang digunakan sesuai (misalnya, harga harus `int`, nama harus `String`). Ini mencegah *runtime error* akibat tipe data yang salah.
* **Code Completion:** IDE dapat memberikan saran (autocomplete) properti yang tersedia dalam objek, sehingga mempercepat pengembangan.
* **Validasi & Null Safety:** Model memungkinkan kita menangani nilai `null` atau format data yang tidak valid saat konversi dari JSON.

**Konsekuensi tanpa model (`Map<String, dynamic>`):**
* Rentan terhadap *typo* saat memanggil *key* (misal: `data['prce']` padahal seharusnya `data['price']`), yang baru ketahuan saat aplikasi dijalankan (*runtime error*).
* Sulit untuk di-*maintain* karena kita tidak tahu pasti struktur data yang sedang diolah tanpa melihat dokumentasi API atau menelusuri kode.
* Tidak memanfaatkan fitur *null safety* Dart secara maksimal.

### 2. Apa fungsi package `http` dan `CookieRequest` dalam tugas ini? Jelaskan perbedaan peran `http` vs `CookieRequest`.

* **`http`:** Adalah package dasar untuk melakukan permintaan HTTP (GET, POST, PUT, DELETE) ke server. Ini bersifat *stateless*, artinya setiap permintaan dianggap baru dan tidak menyimpan informasi sesi (seperti cookies) secara otomatis.
* **`CookieRequest` (dari `pbp_django_auth`):** Adalah *wrapper* di atas `http` yang dirancang khusus untuk menangani manajemen sesi (cookies).

**Perbedaan Peran:**
`http` digunakan untuk komunikasi standar yang tidak memerlukan persistensi sesi login. Sedangkan `CookieRequest` sangat krusial untuk **Autentikasi Django**. Saat user login, Django memberikan *session ID* dalam cookie. `CookieRequest` menyimpan cookie ini dan menyertakannya secara otomatis di setiap *request* berikutnya, sehingga server mengenali bahwa pengguna tersebut "sudah login".

### 3. Jelaskan mengapa instance `CookieRequest` perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

`CookieRequest` menyimpan data sesi pengguna (apakah user sedang login atau tidak, serta cookie autentikasinya). Status login ini bersifat **global** untuk satu aplikasi.

Jika kita membuat instance `CookieRequest` baru di setiap halaman, maka data login akan hilang (state tidak tersimpan). Oleh karena itu, kita menggunakan `Provider` di *root* aplikasi (`main.dart`) untuk membagikan **satu instance yang sama** ke seluruh widget. Ini memungkinkan status login tetap terjaga konsisten saat pengguna berpindah-pindah halaman.

### 4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django.

Agar Flutter (terutama di Emulator Android) bisa bicara dengan Django (Localhost), diperlukan:

1.  **`10.0.2.2` pada `ALLOWED_HOSTS`:** Emulator Android menganggap `localhost` (127.0.0.1) sebagai dirinya sendiri. Untuk mengakses localhost komputer (host), Android menggunakan IP spesial `10.0.2.2`. Django harus mengizinkan host ini agar tidak menolak request.
2.  **`django-cors-headers` (CORS):** Mekanisme keamanan browser/klien yang membatasi HTTP request dari domain berbeda. Kita harus mengizinkan aplikasi Flutter (client) untuk mengambil data dari Django (server).
3.  **Internet Permission (`AndroidManifest.xml`):** Android secara default memblokir akses internet aplikasi demi keamanan. Kita harus menambahkan izin `<uses-permission android:name="android.permission.INTERNET" />` agar aplikasi boleh melakukan *network calls*.

**Jika tidak dikonfigurasi:** Aplikasi akan mengalami error seperti `Connection Refused`, `SocketException`, atau server Django akan membalas dengan `400 Bad Request` / Blocked Host.

### 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

1.  **Input:** Pengguna mengisi form di Flutter (misal: Tambah Produk). Data ditangkap oleh `TextEditingController`.
2.  **Serialisasi:** Saat tombol simpan ditekan, data dikonversi menjadi format JSON (menggunakan `jsonEncode`).
3.  **Pengiriman (Request):** Flutter mengirim HTTP POST request yang berisi JSON tersebut ke endpoint Django menggunakan `CookieRequest`.
4.  **Pemrosesan (Backend):** Django View menerima request, mem-parsing JSON body (`json.loads`), membuat objek Model Django, dan menyimpannya ke database (`.save()`).
5.  **Respon:** Django mengembalikan `JsonResponse` berisi status sukses.
6.  **Feedback:** Flutter menerima respon sukses, lalu melakukan navigasi (misal kembali ke Home) atau me-refresh tampilan.
7.  **Menampilkan (Fetching):** Flutter melakukan HTTP GET request untuk mengambil data terbaru (yang baru saja disimpan), mendeserialisasinya menjadi objek Dart, dan menampilkannya menggunakan Widget (seperti `ListView` atau `GridView`).

### 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout.

1.  **Register:**
    * Flutter mengirim data (username, password) via POST ke endpoint `/auth/register/`.
    * Django memvalidasi data (cek password match, cek username unik). Jika oke, Django membuat `User` baru menggunakan `User.objects.create_user`.
2.  **Login:**
    * Flutter mengirim kredensial via POST ke `/auth/login/`.
    * Django menggunakan fungsi `authenticate()`. Jika valid, Django memanggil `login()` yang membuat sesi di server dan mengembalikan **Session Cookie** ke Flutter.
    * `CookieRequest` di Flutter menyimpan cookie ini.
3.  **Logout:**
    * Flutter mengirim request ke `/auth/logout/` (cookie sesi ikut terkirim otomatis).
    * Django memanggil `logout()` yang menghapus sesi di server.
    * `CookieRequest` di Flutter menghapus cookie lokal, dan status `loggedIn` menjadi false.

---

## Implementasi Checklist Step-by-Step

Berikut adalah langkah-langkah yang saya lakukan untuk menyelesaikan tugas integrasi ini:

### 1. Implementasi Fitur Autentikasi (Frontend & Backend)
* **Persiapan Django:**
    * Membuat app `authentication` di Django.
    * Menginstal `django-cors-headers` dan mengonfigurasinya di `settings.py` (menambahkan middleware dan konfigurasi `CORS_ALLOW_ALL_ORIGINS` serta `ALLOWED_HOSTS`).
    * Membuat view `login` dan `register` di Django yang mengembalikan JSON.
* **Setup Flutter Provider:**
    * Menginstal package `pbp_django_auth` dan `provider`.
    * Memodifikasi `main.dart` untuk membungkus `MaterialApp` dengan `Provider` yang menyediakan `CookieRequest` ke seluruh aplikasi.
* **Halaman Login & Register:**
    * Membuat `signin_page.dart` dan `signup_page.dart`.
    * Menggunakan `TextFormField` untuk input dan validasi.
    * Menghubungkan tombol dengan fungsi `request.login` dan `request.postJson` ke endpoint Django yang sesuai.

### 2. Pembuatan Model Kustom
* Saya mengambil contoh data JSON dari endpoint `/json/` di browser.
* Menggunakan situs **Quicktype** untuk mengonversi JSON tersebut menjadi kode model Dart.
* Membuat file `lib/models/product.dart` dan menempelkan kode hasil generasi tersebut agar data dari Django bisa diolah sebagai objek di Flutter.

### 3. Desain Halaman Detail dan Kartu Produk
* **Product Card:** Membuat widget `product_card.dart` untuk menampilkan ringkasan produk (Gambar, Nama, Harga) dalam bentuk grid atau list.
* **Product Details:** Membuat halaman `product_details.dart`. Halaman ini menerima objek `Product` melalui konstruktor, lalu menampilkan seluruh atribut lengkapnya (Deskripsi, Kategori, Stok, Rating, dll).
* **Navigasi:** Menambahkan fungsi `onTap` pada `ProductCard` untuk melakukan navigasi `Navigator.push` ke halaman detail.

### 4. Halaman Daftar Produk (Home Page)
* Memodifikasi `home_page.dart` untuk mengubah tampilan statis menjadi dinamis.
* Menggunakan **`FutureBuilder`** untuk memanggil fungsi `fetchProduct`.
* Fungsi `fetchProduct` melakukan `request.get` ke endpoint Django, lalu melakukan *parsing* JSON response menjadi `List<Product>`.
* Jika data berhasil diambil, data ditampilkan menggunakan `GridView` (atau `ListView`) yang berisi `ProductCard`.

### 5. Integrasi Form Tambah Produk
* Menghubungkan halaman `add_product.dart` yang sudah dibuat sebelumnya dengan backend.
* Mengubah logika tombol "Save" untuk mengirim data via `request.postJson` ke endpoint Django (misal: `/create-flutter/`).
* Menambahkan penanganan respon sukses (menampilkan SnackBar) atau gagal.

### 6. Fitur Logout
* Menambahkan tombol logout (misalnya di Drawer atau AppBar).
* Menghubungkan tombol tersebut dengan `request.logout` ke endpoint `/auth/logout/`.
* Jika sukses, pengguna diarahkan kembali ke halaman Login (`SignInPage`).

### 7. Filtering Item Berdasarkan User (Bonus/Tugas Tambahan)
* **Backend:** Membuat view baru di Django (misalnya `show_my_json`) yang melakukan query `Product.objects.filter(user=request.user)`.
* **Frontend:**
    * Menambahkan pilihan filter (misalnya Tab atau Tombol "My Products" vs "All Products") di `HomePage`.
    * Memodifikasi logika `fetchProduct` agar memanggil URL endpoint yang berbeda (`/json/` untuk semua, `/json-my/` untuk milik user) tergantung pilihan filter yang aktif.