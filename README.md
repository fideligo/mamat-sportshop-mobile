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
