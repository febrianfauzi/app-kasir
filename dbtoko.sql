-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2021 at 03:35 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbtoko`
--

-- --------------------------------------------------------

--
-- Table structure for table `t_brg`
--

CREATE TABLE `t_brg` (
  `kd_brg` int(20) NOT NULL,
  `nm_brg` text NOT NULL,
  `jml_stok` int(4) NOT NULL,
  `hrg_beli` int(10) NOT NULL,
  `untung` int(3) NOT NULL,
  `hrg_jual` int(10) NOT NULL,
  `kd_sup` int(20) NOT NULL,
  `tgl_inp` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_hist_login`
--

CREATE TABLE `t_hist_login` (
  `tgl_login` varchar(20) NOT NULL,
  `id_user` int(20) NOT NULL,
  `jenis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_hist_login`
--

INSERT INTO `t_hist_login` (`tgl_login`, `id_user`, `jenis`) VALUES
('1624109170', 1, 'login');

-- --------------------------------------------------------

--
-- Table structure for table `t_hist_pbl`
--

CREATE TABLE `t_hist_pbl` (
  `tgl_msk_brg` date NOT NULL,
  `kd_brg` int(20) NOT NULL,
  `jml` int(4) NOT NULL,
  `kd_sup` int(20) NOT NULL,
  `hrg_beli` int(10) NOT NULL,
  `total` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_supplier`
--

CREATE TABLE `t_supplier` (
  `kd_sup` int(20) NOT NULL,
  `nm_sup` text NOT NULL,
  `almt` text NOT NULL,
  `kota` text NOT NULL,
  `tlp` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_trans`
--

CREATE TABLE `t_trans` (
  `id_trans` int(10) NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `kd_brg` int(20) NOT NULL,
  `qty` int(4) NOT NULL,
  `sub_total` int(10) NOT NULL,
  `id_user` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(20) NOT NULL,
  `nama` varchar(128) NOT NULL,
  `username` varchar(128) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `password`, `role`) VALUES
(1, 'Admin', 'admin', '$2y$10$wR.KOcfIu8VjLLyCH8UvgO0z44o6q0hAff8mB1laUbyUTEHqQCuRC', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_brg`
--
ALTER TABLE `t_brg`
  ADD PRIMARY KEY (`kd_brg`),
  ADD KEY `kd_sup` (`kd_sup`);

--
-- Indexes for table `t_hist_login`
--
ALTER TABLE `t_hist_login`
  ADD KEY `kd_pegawai` (`id_user`);

--
-- Indexes for table `t_hist_pbl`
--
ALTER TABLE `t_hist_pbl`
  ADD KEY `kd_sup` (`kd_sup`),
  ADD KEY `kd_brg` (`kd_brg`);

--
-- Indexes for table `t_supplier`
--
ALTER TABLE `t_supplier`
  ADD PRIMARY KEY (`kd_sup`);

--
-- Indexes for table `t_trans`
--
ALTER TABLE `t_trans`
  ADD PRIMARY KEY (`id_trans`),
  ADD KEY `id_pegawai` (`id_user`),
  ADD KEY `kd_brg` (`kd_brg`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_hist_login`
--
ALTER TABLE `t_hist_login`
  ADD CONSTRAINT `t_hist_login_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `t_hist_pbl`
--
ALTER TABLE `t_hist_pbl`
  ADD CONSTRAINT `t_hist_pbl_ibfk_1` FOREIGN KEY (`kd_brg`) REFERENCES `t_brg` (`kd_brg`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_hist_pbl_ibfk_2` FOREIGN KEY (`kd_sup`) REFERENCES `t_supplier` (`kd_sup`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `t_trans`
--
ALTER TABLE `t_trans`
  ADD CONSTRAINT `t_trans_ibfk_2` FOREIGN KEY (`kd_brg`) REFERENCES `t_brg` (`kd_brg`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_trans_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
