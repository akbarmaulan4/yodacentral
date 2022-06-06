class ApiUrl {
  static String domain = 'https://yodacentral.digizone.id';
  static String domainCal = 'https://credit.yodacentral.digizone.id';
  //"https://yoda-central-app.herokuapp.com";
  // "https://ce1d-36-91-58-207.ngrok.io";

  //////daftar--masuk
  static String login = "/api/login";
  static String regis = "/api/register";
  //////end--daftar--masuk
  ///
  ///
  ///cek--status--email
  static String cekStatusEmail = "/api/register/cek-status";

  ///end--cek--status--email
  ///
  ///resend--email
  static String resendEmail = "/api/send-email";

  ///
  ///
  ///home--financing
  static String pipelineFinancing = "/api/lead/list-pipeline/Financing";

  ///end--home--financing
  ///
  ///
  ///home-refinancing
  static String pipelineRefinancing = "/api/lead/list-pipeline/Refinancing";

  ///end--home-refinancing
  ///
  ///register--biodata
  static String registerBiodata = "/api/register/biodata";

  ///end--register--biodata
  ///
  ///cekn-nomer-telepon
  static String cekNomerTlp = "/api/cek-telepon";

  ///end--cekn-nomer-telepon
  ///
  ///lead-count
  static String leadCount = "/api/lead/count";

  ///end--lead--count
  ///
  ///lead--search--financing
  static String leadSearchFinancing =
      "/api/lead/search/Financing?search=&filter=";

  //filter is [ id ] pipeline, search is text
  ///end--search--financing
  ///
  ///detail--unit-- tambah id unit after /
  static String detailUnit = "/api/lead/detail_unit/";
  static String detailNasabah = "/api/lead/nasabah/";

  ///end--detail--unit-- tambah id unit after /
  ///
  ///api wilayah
  static String prov = "/api/v1/provinsi";
  // --add id prov after /
  static String kotaKab = "/api/v1/kabupaten/";
  // --add id kotaKab after /
  static String kec = "/api/v1/kecamatan/";

  ///
  ///api cek nomer kendarann
  static String cekNomerKendaraan = "/api/lead/cek/nomor_kendaraan";
  static String getKondisi = "/api/v1/kondisi";
  static String getMerk = "/api/v1/merk";

  ///add id merk in varian after /
  static String getVariant = "/api/v1/varian/";
  static String modelMobil = "/api/v1/model/";

  ///add id merk in varian after /
  static String jarakTempuh = "/api/v1/jarak-tempuh";
  static String bahanBakar = "/api/v1/bahan-bakar";
  static String transmisi = "/api/v1/tranmisi";
  static String warna = "/api/v1/warna";

  static String setPic = '/api/lead/add-pic';
  static String tambahImage = '/api/lead/unit/edit/photo';
  static String tenor = "/api/v1/tenor";
  static String pembayaranAsuransi = "/api/v1/pembayaran-asuransi";
  static String kesertaanAsuransi = "/api/v1/kesertaan-asuransi";
  static String jenisAsuransi = "/api/v1/tipe-asuransi";
  static String nilaiTanggung = "/api/v1/nilai-pertanggungan";
  static String angsuranPertama = "/api/v1/angsuran-pertama";
  static String access = "/api/my_access";
  static String homeAccess = "/api/home_access";
  static String uploadDocKontrak = "/api/lead/kredit/edit_document/kontrak";
  static String uploadDocJaminan= "/api/lead/kredit/edit_document/jaminan";

  static String postPlayerID= "/api/admin/notification";
  static String wilayah = "/api/list/wilayah";
  static String kondisiMobil = "/api/list/kondisi-mobil";
  static String merekMobil = "/api/list/merk-mobil";
  static String model_mobil = "/api/list/model-mobil/";
  static String varianMobil = "/api/list/variant-mobil/";
  static String kategoriMobil = "/api/list/kategori-mobil";
  static String tahunMobil = "/api/list/range-tahun";
  static String statusAsuransi = "/api/list/status-asuransi";
  static String loanType = "/api/list/loan-type";
  static String tenorCal = "/api/list/tenor";
  static String jeniseMobil = "/api/list/jenis-mobil";
  static String tipeAsuransi = "/api/list/tipe-asuransi";
  static String tujuanPenggunaan = "/api/list/tujuan-kegunaan";
  static String valueOTRDefault = "/api/list/otr-default";
  static String calculateOTRDefault = "/api/credit-calculator/otr-default";
  static String calculateOTREntry = "/api/credit-calculator/otr-entry";
  static String calculateRefund = "/api/credit-calculator/total-refund";
}
