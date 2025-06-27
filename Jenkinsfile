// Jenkinsfile ini mendefinisikan pipeline CI/CD untuk aplikasi PHP.
// Pipeline ini akan mengkloning repositori, menginstal dependensi,
// menjalankan unit test, dan melakukan deployment menggunakan Docker lokal.
pipeline {
    // Menentukan agen eksekusi pipeline. 'any' berarti Jenkins akan menggunakan
    // agen mana pun yang tersedia untuk menjalankan langkah-langkah.
    agent any

    // Mendefinisikan tahapan-tahapan (stages) dalam pipeline. Setiap stage
    // merepresentasikan langkah besar dalam proses CI/CD.
    stages {
        // --- Tahap 1: Clone Repository ---
        // Tahap ini bertanggung jawab untuk mengkloning kode sumber dari repositori Git.
        stage('Clone Repository') {
            steps {
                // Perintah 'git' mengkloning repositori yang ditentukan.
                // URL repositori GitHub Anda telah dimasukkan di sini.
                // Ditambahkan 'branch: 'main'' secara eksplisit untuk memastikan kloning branch yang benar.
                git branch: 'main', url: 'https://github.com/AldoArdiansyah17/simple-php-app.git'
            }
        }

        // --- Tahap 2: Install Dependencies ---
        // Tahap ini menginstal semua dependensi proyek PHP.
        // Asumsi menggunakan Composer untuk manajemen dependensi.
        stage('Install Dependencies') {
            steps {
                script {
                    // Mendefinisikan Docker image PHP yang akan digunakan.
                    def dockerImage = 'php:8.2-fpm-alpine'

                    docker.image(dockerImage).inside {
                        // Perintah shell untuk menginstal dependensi Composer.
                        // PENTING: Jika proyek PHP Anda sangat sederhana dan tidak menggunakan Composer,
                        // Anda bisa menghapus baris sh ini atau mengomentarinya.
                        sh 'composer install --no-dev --prefer-dist'
                    }
                }
            }
        }

        // --- Tahap 3: Run Unit Tests ---
        // Tahap ini menjalankan semua unit test yang ada dalam proyek.
        // Asumsi menggunakan PHPUnit.
        stage('Run Unit Tests') {
            steps {
                script {
                    // Menggunakan Docker image yang sama atau image lain yang sesuai untuk testing.
                    def dockerImage = 'php:8.2-fpm-alpine'
                    docker.image(dockerImage).inside {
                        // Perintah shell untuk menjalankan PHPUnit.
                        // PENTING: Sesuaikan path 'vendor/bin/phpunit' jika PHPUnit Anda berada di lokasi lain.
                        // Jika Anda tidak memiliki unit test, Anda bisa menghapus baris sh ini atau mengomentarinya.
                        sh 'vendor/bin/phpunit'
                    }
                }
            }
            // Bagian 'post' mendefinisikan tindakan yang akan diambil setelah tahap ini selesai,
            // baik berhasil ('success') maupun gagal ('failure').
            post {
                success {
                    echo 'Tes PHP berhasil!'
                }
                failure {
                    echo 'Tes PHP gagal!'
                }
            }
        }

        // --- Tahap 4: Deploy Application using Local Docker Image ---
        // Tahap ini membangun Docker image aplikasi dan menjalankannya sebagai container.
        stage('Deploy') {
            steps {
                script {
                    // Mendefinisikan nama dan tag untuk Docker image aplikasi Anda.
                    def imageName = "my-php-app:latest"

                    // Perintah shell untuk membangun Docker image.
                    // Asumsi ada 'Dockerfile' di root repositori Anda.
                    sh "docker build -t ${imageName} ."

                    // Menghentikan dan menghapus container yang berjalan sebelumnya dengan nama yang sama,
                    // untuk memastikan deployment bersih setiap kali.
                    sh "docker stop my-php-app-container || true"
                    sh "docker rm my-php-app-container || true"

                    // Perintah shell untuk menjalankan Docker container dari image yang baru dibuat.
                    sh "docker run -d --name my-php-app-container -p 80:80 ${imageName}"

                    echo "Aplikasi PHP telah berhasil di-deploy menggunakan image Docker lokal: ${imageName}!"
                    echo "Anda dapat mengakses aplikasi di http://localhost:80 jika container dijalankan di host yang sama."
                }
            }
        }
    }
}
