# 🏆 MASTER CHEATSHEET: Skybase Flutter GetX Architecture

Dokumen ini adalah panduan lengkap untuk memahami, menjelaskan, dan mengimplementasikan fitur di dalam codebase ini. Sangat berguna untuk referensi cepat saat **Coding Challenge** atau **Sesi Interview**.

---

## 1. Arsitektur & Hierarki File
Aplikasi ini menggunakan pola **Layered Architecture** yang dipadukan dengan **GetX State Management**.

*   **`lib/config`**: Pengaturan global aplikasi (AuthManager, Themes, Base Classes).
*   **`lib/core`**: Utilitas utama (Extensions, Helpers, Mixins, Localization).
*   **`lib/data`**: Layer Data (Models, Repositories, API Sources).
*   **`lib/ui`**: Layer Presentasi (Views, Controllers, Widgets, Routes).

---

## 2. Alur Komunikasi Antar File (Communication Flow)
Pahami bagaimana satu file memanggil file lainnya:

1.  **View `->` Controller**: View meng-extend `GetView<T>` untuk akses instan ke controller.
2.  **Controller `->` Repository**: Controller memanggil fungsi repository dengan mem-pass `requestParams`.
3.  **Repository `->` BaseRepository**: Repository menggunakan `with CacheMixin` untuk otomatisasi simpan/ambil data lokal (Offline First).
4.  **Binding `->` Dependency Injection**: File Binding menghubungkan Repository ke Controller saat Route dipanggil.

---

## 3. Komponen Utama (The "Base" Classes)

### **A. BaseController & PaginationController**
*   Menyediakan status: `isLoading`, `isError`, `isSuccess`, `isEmpty`.
*   **Pagination**: Otomatis menangani `page`, `perPage`, dan infinite scroll.

### **B. BaseStreamController (Realtime)**
*   Digunakan untuk Chat atau Live Tracking.
*   Menggunakan `bindStream` agar UI update otomatis saat data di Firebase berubah.

### **C. BaseRepository (Caching)**
*   `loadCachedList`: Pola Ambil Cache -> Jika Expired -> Panggil API -> Simpan Cache.

---

## 4. "Senjata Rahasia" (Extensions & Helpers)

| Nama | Contoh Penggunaan | Kegunaan |
| :--- | :--- | :--- |
| **ContextExt** | `context.typography.body1` | Styling teks tanpa pusing |
| **ContextExt** | `context.width` | Responsivitas ukuran layar |
| **NumExt** | `10.verticalSpacing` | Pengganti `SizedBox(height: 10)` |
| **StringExt** | `'email'.isEmail` | Validasi string instan |
| **DialogHelper** | `DialogHelper.failed(message: '..')` | Munculkan pop-up error standar |
| **LoadingDialog** | `LoadingDialog.show()` | Munculkan overlay loading |

---

## 5. Tanya Jawab Teknis (Interview Verified)

**Q: Bagaimana cara handle UI agar tidak lag saat list data sangat banyak?**  
**A:** Gunakan `ListView.builder` (hanya render yang terlihat) dan implementasikan **Pagination** (Lazy Loading) menggunakan `PaginationController`.

**Q: Di mana menyimpan Token agar aman?**  
**A:** Menggunakan `flutter_secure_storage` (Keychain/Keystore). Untuk data cache biasa, gunakan `Hive` atau `GetStorage`.

**Q: Mengapa pakai Dio dibanding http?**  
**A:** Dio mendukung **Interceptors** (untuk selipkan token otomatis/handle 401), Global Config, dan penanganan error yang lebih baik.

**Q: Bagaimana alur Push Notification?**  
**A:** Device mendaftarkan token ke FCM -> Token dikirim ke server kita -> Server kirim notifikasi melalui FCM -> Diterima oleh `NotificationService` di app.

---

## 6. Contoh Implementasi Chat (Realtime)
*   **Database**: Firebase Realtime Database.
*   **Listener**: Menggunakan `.onValue.listen` di Repository.
*   **UI**: Menggunakan `Obx` yang membungkus `BaseStreamController`.

---

## 7. Final Checklist (Sebelum Submit Code)

- [ ] Folder terstruktur (Data, UI, Core).
- [ ] Try-Catch di setiap hit API.
- [ ] Gunakan `StateView` untuk handle loading/error di UI.
- [ ] Tidak ada hardcoded warna/font (Gunakan `context.typography` / `AppColors`).
- [ ] Bersihkan log/print yang tidak perlu.

**Gunakan dokumen ini sebagai panduan utama Anda. Anda sudah siap untuk menang! 🚀**
