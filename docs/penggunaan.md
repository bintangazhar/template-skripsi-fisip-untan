
## Cara Pakai

```typst
#import "@preview/{{NAMA}}:{{VERSI}}": *

#show: skripsi.with(
  judul: [Judul Skripsi],
  nama: "Nama Mahasiswa",
  nim: "E1101000000",
  prodi: "Ilmu Komunikasi",
  kajian: "Jurnalistik dan Media",
  tahun: "2026",
  pembimbing-1: (nama: "Nama, M.Si", nip: "..."),
  pembimbing-2: (nama: "Nama, M.Si", nip: "..."),
  penguji-1: (nama: "Nama, M.Si", nip: "..."),
  penguji-2: (nama: "Nama, M.Si", nip: "..."),
  dekan: (nama: "Nama Dekan", nip: "..."),
  hari-tanggal-ujian: "Kamis / 09 Juli 2026",
  waktu-ujian: "09.00 - 12.00 WIB",
  tempat-ujian: "Ruang Sidang 6",
)

#abstrak(kata-kunci: [A, B, C])[Isi abstrak ...]

#pernyataan-keaslian()

#daftar-isi()

#show: bagian-inti

= BAB I \ PENDAHULUAN
== Latar Belakang Penelitian
Menurut #cite("silalahi2009")[23-24], ...
Penelitian komparatif ... @silalahi2009[35-36].
...

#daftar-pustaka(bibliography("refs.bib"))

#lampiran[Panduan Wawancara][ ... ]
```

### Mengutip dan daftar pustaka

Tambahkan referensi ke `refs.bib` (BibTeX) atau berkas Hayagriva `.yml`, lalu kutip dengan `@kunci`.

| Penulisan | Hasil |
| --- | --- |
| `#cite("silalahi2009")[23-24]` | Silalahi (2009, 23-24) |
| `#cite("silalahi2009")` | Silalahi (2009) |
| `#cite-dalam([Bintang], "silalahi2009")[23]` | Bintang (dalam Silalahi 2009, 23) |
| `#cite-dalam-kurung([Bintang], "silalahi2009")[23]` | (Bintang dalam Silalahi 2009, 23) |
| `@silalahi2009[35-36]` | (Silalahi 2009, 35-36) |
| `@ward2007[52]` | (Ward dan Burns 2007, 52) |
| `@ward2012[76-81]` | (Ward dkk. 2012, 76-81) |

`#cite("kunci")[halaman]` adalah versi ringkas dari `#cite(<kunci>, form: "prose", supplement: [halaman])` untuk nama penulis di awal kalimat. `#cite-dalam(..)` dipakai untuk kutipan tidak langsung di awal kalimat ("Bintang (dalam Silalahi 2009, 23)"); `#cite-dalam-kurung(..)` untuk yang di akhir kalimat ("(Bintang dalam Silalahi 2009, 23)"). Yang masuk daftar pustaka hanya sumber yang benar-benar dibaca (Silalahi).

Gaya Chicago bawaan Typst tidak menampilkan kolom `address`. Agar tampil sebagai "Bandung: Refika Aditama" seperti di panduan FISIP, tulis kota dan penerbit sekaligus di kolom `publisher`:

```bib
@book{silalahi2009,
  author    = {Silalahi, Ulber},
  year      = {2009},
  title     = {Metode Penelitian Sosial},
  publisher = {Bandung: Refika Aditama},
}
```

Untuk memunculkan sumber yang tidak dikutip, tambahkan `#cite(<kunci>, form: none)`.

### Tabel dan gambar

Judul di atas, sumber di bawah (rata kiri). Nomor otomatis mengikuti BAB.

```typst
#figure(
  kind: table,
  caption: [Distribusi Responden],
  [
    #table(columns: 2, [A], [B])
    #sumber[Data primer, diolah penulis (2026)]
  ],
) <tbl-responden>
```

### Fungsi

| Fungsi | Keterangan |
| --- | --- |
| `skripsi(..)` | Pengaturan dokumen, sampul, lembar persetujuan, dan halaman pengesahan. |
| `abstrak(kata-kunci: .., body)` | Halaman abstrak. |
| `pernyataan-keaslian()` | Halaman pernyataan keaslian, diisi otomatis dari data `skripsi(..)`. |
| `daftar-isi()` | Daftar isi, serta daftar tabel/gambar/lampiran jika ada. |
| `bagian-inti` | Dipakai dengan `#show: bagian-inti`; mengatur penomoran halaman, nomor subbab, serta nomor tabel/gambar per BAB. Setiap `= BAB ...` otomatis mulai di halaman baru. |
| `sumber[..]` | Keterangan sumber di bawah tabel/gambar; dipakai di dalam `figure`. |
| `daftar-pustaka(bib)` | Halaman daftar pustaka; argumennya `bibliography("berkas.bib")`. |
| `lampiran[judul][isi]` | Satu lampiran: otomatis "LAMPIRAN 1, 2, ...", mulai di halaman baru langsung setelah daftar pustaka, dan masuk ke Daftar Lampiran (halaman daftar hanya muncul jika ada lampiran). |

## Font

Template memakai **Liberation Serif** (padanan Times New Roman). Di Typst web app font ini sudah tersedia. Jika compile lokal, pasang font tersebut atau gunakan `--font-path`.

## Lisensi & aset

- Kode dan file template berlisensi [MIT-0](LICENSE).

- `src/img/logo-untan.svg` dan `src/img/logo-untan.png` adalah **logo Universitas Tanjungpura** dan merupakan milik UNTAN; **tidak** dicakup lisensi MIT-0.
