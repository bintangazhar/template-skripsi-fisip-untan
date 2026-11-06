#import "@preview/skripsi-fisip-untan-kuantitatif:0.1.0": *

// ==========================================
// DATA SKRIPSI (ubah data di sini)
// ==========================================
#let judul = [Judul Skripsi Anda yang Ditulis di Sini dengan _Kata Asing Dicetak Miring_]
#let nama = "Nama Mahasiswa"
#let nim = "E1101000000"
#let prodi = "Ilmu Komunikasi"
#let kajian = "Jurnalistik dan Media"
#let fakultas = "Fakultas Ilmu Sosial dan Ilmu Politik"
#let universitas = "Universitas Tanjungpura"
#let kota = "Pontianak"
#let tahun = "2026"


#let pembimbing-1 = (nama: "Nama Pembimbing Utama, M.Si", nip: "19700101 200001 1 001")
#let pembimbing-2 = (nama: "Nama Pembimbing Pendamping, M.Si", nip: "19750101 200001 1 002")
#let penguji-1 = (nama: "Dr. Nama Penguji Utama, M.Si", nip: "19650302 199002 2 001")
#let penguji-2 = (nama: "Dr. Nama Penguji Pendamping, M.Si", nip: "19740810 200212 2 002")
#let dekan = (nama: "Nama Dekan, S.Sos., M.Si.", nip: "19720521 200604 1 001")


#let hari-tanggal-ujian = "Kamis / 09 Juli 2026"
#let waktu-ujian = "09.00 - 12.00 WIB"
#let tempat-ujian = "Ruang Sidang 6"

// ==========================================
// SAMPUL, LEMBAR PERSETUJUAN, & PENGESAHAN
// ==========================================
#show: skripsi.with(
  judul: judul,
  nama: nama,
  nim: nim,
  prodi: prodi,
  kajian: kajian,
  fakultas: fakultas,
  universitas: universitas,
  kota: kota,
  tahun: tahun,
  pembimbing-1: pembimbing-1,
  pembimbing-2: pembimbing-2,
  penguji-1: penguji-1,
  penguji-2: penguji-2,
  dekan: dekan,
  hari-tanggal-ujian: hari-tanggal-ujian,
  waktu-ujian: waktu-ujian,
  tempat-ujian: tempat-ujian,
  // Opsi sembunyikan halaman (default true):
  // tampilkan-sampul: false,       // sembunyikan sampul luar & dalam
  // tampilkan-persetujuan: false,  // sembunyikan lembar persetujuan
  // tampilkan-pengesahan: false,   // sembunyikan halaman pengesahan
)

// ==========================================
// BAGIAN AWAL
// ==========================================

#abstrak(kata-kunci: [Kata kunci 1, Kata kunci 2, Kata kunci 3])[
  Isi abstrak 200-250 kata, memuat: 1) apa yang diteliti, 2) bagaimana melakukan penelitiannya, 3) apa hasil penelitiannya, dan 4) rekomendasinya.
]

#pagebreak()

= RINGKASAN SKRIPSI

Skripsi ini berjudul #judul. Judul ini dipilih karena ... (Narasi ringkasan mencakup: 1) Judul, 2) Latar Belakang, 3) Rumusan Masalah, 4) Tujuan & Manfaat, 5) Metode Penelitian, 6) Hasil/Temuan, dan 7) Saran-saran. Maksimal 3 halaman / 700–1000 kata).

#lorem(100)

#pagebreak()

#pernyataan-keaslian()

#pagebreak()

= MOTTO DAN PERSEMBAHAN

#[
  #set par(first-line-indent: 0pt)

  #align(center)[
    _"Tuliskan motto Anda di sini."_ \
    #align(right)[— (Nama Penulis / Tokoh)]
  ]

  #v(1cm)
  *Skripsi ini dipersembahkan untuk:*
  1. Kedua orang tua dan keluarga tercinta atas dukungan dan doa yang tiada henti.
  2. Civitas akademika Program Studi #prodi #fakultas #universitas.
  3. Almamater tercinta #universitas.
]

#pagebreak()

= KATA PENGANTAR

Puji syukur penulis panjatkan kehadirat Allah SWT atas rahmat dan hidayah-Nya akhirnya penulisan skripsi yang berjudul #judul ini dapat diselesaikan dengan baik tepat pada waktunya.

Skripsi ini disusun sebagai tugas akhir dan merupakan kewajiban yang harus dipenuhi sebagai salah satu syarat untuk memperoleh gelar sarjana pada #fakultas #universitas. Selanjutnya penulis menyadari akan kekurangan dari penulisan skripsi ini, karena hasil yang dicapai melalui skripsi ini baru merupakan langkah awal dari suatu perjalanan panjang khasanah ilmu pengetahuan yang penulis dapatkan.

Keberhasilan dalam penulisan skripsi ini tidak terlepas dari berbagai pihak yang telah memberikan bantuan dan dorongan kepada penulis. Oleh karena itu pada kesempatan ini penulis mengucapkan terima kasih yang tak terhingga dan penghargaan yang setinggi-tingginya kepada:
1. #dekan.nama, selaku Dekan #fakultas #universitas.
2. #pembimbing-1.nama, selaku Pembimbing Utama, dan #pembimbing-2.nama, selaku Pembimbing Pendamping yang telah memberikan kemudahan, arahan, serta bimbingan selama proses penulisan skripsi ini.
3. #penguji-1.nama, selaku Penguji Utama, dan #penguji-2.nama, selaku Penguji Pendamping yang telah banyak memberikan masukan guna kesempurnaan skripsi ini.
4. Seluruh Pembantu Dekan, Dosen, Staf Tata Usaha, dan Akademik #fakultas #universitas yang telah banyak memberikan dukungan selama masa perkuliahan.
5. Rekan-rekan mahasiswa #prodi angkatan #tahun yang selalu memberikan semangat dan bantuan selama penyusunan skripsi ini.
6. Serta semua pihak yang tidak dapat disebutkan satu per satu yang telah banyak membantu hingga terselesaikannya skripsi ini.

Semoga segala kebaikan, bantuan, dan dorongan yang telah diberikan mendapat balasan dari Allah SWT, dan hasil karya ini dapat memberikan manfaat bagi kita semua.

#v(1cm)
#align(right)[
  #block(width: 6cm)[
    #set align(center)
    #set par(first-line-indent: 0pt, leading: 0.5em)

    #kota, ....................... #tahun \
    #v(1.5cm)
    *#nama*
  ]
]

#pagebreak()

// Daftar isi, tabel, dan gambar dibuat otomatis
#daftar-isi()

// ==========================================
// BAGIAN INTI
// ==========================================
// Kerangka mengikuti sistematika penelitian KUANTITATIF (Panduan FISIP UNTAN, Bab III);
// untuk kualitatif gunakan template skripsi-fisip-untan-kualitatif.
// Tiap `= BAB ...` mulai di halaman baru dan penomoran tabel/gambar diulang per BAB.
#show: bagian-inti

= BAB I \ PENDAHULUAN

== Latar Belakang Penelitian

Tuliskan latar belakang penelitian: alasan masalah dipandang menarik, penting, dan perlu diteliti; kedudukan masalah dalam konteks yang lebih luas; fakta empiris; serta keterbaruan penelitian.

Cara mengutip sumber (sistem _author-date_ Chicago). Nama penulis di awal kalimat: Menurut #cite("silalahi2009")[23-24], penelitian dasar dimaksudkan untuk menjawab pertanyaan yang bersifat teoritis. Kutipan tidak langsung: #cite-dalam([Bintang], "silalahi2009")[23] menegaskan hal tersebut, sebagaimana juga dikemukakan #cite-dalam-kurung([Bintang], "silalahi2009")[24]. Nama penulis di akhir kalimat: penelitian komparatif biasanya berupa komparatif deskriptif maupun korelasional @silalahi2009[35-36]. Dua penulis @ward2007[52], tiga penulis atau lebih @ward2012[76-81], dan artikel jurnal @weinstein2009[440].

== Identifikasi Masalah Penelitian

Uraikan secara singkat variabel-variabel yang akan diteliti.

== Pembatasan Penelitian

Batasi variabel yang diteliti beserta argumentasinya.

== Rumusan Masalah

Tuliskan rumusan masalah dalam bentuk kalimat tanya.

== Tujuan Penelitian

Tuliskan tujuan penelitian untuk menjawab rumusan masalah.

== Manfaat Penelitian

=== Manfaat Teoritis

Sumbangan hasil penelitian terhadap ilmu pengetahuan.

=== Manfaat Praktis

Kontribusi pemikiran praktis bagi pihak-pihak terkait.

= BAB II \ KAJIAN PUSTAKA

== Teori

Kutipan langsung kurang dari lima baris ditulis dalam teks dengan tanda petik, misalnya Wahab berpendapat bahwa "implementasi merupakan salah satu tahapan yang sangat penting."

Kutipan langsung lebih dari lima baris dipisah dari teks dengan `#quote(block: true)`:

#quote(block: true)[#lorem(60)]

== Hasil Penelitian yang Relevan

Tampilkan penelitian terdahulu yang relevan, misalnya skripsi @kukoc2008 atau jurnal @kossinets2009.

== Kerangka Pikir

Jelaskan keterkaitan antarvariabel, dapat dilengkapi skema atau model.

#figure(
  kind: image,
  caption: [Contoh Kerangka Pikir],
  [
    #rect(width: 70%, height: 3cm, stroke: 0.5pt)[
      #set align(center + horizon)
      Ganti dengan `image("gambar.png")`
    ]
    #sumber[Olahan penulis, #tahun]
  ],
) <gbr-kerangka-pikir>

Kerangka pikir ditunjukkan pada @gbr-kerangka-pikir.

== Hipotesis

Tuliskan hipotesis penelitian.

== Definisi Konsep dan Definisi Operasional Variabel

Jabarkan definisi konseptual, definisi operasional, dan indikator.

= BAB III \ METODE PENELITIAN

== Jenis Penelitian

Jelaskan alasan penggunaan pendekatan dan jenis penelitian.

== Langkah-langkah Penelitian

Jelaskan langkah penelitian mulai dari pra-survei hingga ujian skripsi.

== Lokasi dan Waktu Penelitian

Jelaskan lokasi dan waktu penelitian beserta alasannya.

== Populasi dan Sampel Penelitian

Jelaskan populasi, sampel, dan teknik penarikan sampel.

== Teknik Pengumpulan Data

Jelaskan teknik pengumpulan data.

== Alat Pengumpulan Data

Jelaskan instrumen yang digunakan.

== Uji Validitas dan Reliabilitas

Jelaskan uji validitas dan reliabilitas instrumen.

== Teknik Analisis Data

Jelaskan prosedur dan alat analisis data.

= BAB IV \ GAMBARAN UMUM LOKASI PENELITIAN

Uraikan gambaran umum wilayah, organisasi, atau lembaga yang menjadi objek penelitian.

= BAB V \ HASIL PENELITIAN DAN PEMBAHASAN

== Deskripsi Variabel Penelitian

Tabel diberi judul di atas, dan sumber di bawah tabel (lihat @tbl-contoh).

#figure(
  kind: table,
  caption: [Contoh Distribusi Responden],
  [
    #table(
      columns: (1fr, auto, auto),
      align: (left, center, center),
      stroke: (x: none),
      table.header[*Kategori*][*Jumlah*][*Persen*],
      [Laki-laki], [40], [50%],
      [Perempuan], [40], [50%],
    )
    #sumber[Data primer, diolah penulis (#tahun)]
  ],
) <tbl-contoh>

== Uji Hipotesis

Uji hipotesis dengan uji statistik yang ditetapkan.

== Pembahasan

Analisis hasil uji hipotesis untuk menjawab rumusan masalah.

= BAB VI \ PENUTUP

== Simpulan

Intisari penelitian berdasarkan pembahasan pada Bab V.

== Implikasi

Prediksi manfaat hasil penelitian secara teoritis dan praktis (bila ada).

== Saran

Usulan bagi pihak-pihak terkait.

== Keterbatasan Penelitian

Kekurangan atau kelemahan dalam melakukan penelitian.

// ==========================================
// DAFTAR PUSTAKA
// ==========================================
// Isi referensi di refs.bib; hanya sumber yang dikutip yang tampil
// (sumber tak dikutip: `#cite(<kunci>, form: none)`).
#daftar-pustaka(bibliography("refs.bib"))

// ==========================================
// LAMPIRAN
// ==========================================
// Bernomor otomatis dan masuk Daftar Lampiran. Hapus bagian ini jika tidak ada lampiran.
#lampiran[Angket / Kuesioner Penelitian][
  #set par(first-line-indent: 0pt, leading: 0.65em)
  + Pernyataan pertama ...
  + Pernyataan kedua ...
  + Pernyataan ketiga ...
]

#lampiran[Daftar Riwayat Hidup][
  #set par(first-line-indent: 0pt, leading: 0.65em)
  #grid(
    columns: (4cm, 12pt, 1fr),
    row-gutter: 0.8em,
    [Nama], [:], [#nama],
    [NIM], [:], [#nim],
    [Program Studi], [:], [#prodi],
    [Tempat, tanggal lahir], [:], [...],
    [Alamat], [:], [...],
  )
]
