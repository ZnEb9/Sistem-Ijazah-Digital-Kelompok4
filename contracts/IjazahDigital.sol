// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SivilBlockchain {
    address public adminUtama;
    
    // Mapping untuk daftar staf (True = Aktif, False = Nonaktif)
    mapping(address => bool) public isStaf;

    struct Ijazah {
        string nomorIjazah;
        string nama;
        string nik;
        string prodi;
        string hashDokumen;
        uint256 tanggalTerbit;
        bool isTerdaftar;
    }

    // Kunci utama menggunakan bytes32 (Hasil hash gabungan di frontend: PDF+No+Nama+NIK)
    mapping(bytes32 => Ijazah) private dataIjazah;
    
    // Satu dompet bisa memiliki banyak ijazah (SD, SMP, SMA, Kuliah, dll)
    mapping(address => bytes32[]) private walletKeDaftarIjazah;

    // Log untuk transparansi blockchain
    event IjazahDiterbitkan(bytes32 indexed idIjazah, string nomorIjazah, address walletAlumni, uint256 waktu);
    event StafDitambahkan(address staf);
    event StafDihapus(address staf);

    // Modifier Keamanan
    modifier hanyaAdmin() {
        require(msg.sender == adminUtama, "Akses ditolak: Hanya Admin Utama!");
        _;
    }

    modifier hanyaStafAtauAdmin() {
        require(msg.sender == adminUtama || isStaf[msg.sender], "Akses ditolak: Anda bukan staf atau admin!");
        _;
    }

    // Constructor berjalan sekali saat deploy
    constructor() {
        adminUtama = msg.sender;
    }

    // MANAJEMEN STAF (Hanya Admin Utama)
    function tambahStaf(address _staf) public hanyaAdmin {
        require(!isStaf[_staf], "Alamat dompet ini sudah menjadi staf!");
        isStaf[_staf] = true;
        emit StafDitambahkan(_staf);
    }

    function hapusStaf(address _staf) public hanyaAdmin {
        require(isStaf[_staf], "Alamat dompet ini bukan staf!");
        isStaf[_staf] = false;
        emit StafDihapus(_staf);
    }

    // PENERBITAN IJAZAH (Oleh Admin & Staf)
    function terbitkanIjazah(
        bytes32 _idIjazah, 
        string memory _nomorIjazah, 
        string memory _nama, 
        string memory _nik, 
        string memory _prodi, 
        string memory _hashDokumen, 
        address _walletAlumni
    ) public hanyaStafAtauAdmin {
        // Validasi input penting tidak boleh kosong
        require(bytes(_nomorIjazah).length > 0, "Nomor Ijazah kosong!");
        require(bytes(_hashDokumen).length > 0, "Hash Dokumen kosong!");
        require(_walletAlumni != address(0), "Wallet tidak valid!");
        
        // Pastikan Ijazah ini belum pernah diterbitkan
        require(!dataIjazah[_idIjazah].isTerdaftar, "Ijazah dengan kombinasi data ini sudah ada di Blockchain!");
        
        // Simpan data permanen ke Blockchain
        dataIjazah[_idIjazah] = Ijazah(
            _nomorIjazah, 
            _nama, 
            _nik, 
            _prodi, 
            _hashDokumen, 
            block.timestamp, 
            true
        );
        
        // Hubungkan ijazah ke dompet alumni
        walletKeDaftarIjazah[_walletAlumni].push(_idIjazah);

        emit IjazahDiterbitkan(_idIjazah, _nomorIjazah, _walletAlumni, block.timestamp);
    }

    // VERIFIKASI (Untuk Verifikator Publik - Gratis)
    function verifikasiPublik(bytes32 _idIjazah) public view returns (
        string memory nomorIjazah,
        string memory nama,
        string memory nik,
        string memory prodi,
        string memory hashDokumen,
        uint256 tanggalTerbit,
        bool statusValid
    ) {
        require(dataIjazah[_idIjazah].isTerdaftar, "Ijazah tidak ditemukan atau palsu!");
        
        Ijazah memory ijazah = dataIjazah[_idIjazah];
        return (
            ijazah.nomorIjazah, 
            ijazah.nama, 
            ijazah.nik, 
            ijazah.prodi, 
            ijazah.hashDokumen, 
            ijazah.tanggalTerbit, 
            ijazah.isTerdaftar
        );
    }

    // DASHBOARD ALUMNI (Melihat Koleksi Ijazah)
    function lihatDaftarIjazahSaya() public view returns (bytes32[] memory) {
        return walletKeDaftarIjazah[msg.sender];
    }
}
