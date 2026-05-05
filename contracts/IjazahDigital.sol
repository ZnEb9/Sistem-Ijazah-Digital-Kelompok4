// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IjazahDigital {

    // 1. Variabel State & Access Control
    address public adminUniversitas;

    // Struktur data untuk menyimpan informasi ijazah
    struct Ijazah {
        string namaMahasiswa;
        string nim;
        string programStudi;
        string ipfsHash; // Link ke dokumen asli di penyimpanan off-chain
        uint256 tanggalLulus;
        bool isValid; // Status untuk mengecek apakah ijazah dicabut
    }

    // Mapping untuk mencari ijazah berdasarkan ID/Hash unik
    mapping(string => Ijazah) private daftarIjazah;

    // 2. Event Logging untuk pelacakan di Etherscan
    event IjazahDiterbitkan(string idIjazah, string namaMahasiswa, string nim);
    event IjazahDicabut(string idIjazah, string alasan);

    // Modifier untuk membatasi akses (Hanya admin universitas yang bisa menambah data)
    modifier onlyOwner() {
        require(msg.sender == adminUniversitas, "Akses ditolak: Bukan Admin Universitas");
        _;
    }

    // Konstruktor dijalankan saat contract di-deploy
    constructor() {
        adminUniversitas = msg.sender; // Set akun yang men-deploy sebagai admin
    }

    // ==========================================
    // 3. FUNGSI INTI (Masih berupa Skeleton)
    // ==========================================

    /**
     * @dev Fungsi Pencatatan (Write) - Menambahkan data ijazah baru ke blockchain
     * Akses: Hanya Admin Universitas (onlyOwner)
     */
    function addCertificate(
        string memory _idIjazah,
        string memory _nama,
        string memory _nim,
        string memory _prodi,
        string memory _ipfsHash
    ) public onlyOwner {
        // TODO: Tambahkan logika validasi idIjazah agar tidak duplikat
        // TODO: Simpan data ke dalam mapping daftarIjazah
        // TODO: Pancarkan event IjazahDiterbitkan
    }

    /**
     * @dev Fungsi Verifikasi (Read) - Mengambil data ijazah untuk divalidasi publik
     * Akses: Publik (Siapa saja bisa mengecek)
     */
    function verifyCertificate(string memory _idIjazah) 
        public 
        view 
        returns (
            string memory nama, 
            string memory nim, 
            string memory prodi, 
            string memory ipfsHash, 
            bool isValid
        ) 
    {
        // TODO: Ambil data dari mapping berdasarkan _idIjazah
        // TODO: Kembalikan nilai-nilai tersebut ke pemanggil fungsi
    }

    /**
     * @dev Fungsi Update - Mencabut status keabsahan ijazah (misal: jika ada pelanggaran)
     * Akses: Hanya Admin Universitas (onlyOwner)
     */
    function revokeCertificate(string memory _idIjazah, string memory _alasan) public onlyOwner {
        // TODO: Pastikan ijazah ada di dalam sistem
        // TODO: Ubah status isValid menjadi false
        // TODO: Pancarkan event IjazahDicabut
    }
}
