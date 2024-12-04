-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Des 2024 pada 12.15
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pokemon`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bids`
--

CREATE TABLE `bids` (
  `id` int(11) NOT NULL,
  `card_name` varchar(100) NOT NULL,
  `bid_price` decimal(10,2) NOT NULL,
  `status` enum('open','next bid','buy it now') NOT NULL DEFAULT 'open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `bids`
--

INSERT INTO `bids` (`id`, `card_name`, `bid_price`, `status`) VALUES
(5, 'Pikachu Vmax', 1515.00, 'open'),
(13, 'gg', 1111.00, 'open'),
(15, 'a', 1.00, 'open');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cards`
--

CREATE TABLE `cards` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `rarity` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `cards`
--

INSERT INTO `cards` (`id`, `name`, `type`, `rarity`, `description`, `price`) VALUES
(1, 'Pikachu', 'Electric', 'Rare', 'Pikachu is an Electric-type Pokémon.', 1500.00),
(26, 'a', 'a', 'a', 'a', 1.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `profiles`
--

INSERT INTO `profiles` (`id`, `name`, `email`, `password`) VALUES
(1, 'ash_ketchum', 'ash@pokemon.com', 'pikachu123'),
(58, 'jason', 'jason@gmail.com', '$2y$10$LFwHiJoTZ97Nx5yKSPMhxeFYUsr4CbcAYJ6YHpO.LA/7B85KX3Kce'),
(59, 'daniel', 'daniel@gmail.com', '$2y$10$YRddTFINppsAZmZe9GgdCOWPqwQO/q87GrkTxw2GEykmbK/t6XhPm'),
(60, 'faren', 'far@gmail.com', '$2y$10$UX7w/WHSy32N3/9nZuo2t./NSaV64OydECFvv/mlvT5R9vAyhVT5W');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
