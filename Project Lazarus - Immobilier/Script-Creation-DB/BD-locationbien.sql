-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
-- Billy - Project Immobilier - Location Bien
-- Hôte : 127.0.0.1
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `locationbien`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_prix` (IN `numerobien` INT(10), IN `prix_change` INT(10))  NO SQL BEGIN
    UPDATE bien SET prix = prix_change WHERE bien_id = numerobien;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `bien`
--

CREATE TABLE `bien` (
  `bien_id` int(10) NOT NULL,
  `id_proprio` int(10) NOT NULL,
  `genre` enum('Appartement','Maison') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lieu` varchar(20) NOT NULL,
  `prix` float NOT NULL,
  `superficie` int(11) NOT NULL,
  `actif` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `bien`
--

INSERT INTO `bien` (`bien_id`, `id_proprio`, `genre`, `lieu`, `prix`, `superficie`, `actif`) VALUES
(1, 1, 'Maison', 'Ixelles', 1000, 200, 1),
(2, 2, 'Appartement', 'Ixelles', 782, 70, 1),
(3, 3, 'Appartement', 'Mons', 500, 60, 1),
(4, 4, 'Maison', 'Namur', 2336, 100, 1),
(5, 5, 'Appartement', 'Liege', 1200, 80, 1),
(6, 6, 'Appartement', 'Charleroi', 600, 75, 1),
(7, 7, 'Maison', 'Tournai', 2500, 300, 1),
(8, 8, 'Maison', 'Waterloo', 88, 150, 1),
(9, 9, 'Maison', 'Uccle', 3000, 350, 1),
(10, 10, 'Maison', 'Woluwe', 1800, 120, 0),
(11, 2, 'Maison', 'Anvers', 1350, 98, 0),
(12, 4, 'Appartement', 'Forest', 2785, 55, 0),
(13, 5, 'Appartement', 'Namur', 600, 70, 1),
(14, 10, 'Maison', 'Anvers', 900, 100, 1),
(15, 11, 'Maison', 'Mons', 4433, 43, 1),
(16, 14, 'Appartement', 'Bruxelles', 2399, 13, 1),
(17, 12, 'Maison', 'Ixelles', 7865, 674, 1),
(18, 13, 'Maison', 'Waterloo', 5444, 400, 1),
(19, 15, 'Maison', 'Uccle', 12999, 183, 1),
(20, 16, 'Appartement', 'Liege', 75000, 388, 1);

-- --------------------------------------------------------

--
-- Structure de la table `locataire`
--

CREATE TABLE `locataire` (
  `locataire_id` int(10) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `annee_naissance` int(4) NOT NULL,
  `telephone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `locataire`
--

INSERT INTO `locataire` (`locataire_id`, `nom`, `prenom`, `annee_naissance`, `telephone`) VALUES
(1, 'lolo', 'bilal', 1996, '0487853384'),
(2, 'Tom', 'Roland', 1970, '0432547896'),
(3, 'Dimitri', 'maximus', 1985, '0458796321'),
(4, 'Legrand', 'Louis', 2001, '0458796321'),
(5, 'Daoud', 'tarik', 1980, '0456321789'),
(6, 'Dubois', 'Jordy', 1990, '0478963214'),
(7, 'Rosmarie', 'Maria', 1990, '0478963214'),
(8, 'Itshuna', 'Patrick', 1996, '0478963258'),
(9, 'Vandooren', 'Frederic', 1970, '0478963269'),
(10, 'Sally', 'Marouane', 1980, '0478963215');

-- --------------------------------------------------------

--
-- Structure de la table `location`
--

CREATE TABLE `location` (
  `location_id` int(10) NOT NULL,
  `id_bien` int(10) NOT NULL,
  `id_locataire` int(10) NOT NULL,
  `date_loc` date NOT NULL,
  `actif` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `location`
--

INSERT INTO `location` (`location_id`, `id_bien`, `id_locataire`, `date_loc`, `actif`) VALUES
(1, 1, 1, '2023-03-05', 1),
(2, 2, 2, '2023-04-05', 1),
(3, 3, 3, '2023-05-05', 1),
(4, 4, 4, '2023-06-05', 1),
(5, 5, 5, '2023-07-05', 1),
(6, 6, 6, '2023-02-01', 1),
(7, 7, 7, '2023-01-03', 1),
(8, 8, 8, '2023-10-07', 1),
(9, 9, 9, '2023-11-07', 0),
(10, 10, 10, '2023-12-15', 0);

-- --------------------------------------------------------

--
-- Structure de la table `proprio`
--

CREATE TABLE `proprio` (
  `proprio_id` int(10) NOT NULL,
  `nom` varchar(15) NOT NULL,
  `prenom` varchar(15) NOT NULL,
  `domicile` varchar(20) NOT NULL,
  `annee_naissance` int(4) NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `proprio`
--

INSERT INTO `proprio` (`proprio_id`, `nom`, `prenom`, `domicile`, `annee_naissance`, `actif`) VALUES
(1, 'Dominique', 'Patrick', 'Bruxelles', 1990, 1),
(2, 'Barbare', 'Marie', 'Uccle', 1970, 1),
(3, 'Sarah', 'Laura', 'Liege', 1975, 1),
(4, 'Cedryc', 'Marc', 'Bruxelles', 2000, 1),
(5, 'Lorien', 'Maxime', 'Mons', 1960, 1),
(6, 'Dorien', 'Lux', 'Wavre', 1982, 1),
(7, 'Dumoulin', 'Tom', 'Bruxelles', 1992, 1),
(8, 'Anna', 'Patricia', 'Etterbeek', 2005, 1),
(9, 'Maelle', 'laurie', 'Woluwe', 2001, 1),
(10, 'Maro', 'louis', 'Waterloo', 1970, 1),
(11, 'Billy', 'Costigan', 'Forest', 1995, 1),
(12, 'Nicolas', 'Sarkozizi', 'Anderlecht', 1997, 1),
(13, 'Marc', 'Destory', 'Ever', 1998, 1),
(14, 'Toto', 'Elgrandé', 'Forest', 1993, 1),
(15, 'Elpepito', 'Paccino', 'Anderlecht', 2000, 1),
(16, 'Bruno', 'Da Silva', 'Anvers', 1996, 1),
(17, 'Harsen', 'Lupin', 'Woluwé', 1993, 1),
(18, 'Harrley', 'Davidson', 'Mons', 1992, 1),
(19, 'Gege', 'DeparDieu', 'Waterloo', 1943, 1),
(20, 'Jean-Mi', 'Trognieux', 'Anvers', 1994, 1),
(21, 'Bob', 'Sull', 'Bruxelles', 1995, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `bien`
--
ALTER TABLE `bien`
  ADD PRIMARY KEY (`bien_id`),
  ADD KEY `fk_bien_proprio` (`id_proprio`);

--
-- Index pour la table `locataire`
--
ALTER TABLE `locataire`
  ADD PRIMARY KEY (`locataire_id`);

--
-- Index pour la table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `fk_location_bien` (`id_bien`),
  ADD KEY `fk_location_locataire` (`id_locataire`);

--
-- Index pour la table `proprio`
--
ALTER TABLE `proprio`
  ADD PRIMARY KEY (`proprio_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `bien`
--
ALTER TABLE `bien`
  MODIFY `bien_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `locataire`
--
ALTER TABLE `locataire`
  MODIFY `locataire_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `proprio`
--
ALTER TABLE `proprio`
  MODIFY `proprio_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `bien`
--
ALTER TABLE `bien`
  ADD CONSTRAINT `fk_bien_proprio` FOREIGN KEY (`id_proprio`) REFERENCES `proprio` (`proprio_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locataire` (`locataire_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
