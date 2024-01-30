Game Bounce Ball
Tipe string;: Mendeklarasikan variabel untuk menyimpan jenis powerup.

color mycolor;: Mendeklarasikan variabel untuk menyimpan warna powerup.

boolean aktif;: Mendeklarasikan variabel untuk melacak apakah powerup sedang aktif.

ukuran float, kecepatan, durasi, waktu, xpos, ypos;: Mendeklarasikan variabel untuk ukuran, kecepatan, durasi, waktu, posisi x, dan posisi y.

int magnettime, jettime, sizetime, slowtime;: Mendeklarasikan variabel durasi magnetisme, jetpack, peningkatan ukuran, dan gerakan lambat.

int sizecheck, magnetcheck, jetcheck, slowcheck, timecheck;: Mendeklarasikan variabel untuk melacak waktu setiap penyalaan.

String[] power = {"jet pack", "size +", "slowmo", "magnet"};: Mendefinisikan array tipe powerup.

color[] powercolors = {#00ff66, #ff00ff, #006666};: Mendefinisikan array warna yang sesuai dengan setiap jenis powerup.

powerup() {: Konstruktor untuk kelas powerup.

aktif = salah;: Menginisialisasi variabel aktif ke salah.

kecepatan = 2;: Menginisialisasi variabel kecepatan ke 2.

timecheck = 0;: Menginisialisasi variabel timecheck ke 0.

randomtime();: Memanggil metode randomtime() untuk mengatur waktu acak untuk kemunculan berikutnya.

xpos = 0;: Menginisialisasi posisi x ke 0.

ypos = 300;: Menginisialisasi posisi y ke 300.

size = 25;: Menginisialisasi ukuran daya hingga 25.

type = randompower();: Memanggil metode randompower() untuk menyetel tipe acak untuk powerup.

void randomtime() {: Mendefinisikan metode randomtime().

time = second();: Menyetel waktu saat ini.

timecheck = (second() + 5 + int(random(5, 15)));: Menyetel variabel timecheck ke waktu acak di masa mendatang.

String randompower() {: Mendefinisikan metode randompower().

int a = int(random(0, 3));: Menghasilkan indeks acak untuk memilih jenis powerup.

mycolor = powercolors[a];: Mengatur warna powerup berdasarkan indeks yang dipilih.

return (powers[a]);: Mengembalikan jenis powerup yang dipilih.

boolean contact(jumper a) {: Mendefinisikan metode contact() untuk memeriksa apakah powerup menghubungi jumper.

float first = pow((a.xpos - this.xpos), 2) + pow((a.ypos - this.ypos), 2);: Menghitung jarak antara powerup dan jumper.

return (pow(first, 0.5) < (this.size + a.size) / 1.5);: Mengembalikan nilai true jika jaraknya kurang dari ukuran gabungan powerup dan jumper.

void reset() {: Mendefinisikan metode reset().

active = false;: Mereset variabel aktif menjadi false.

xpos = floor(random(0, 2)) * 800;: Menyetel posisi x ke nilai acak di sisi kiri atau kanan layar.

if (xpos > 400) { kecepatan = -1 * acak(1, 3); }: Jika powerup berada di sisi kanan, atur kecepatan ke nilai negatif.

else { kecepatan = acak(1, 3); }: Jika powerup ada di sisi kiri, atur kecepatan ke nilai positif.

type = randompower();: Memilih jenis powerup baru secara acak.

ypos = random(50, 500);: Menyetel posisi y ke nilai acak antara 50 dan 500.

randomtime();: Memanggil metode randomtime() untuk menyetel waktu acak baru untuk kemunculan berikutnya.

void update() {: Mendefinisikan metode update() untuk memperbarui powerup.

if (active == true) {: Memeriksa apakah powerup aktif.

if (contact(Stan)) {: Memeriksa apakah powerup menghubungi jumper (Stan).

Di dalam blok ini, terdapat tiga blok kondisional (jika) untuk setiap jenis powerup (ukuran +, jet pack, slowmo), menerapkan efek dan mengatur ulang powerup.

if (xpos > lebar || xpos < 0) { reset(); }: Memeriksa apakah powerup melampaui batas dan meresetnya.
