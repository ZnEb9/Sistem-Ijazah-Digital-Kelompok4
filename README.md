# 🎓 SIVIL: Sistem Verifikasi Ijazah Digital Berbasis Blockchain
**Proyek Ujian Akhir Semester (UAS) Mata Kuliah Teknologi Blockchain**  
**Program Studi Sistem Informasi - Institut Teknologi PLN**

SIVIL adalah platform desentralisasi (*DApp*) yang dirancang untuk mencegah pemalsuan dokumen akademik dengan memanfaatkan teknologi *blockchain*. Sistem ini memungkinkan institusi untuk menerbitkan ijazah secara *immutable* (tidak dapat diubah), menjamin integritas data melalui *Double Hashing Cryptography*, dan memfasilitasi verifikasi pihak ketiga secara instan tanpa ketergantungan pada *database* terpusat.

---

## 👥 Tim Pengembang (Kelompok 4 - Kelas C)
Proyek ini dikembangkan oleh:
1. **Ahmad Zulfadhli** (202332038)
2. **Benaya Joshrael Tualangi** (202332044)
3. **Zahra Maharani** (202332047)
4. **Demas Apta Aryamadhan** (202332052)

**Dosen Pengampu:** Riani Saputri Abadi

---

## 🛠️ Tech Stack & Fitur Utama
Sistem telah diimplementasikan penuh dengan *stack* teknologi sebagai berikut:

### Teknologi
- **Platform Blockchain:** Ethereum
- **Smart Contract:** Solidity (dengan manajemen *Role-Based Access Control*)
- **Jaringan (Network):** Testnet Sepolia
- **Frontend:** HTML5, Bootstrap 5, Ethers.js
- **Keamanan:** *Double Hashing Cryptography* (SHA-256 + Keccak256)
- **Deployment:** Vercel

### Fitur
- **Otoritas Bertingkat**: Manajemen hak akses untuk Admin Utama (Rektorat), Staf Penerbit, dan Alumni.
- **Double Hashing**: Keamanan berlapis yang mengikat *sidik jari* dokumen fisik PDF dengan identitas nasional.
- **Public Verification**: Verifikasi otentikasi dokumen secara publik tanpa memerlukan dompet digital.
- **Brankas Alumni**: Katalog digital untuk alumni melihat koleksi ijazah lintas jenjang pendidikan.

---

## 📂 Struktur Repository
Repository ini telah diperbarui untuk mencakup implementasi UAS:
- `/contracts` : Berisi *smart contract* `Sivil.sol` yang menangani logika bisnis, *access control*, dan validasi *on-chain*.
- `/css` : Berisi *style* desain modern berbasis *Glassmorphism*.
- `/js` : *Logic handler* `app.js` yang mengintegrasikan MetaMask dan kalkulasi *hashing*.
- `/*.html` : Seluruh halaman dashboard (Admin, Staf, Alumni, Publik).

---

## 🚀 Status Proyek
Proyek telah **Selesai (Finalized)**. Sistem telah melewati tahap *End-to-End Testing* dan telah dideploy pada jaringan Sepolia Testnet dengan *Contract Address*: `0xDbAb0C07B1f0118C55304550d91e60A133CcBEAc`.
