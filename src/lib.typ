// Template skripsi FISIP Universitas Tanjungpura (UNTAN).
//
// Pemakaian: `#show: skripsi.with(judul: [...], nama: "...", nim: "...", ...)`
// Fungsi: skripsi, abstrak, pernyataan-keaslian, daftar-isi, bagian-inti, sumber,
// cite, cite-dalam, cite-dalam-kurung, daftar-pustaka, lampiran.

#let _config = state("skripsi-fisip-untan-config", (:))
#let _leading-naskah = 1.5em

// ==========================================
// FUNGSI UTAMA
// ==========================================

/// Pengaturan dokumen, sampul, lembar persetujuan, dan halaman pengesahan.
#let skripsi(
  kind: "skripsi",
  judul: [Judul Skripsi],
  nama: "Nama Mahasiswa",
  nim: "E1101000000",
  prodi: "Ilmu Komunikasi",
  kajian: "Jurnalistik dan Media",
  fakultas: "Fakultas Ilmu Sosial dan Ilmu Politik",
  universitas: "Universitas Tanjungpura",
  kota: "Pontianak",
  tahun: str(datetime.today().year()),
  // Dosen berupa dictionary: (nama: "...", nip: "...")
  pembimbing-1: (nama: "Nama Pembimbing Utama, M.Si", nip: "00000000 000000 0 000"),
  pembimbing-2: (nama: "Nama Pembimbing Pendamping, M.Si", nip: "00000000 000000 0 000"),
  penguji-1: (nama: "Dr. Nama Penguji Utama, M.Si", nip: "00000000 000000 0 000"),
  penguji-2: (nama: "Dr. Nama Penguji Pendamping, M.Si", nip: "00000000 000000 0 000"),
  dekan: (nama: "Nama Dekan", nip: "00000000 000000 0 000"),
  hari-tanggal-ujian: "Hari / 00 Bulan 0000",
  waktu-ujian: "00.00 - 00.00 WIB",
  tempat-ujian: "Ruang Sidang",
  // Opsi tampilkan/sembunyikan halaman (default true)
  tampilkan-sampul: true,
  tampilkan-persetujuan: true,
  tampilkan-pengesahan: true,
  body,
) = {
  _config.update((
    judul: judul,
    nama: nama,
    nim: nim,
    prodi: prodi,
    kajian: kajian,
    fakultas: fakultas,
    universitas: universitas,
    kota: kota,
    tahun: tahun,
  ))

  set page(
    paper: "a4",
    margin: (top: 4cm, left: 4cm, bottom: 3cm, right: 3cm),
  )
  set text(font: "Liberation Serif", size: 12pt, lang: "id", region: "ID")

  set underline(offset: 3pt)

  set bibliography(style: "chicago-author-date", title: none)
  // `all: true`: paragraf pertama setelah heading/gambar/tabel tetap menjorok.
  set par(
    leading: _leading-naskah,
    spacing: _leading-naskah,
    first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
    justification-limits: (tracking: (min: -0.01em, max: 0.02em)),
  )

  // Heading sendiri tanpa indent & justify (akibat `all: true`).
  show heading: set par(first-line-indent: 0pt, justify: false)
  show heading: set text(size: 12pt, weight: "bold")
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): set par(leading: 0.65em)
  // Jarak heading: default above 1,5em + 8pt, below 1,5em; heading yang
  // langsung diikuti subheading (tanpa teks) memakai jarak khusus berikut.
  let jarak-h1-h2 = 2.5em
  let jarak-h2-h3 = 1.25em
  show heading: set block(above: 0pt, below: 0pt)
  show heading: it => context {
    let ini = it.location()
    let prev-h = query(selector(heading).before(ini, inclusive: false)).at(-1, default: none)
    let next-h = query(selector(heading).after(ini, inclusive: false)).at(0, default: none)
    let tanpa-teks(dari, ke) = query(selector(par).after(dari).before(ke, inclusive: false)).len() == 0
    let langsung-di-atas = prev-h != none and tanpa-teks(prev-h.location(), ini)
    let langsung-di-bawah = next-h != none and tanpa-teks(ini, next-h.location())
    let above = if langsung-di-atas and prev-h.level == 1 and it.level == 2 {
      jarak-h1-h2
    } else if langsung-di-atas and prev-h.level == 2 and it.level == 3 {
      jarak-h2-h3
    } else {
      1.5em + 8pt
    }
    let below = if langsung-di-bawah and it.level == 1 and next-h.level == 2 {
      jarak-h1-h2
    } else if langsung-di-bawah and it.level == 2 and next-h.level == 3 {
      jarak-h2-h3
    } else {
      1.5em
    }
    block(above: above, below: below)[#it]
  }

  // ==========================================
  // SAMPUL LUAR
  // ==========================================
  if tampilkan-sampul {
    align(center)[
      #set par(first-line-indent: 0pt, justify: false)

      #text(size: 14pt, weight: "bold")[#upper(kind)]
      #set par(leading: 0.8em)
      #text(size: 16pt, weight: "bold")[#upper(judul)]

      #v(1.5cm)
      #image("img/logo-untan.svg", width: 5.5cm)
      #v(1.5cm)

      #text(size: 12pt, weight: "bold")[
        Program Studi #prodi \
        Kajian #kajian \
        #v(1fr)
        #[#text(weight: "regular")[
          Oleh: \ #nama \
          NIM. #nim \
        ]]
      ]

      #v(1fr)

      #text(size: 14pt, weight: "bold")[
        #upper[
          #fakultas \
          #universitas \
          #kota \
          #tahun
        ]
      ]
    ]

    pagebreak()

    // ==========================================
    // SAMPUL DALAM (wm logo transparan)
    // ==========================================
    set page(
      background: place(
        center + horizon,
        box(width: 15cm)[
          #image("img/logo-untan.png", width: 15cm)
          #place(top + left, rect(width: 100%, height: 100%, fill: rgb(255, 255, 255, 90%)))
        ],
      ),
    )

    align(center)[
      #set par(first-line-indent: 0pt, justify: false)

      #text(size: 14pt, weight: "bold")[#upper(kind)]
      #[
        #set par(leading: 0.8em)
        #text(size: 16pt, weight: "bold")[#upper(judul)]
      ]

      #v(1fr)

      #set par(leading: 0.8em)
      #text(size: 12pt)[
        Untuk Memenuhi Persyaratan \
        Memperoleh Gelar Sarjana \
        \ \
        #text(weight: "bold")[
          Program Studi #prodi \
          Kajian #kajian \
        ]
        \ \
        Oleh: \
        #nama \
        NIM. #nim
      ]

      #v(1fr)

      #text(size: 14pt, weight: "bold")[
        #upper[
          #fakultas \
          #universitas \
          #kota \
          #tahun
        ]
      ]
    ]

    set page(background: none)

    pagebreak()
  }

  // ==========================================
  // LEMBAR PERSETUJUAN
  // ==========================================
  if tampilkan-persetujuan {
    pagebreak()

    align(center)[
      #set par(first-line-indent: 0pt, justify: false, leading: 0.8em)
      #text(weight: "bold")[PERSETUJUAN PEMBIMBING]
      #v(12pt)
      #text(weight: "bold")[#upper(judul)]
      #v(1.5cm)

      Tanggung Jawab Yuridis Pada:
      #v(1cm)

      #text(weight: "bold")[#nama] \
      NIM. #nim
      #v(1.5cm)

      Disetujui Oleh:
    ]

    v(1cm)

    [
      #set par(first-line-indent: 0pt)
      Dosen Pembimbing Utama
    ]

    v(2.5cm) // Area tanda tangan

    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [
        #set par(leading: 0.65em)
        #underline[#pembimbing-1.nama] \
        NIP. #pembimbing-1.nip
      ],
      [Tanggal : ...........................],
    )

    v(1.5cm)

    [
      #set par(first-line-indent: 0pt)
      Dosen Pembimbing Pendamping
    ]

    v(2.5cm) // Area tanda tangan

    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [
        #set par(leading: 0.65em)
        #underline[#pembimbing-2.nama] \
        NIP. #pembimbing-2.nip
      ],
      [Tanggal : ...........................],
    )

    pagebreak()
  }

  // ==========================================
  // HALAMAN PENGESAHAN
  // ==========================================
  if tampilkan-pengesahan {
    pagebreak()

    align(center)[
      #set par(first-line-indent: 0pt, justify: false, leading: 0.65em)
      #text(weight: "bold")[HALAMAN PENGESAHAN]

      #text(weight: "bold", size: 12pt)[#upper(judul)]
      #v(0.75em)

      Oleh: \
      *#nama* \
      NIM. #nim
      #v(0.75em)

      Dipertahankan di: \
      Pada Hari/Tanggal : #hari-tanggal-ujian \
      Waktu : #waktu-ujian \
      Tempat : #tempat-ujian
      #v(0.75em)

      *Tim Penguji*
    ]

    grid(
      columns: (1fr, 1fr),
      align: (center, center),
      [
        Ketua \
        #v(1.5cm)
        #set par(leading: 0.65em)
        #underline[#pembimbing-1.nama]\
        NIP. #pembimbing-1.nip
      ],
      [
        Sekretaris \
        #v(1.5cm)
        #set par(leading: 0.65em)
        #underline[#pembimbing-2.nama]\
        NIP. #pembimbing-2.nip
      ],
    )
    v(1cm)
    grid(
      columns: (1fr, 1fr),
      align: (center, center),
      [
        Penguji Utama \
        #v(1.5cm)
        #set par(leading: 0.65em)
        #underline[#penguji-1.nama]\
        NIP. #penguji-1.nip
      ],
      [
        Penguji Pendamping \
        #v(1.5cm)
        #set par(leading: 0.65em)
        #underline[#penguji-2.nama]\
        NIP. #penguji-2.nip
      ],
    )
    v(1cm)
    align(center)[
      #set par(first-line-indent: 0pt, leading: 0.65em)
      Disahkan Oleh: \
      Dekan FISIP Untan \
      #v(1fr)
      #set par(leading: 0.65em)
      #underline[#dekan.nama] \
      NIP. #dekan.nip
    ]
  }

  pagebreak()

  // Bagian awal berikutnya memakai angka romawi
  set page(numbering: "i", number-align: center + bottom)

  body
}

// ==========================================
// BAGIAN AWAL
// ==========================================

/// Halaman abstrak.
#let abstrak(kata-kunci: none, body) = {
  heading(level: 1)[ABSTRAK]
  [
    #set par(leading: 0.65em, first-line-indent: 0cm)
    #body

    #if kata-kunci != none [*Kata kunci:* #kata-kunci]
  ]
}

/// Halaman pernyataan keaslian, diisi otomatis dari data `skripsi(...)`.
#let pernyataan-keaslian() = context {
  let c = _config.get()

  heading(level: 1)[PERNYATAAN KEASLIAN]

  [
    #set par(first-line-indent: 0pt)
    Yang bertanda tangan di bawah ini:
  ]

  v(0.5cm)
  grid(
    columns: (4cm, 12pt, 1fr),
    row-gutter: 0.8em,
    [Nama Mahasiswa], [:], [#c.nama],
    [Nomor Mahasiswa], [:], [#c.nim],
    [Program Studi], [:], [#c.prodi],
  )

  v(0.8cm)
  [Dengan ini saya menyatakan bahwa Skripsi ini merupakan hasil karya saya sendiri dan belum pernah diajukan untuk memperoleh gelar kesarjanaan di suatu perguruan tinggi, dan sepanjang sepengetahuan saya dalam Skripsi ini tidak terdapat karya atau pendapat yang pernah ditulis atau diterbitkan oleh orang lain, kecuali yang secara tertulis diacu dalam naskah ini dan disebutkan dalam daftar pustaka.]

  v(2cm)


  align(right)[
    #set par(first-line-indent: 0pt, leading: 0.6em)
    #grid(
      columns: auto,
      row-gutter: 2cm,
      align: (_, y) => if y == 0 { left } else { center },
      [
        #c.kota, .................. #c.tahun \
        Yang membuat pernyataan,
      ],
      [
        #underline[#c.nama] \
        NIM. #c.nim
      ],
    )
  ]
}

/// Daftar isi, serta daftar tabel dan daftar gambar (hanya jika ada tabel/gambar).
#let daftar-isi() = {
  set outline(indent: auto)

  // Line break pada heading diganti spasi; BAB (level 1) tanpa nomor.
  show outline.entry: it => {
    show linebreak: [#h(0.25em)]
    let el = it.element
    let awalan = if el.func() == heading and it.level == 1 {
      none
    } else if el.func() == figure and el.kind == "lampiran" {
      numbering("1.", ..counter(figure.where(kind: "lampiran")).at(el.location()))
    } else {
      it.prefix()
    }
    link(el.location(), it.indented(awalan, it.inner()))
  }
  show outline.entry: set block(above: 1.25em, below: 1.25em)

  heading(level: 1)[DAFTAR ISI]
  {
    show outline.entry.where(level: 1): set text(weight: "bold")
    outline(title: none, target: heading)
  }

  context {
    if query(figure.where(kind: table)).len() > 0 {
      pagebreak()
      outline(title: [DAFTAR TABEL], target: figure.where(kind: table))
    }
  }

  context {
    if query(figure.where(kind: image)).len() > 0 {
      pagebreak()
      outline(title: [DAFTAR GAMBAR], target: figure.where(kind: image))
    }
  }

  context {
    if query(figure.where(kind: "lampiran")).len() > 0 {
      pagebreak()
      outline(title: [DAFTAR LAMPIRAN], target: figure.where(kind: "lampiran"))
    }
  }

  pagebreak()
}

// ==========================================
// BAGIAN INTI
// ==========================================

/// Keterangan sumber di bawah tabel atau gambar (rata kiri). Letakkan di dalam `figure`:
///
///   #figure(kind: table, caption: [Judul], [#table(..) #sumber[Data olahan penulis, 2026]])
#let sumber(body) = block(width: 100%, above: 1em)[
  #set align(left)
  #set par(first-line-indent: 0pt, justify: false, leading: 0.65em)
  Sumber: #body
]

/// Pengaturan bagian inti. Pakai dengan `#show: bagian-inti`.
/// Penomoran halaman dimulai dari 1; nomor halaman ada di kanan atas,
/// kecuali pada halaman pertama setiap BAB (di tengah bawah).
#let bagian-inti(body) = {
  pagebreak(weak: true)
  counter(page).update(1)

  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 { none } else { n.map(str).join(".") + "." }
  })

  // Tiap BAB mulai di halaman baru; nomor tabel & gambar diulang per BAB.
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    it
  }

  set figure(numbering: n => numbering("1.1", counter(heading).get().first(), n))
  set figure.caption(separator: [ ])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: top)
  show figure.caption: set par(first-line-indent: 0pt, justify: false, leading: 0.65em)
  show figure.caption: set block(below: 1em)
  show figure: set block(above: 1.5em, below: 1.5em)

  // Kutipan langsung > 5 baris: spasi tunggal, menjorok, bertanda petik
  show quote.where(block: true): it => block(
    width: 100%,
    inset: (left: 1.25cm),
    above: 1.5em,
    below: 1.5em,
  )[
    #set par(leading: 0.65em, first-line-indent: 0pt, justify: true)
    “#it.body”
  ]

  set par(
    leading: _leading-naskah,
    spacing: _leading-naskah,
    first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
    justification-limits: (tracking: (min: -0.01em, max: 0.02em)),
  )

  let halaman-bab() = {
    let current-page = here().page()
    // judul bab, daftar pustaka, dan halaman pertama tiap lampiran
    query(heading.where(level: 1).or(figure.where(kind: "lampiran")))
      .any(h => h.location().page() == current-page)
  }

  set page(
    numbering: "1",
    header: context {
      if not halaman-bab() { align(right)[#counter(page).display("1")] }
    },
    footer: context {
      if halaman-bab() { align(center)[#counter(page).display("1")] }
    },
  )

  body
}

// ==========================================
// SITASI
// ==========================================

#let cite-asli = cite

/// Kutipan dengan nama penulis di awal kalimat. Halaman opsional.
///
///   #cite("silalahi2009")[23-24]  ->  Silalahi (2009, 23-24)
#let cite(kunci, ..args) = {
  let k = if type(kunci) == str { label(kunci) } else { kunci }
  if args.named().len() > 0 {
    cite-asli(k, ..args)
  } else {
    cite-asli(k, form: "prose", supplement: args.pos().at(0, default: none))
  }
}

/// Kutipan tidak langsung di awal kalimat: penulis asli dikutip dalam karya
/// penulis lain. Halaman opsional.
///
///   #cite-dalam([Bintang], "silalahi2009")[23]
///   ->  Bintang (dalam Silalahi 2009, 23)
#let cite-dalam(nama, kunci, ..sisa) = {
  let hal = sisa.pos().at(0, default: none)
  let penulis = cite-asli(label(kunci), form: "author")
  let tahun = cite-asli(label(kunci), form: "year")
  [#nama (dalam #penulis#h(0.25em)#tahun#if hal != none [, #hal])]
}

/// Versi kurung (di akhir kalimat) dari `cite-dalam`. Halaman opsional.
///
///   #cite-dalam-kurung([Bintang], "silalahi2009")[23]
///   ->  (Bintang dalam Silalahi 2009, 23)
#let cite-dalam-kurung(nama, kunci, ..sisa) = {
  let hal = sisa.pos().at(0, default: none)
  let penulis = cite-asli(label(kunci), form: "author")
  let tahun = cite-asli(label(kunci), form: "year")
  [(#nama dalam #penulis#h(0.25em)#tahun#if hal != none [, #hal])]
}

// ==========================================
// DAFTAR PUSTAKA
// ==========================================

/// Halaman daftar pustaka. Berikan hasil `bibliography(..)` dari berkas milik Anda
/// (path relatif terhadap berkas yang memanggil), misalnya:
///
///   #daftar-pustaka(bibliography("refs.bib"))
///
/// Gaya kutipan dan daftar pustaka: Chicago author-date (sesuai panduan FISIP UNTAN).
#let daftar-pustaka(bib) = {
  pagebreak(weak: true)
  heading(level: 1)[DAFTAR PUSTAKA]
  show bibliography: set par(
    first-line-indent: 0pt,
    justify: false,
    leading: 0.65em,
    spacing: 1.25em,
  )
  bib
}

// ==========================================
// LAMPIRAN
// ==========================================

/// Satu lampiran: bernomor otomatis, mulai di halaman baru, masuk Daftar Lampiran.
///
///   #lampiran[Panduan Wawancara][ ...isi lampiran... ]
#let lampiran(judul, body) = {
  pagebreak(weak: true)
  show figure.where(kind: "lampiran"): it => block(width: 100%, above: 0pt, below: 1cm)[
    #set align(left)
    #set par(first-line-indent: 0pt, justify: false, leading: 0.65em)
    #text(weight: "bold")[
      LAMPIRAN #it.counter.display(it.numbering). #upper(it.caption.body)
    ]
  ]
  figure(
    kind: "lampiran",
    supplement: [Lampiran],
    numbering: "1",
    caption: judul,
    [],
  )
  body
}
