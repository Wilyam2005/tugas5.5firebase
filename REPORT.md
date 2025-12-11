# Laporan Pembuatan Project

**Judul**: Portal Berita Sederhana dengan Firebase Authentication & Firestore

## Pendahuluan
- Studi kasus: Portal Berita Sederhana.
- Tujuan: Membuat aplikasi Flutter yang terintegrasi dengan Firebase Authentication (email/password) dan Cloud Firestore untuk menyimpan profil pengguna dan data berita.

## Persiapan dan Setup
1. Buat project Flutter baru atau gunakan repository ini.
2. Buat project di Firebase Console (console.firebase.google.com).
   - Aktifkan Authentication -> Sign-in method -> Email/Password.
   - Aktifkan Firestore Database (mode test sementara untuk pengembangan).
3. Hubungkan aplikasi Flutter ke Firebase:
   - Pilih platform (Android/iOS) pada Firebase project, ikuti petunjuk.
   - Unduh `google-services.json` (Android) dan letakkan di `android/app/`.
   - (Direkomendasikan) Jalankan `flutterfire configure` untuk menghasilkan `firebase_options.dart`.

## Pembuatan project Flutter
- Struktur folder utama: `lib/`, `lib/screens/`, `lib/services/`.

## Integrasi Firebase dengan Flutter (Langkah singkat)
- Tambahkan dependencies di `pubspec.yaml`: `firebase_core`, `firebase_auth`, `cloud_firestore`, `provider`.
- Inisialisasi Firebase di `main.dart` dengan `Firebase.initializeApp()`.

## Implementasi Firebase Authentication
- File penting: `lib/services/auth_service.dart`.
- Fungsi utama:
  - `register(email, password)` -> `createUserWithEmailAndPassword`
  - `login(email, password)` -> `signInWithEmailAndPassword`
  - `logout()` -> `signOut()`

### Alur login/registrasi
- `AuthWrapper` (root) mendengarkan `FirebaseAuth.instance.authStateChanges()` via `Provider`.
- Jika user null -> tampilkan `LoginRegisterScreen`.
- Jika user ada -> tampilkan `HomeScreen`.

### Cuplikan kode penting
- Inisialisasi Firebase:

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
```

- Mendengarkan status login (Provider):

```dart
StreamProvider<User?>.value(
  value: FirebaseAuth.instance.authStateChanges(),
  initialData: null,
  child: MaterialApp(...),
)
```

- Fungsi login di `AuthService`:

```dart
Future<UserCredential> login(String email, String password) async {
  return await _auth.signInWithEmailAndPassword(email: email, password: password);
}
```

## Perancangan & Implementasi Data
- Entitas utama:
  - `users` collection: dokumen per pengguna dengan fields: `name`, `bio`.
  - `news` collection: dokumen berita dengan fields: `title`, `summary`, `createdAt`.
- Penyimpanan dan pengambilan data menggunakan `cloud_firestore` dan `FirestoreService`.

## Implementasi Fitur Utama
- Profile: membaca dokumen `users/{uid}` dan menampilkan `name` dan `email`.
- Edit profile: halaman `ProfileEditScreen` menyimpan `name` dan `bio` ke Firestore.
- News list: `NewsListScreen` menampilkan dokumen dari koleksi `news`.

## Tampilan Antarmuka (UI)
- Halaman utama setelah login menampilkan salam: "Halo, [Nama User]" dan tombol navigasi ke Daftar Berita dan Profil.
- Halaman Login/Register: Form sederhana untuk email & password dengan validasi minimal.

### Screenshot (lampirkan saat mengumpulkan):
- Login
- Register
- Profile
- Daftar Berita

## Penggunaan AI
- AI membantu membuat struktur project, contoh kode, dan merapikan teks laporan.
- Tools: ChatGPT/Copilot (catatan: sebutkan sesuai yang Anda gunakan)

## File ENV
- Jika menggunakan file env (tidak wajib). Sertakan `google-services.json` untuk Android dan `GoogleService-Info.plist` untuk iOS.

## Penutup
- Nama file laporan PDF yang dikumpulkan: `npm_nama_firebase-auth.pdf`.
- Sertakan link repository di laporan.

---

> Catatan: Laporan ini adalah template; lengkapi dengan screenshot dan langkah-langkah detail saat Anda melakukan konfigurasi Firebase di mesin Anda.