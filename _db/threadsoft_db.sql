-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Tempo de geração: 02/12/2016 às 18:49
-- Versão do servidor: 5.7.11-log
-- Versão do PHP: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `threadsoft_db`
--
CREATE DATABASE IF NOT EXISTS `threadsoft_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `threadsoft_db`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categories`
--

CREATE TABLE `categories` (
  `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de categorias.',
  `category` varchar(45) NOT NULL COMMENT 'Tabela destinada a registrar as categorias do produtos.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela destinada a registrar as categorias do produto.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `checks`
--

CREATE TABLE `checks` (
  `id` int(4) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de cheques.',
  `sellers_id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de vendedor relativo ao cheque.',
  `number` varchar(30) NOT NULL COMMENT 'Número do cheque.',
  `value` decimal(6,2) UNSIGNED NOT NULL COMMENT 'Valor contido no cheque.',
  `date_receipt` date NOT NULL COMMENT 'Data de recebimento do cheque.',
  `status` tinyint(1) NOT NULL COMMENT 'Status do cheque. Se foi descontado, ou ocorreu falha no desconto.',
  `date_good_for` date DEFAULT NULL COMMENT 'Data boa para o desconto do cheque.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena os cheques relativos aos vendedores.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `cities`
--

CREATE TABLE `cities` (
  `id` tinyint(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de cidade.',
  `states_id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de estado onde a cidade se localiza.',
  `name` varchar(45) NOT NULL COMMENT 'Nome de cidade.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena as cidades relativas aos estados.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `entries`
--

CREATE TABLE `entries` (
  `id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de estrada.',
  `sellers_id` int(3) UNSIGNED ZEROFILL DEFAULT NULL COMMENT 'Identificador único de vendedor, pode ser nulo pois só é usado em caso de devolução.',
  `date` date NOT NULL COMMENT 'Data de entrada.',
  `hour` time NOT NULL COMMENT 'Hora de entrada.',
  `type` char(1) NOT NULL COMMENT 'Tipo de entrada [produto novo, devolução ou reposição].'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena as entradas de produtos no estoque.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `entries_has_products_has_sizes`
--

CREATE TABLE `entries_has_products_has_sizes` (
  `id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de entradas que tem produtos com tamanhos.',
  `entries_id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de entradas.',
  `products_has_sizes_id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de produtos com tamanhos.',
  `quantity` smallint(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produtos contidos na entrada.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que vincula os produtos de cada tamanho com as estradas no estoque.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `inventories`
--

CREATE TABLE `inventories` (
  `id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único para estoque.',
  `products_has_sizes_id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Tamanho do produo que está no estoque.',
  `quantity` smallint(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produto por tamanho.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela destinada a armazenar a quantidade de cada produto por tamanho no estoque.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `manufacturers`
--

CREATE TABLE `manufacturers` (
  `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de fabricante.',
  `name` varchar(45) NOT NULL COMMENT 'Nome fantasia de fabricante.',
  `phone` bigint(20) UNSIGNED NOT NULL COMMENT 'Telefone de contato de fabricante.',
  `email` varchar(100) NOT NULL COMMENT 'E-mail de contato de fabricante.',
  `cnpj` bigint(18) UNSIGNED ZEROFILL NOT NULL COMMENT 'CNPJ de fabricante.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena os faricantes dos produtos.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `products`
--

CREATE TABLE `products` (
  `id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de produto.',
  `categories_id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Categoria de produto.',
  `manufacturers_id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de fabricante.',
  `code` int(3) NOT NULL COMMENT 'Código de produto.',
  `model` varchar(45) NOT NULL COMMENT 'Modelo de produto.',
  `sex` tinyint(1) NOT NULL COMMENT 'Sexo do produto.',
  `price` decimal(5,2) UNSIGNED NOT NULL COMMENT 'Preço de produto.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena os produtos.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `products_has_sizes`
--

CREATE TABLE `products_has_sizes` (
  `id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de produto com tamanho.',
  `products_id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de produto.',
  `sizes_id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de tamanho.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que vincula os produtos com os seus devidos tamanhos.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `removals`
--

CREATE TABLE `removals` (
  `id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de saída.',
  `sellers_id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de vendedor que recebe os itens da saída. Esse campo pode ser nulo, pois o tipo de saída pode ser de reparo',
  `date` date NOT NULL COMMENT 'Data de saída.',
  `hour` time NOT NULL COMMENT 'Hora de saída.',
  `type` char(1) NOT NULL COMMENT 'Tipo da saída.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena as saídas de produtos do estoque.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `removals_has_products_has_sizes`
--

CREATE TABLE `removals_has_products_has_sizes` (
  `id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de saída que tem produtos com tamanhos.',
  `removals_id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificado de saída.',
  `products_has_sizes_id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de produto com tamnho.',
  `quantity` smallint(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produtos contidos na saída.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que vincula os produtos de cada tamanho com as saídas do estoque.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `repairs`
--

CREATE TABLE `repairs` (
  `id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de saída reparo.',
  `removals_has_products_has_sizes_id` int(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de saída que tem produtos com tamanhos.',
  `entries_id` int(5) UNSIGNED ZEROFILL DEFAULT NULL COMMENT 'Identificador de entrada de produto.',
  `date` date NOT NULL COMMENT 'Data de saída de reparo.',
  `hour` time NOT NULL COMMENT 'Hora de saída de reparo.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena as saída de produtos para reparo em seus respectivos fabricantes.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `sellers`
--

CREATE TABLE `sellers` (
  `id` int(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de vendedor.',
  `cities_id` tinyint(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de cidade onde o vendedor atua.',
  `name` varchar(45) NOT NULL COMMENT 'Nome do vendedor.',
  `email` varchar(100) NOT NULL COMMENT 'E-mail de vendedor.',
  `phone` bigint(20) NOT NULL COMMENT 'Telefone de vendedor.',
  `birth_date` date NOT NULL COMMENT 'Data de nascimento do vendedor.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena os vededores.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `sizes`
--

CREATE TABLE `sizes` (
  `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único para tamanho.',
  `size` varchar(10) NOT NULL COMMENT 'Campo destinado a registrar o tamanho dos produtos.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela destinada a armazenar o tamanho do produto.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `states`
--

CREATE TABLE `states` (
  `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador único de estado.',
  `name` varchar(45) NOT NULL COMMENT 'Nome de estado.',
  `initials` char(2) NOT NULL COMMENT 'Sigla, ou iniciais, de estado.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que armazena os estados.';

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Este campo serve como identificador único para usuário.',
  `username` varchar(20) NOT NULL COMMENT 'Este campo é destinado a armazenar o nome de usuário.',
  `password` char(32) NOT NULL COMMENT 'Este campo é a armazenar a senha para o usuário.',
  `email` varchar(100) NOT NULL COMMENT 'Este campo é destinado a armazanar o e-mail do usuário.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esta tabela armazena todos os usuários do software.';

--
-- Fazendo dump de dados para tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES
(01, 'admin', 'admin', 'exemplo@dominio.com');

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_UNIQUE` (`category`);

--
-- Índices de tabela `checks`
--
ALTER TABLE `checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_checks_sellers1_idx` (`sellers_id`);

--
-- Índices de tabela `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cities_states1_idx` (`states_id`);

--
-- Índices de tabela `entries`
--
ALTER TABLE `entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_entries_sellers1_idx` (`sellers_id`);

--
-- Índices de tabela `entries_has_products_has_sizes`
--
ALTER TABLE `entries_has_products_has_sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_entries_has_products_has_sizes_products_has_sizes1_idx` (`products_has_sizes_id`),
  ADD KEY `fk_entries_has_products_has_sizes_entries1_idx` (`entries_id`);

--
-- Índices de tabela `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_inventories_products_has_sizes1_idx` (`products_has_sizes_id`);

--
-- Índices de tabela `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`),
  ADD UNIQUE KEY `e_mail_UNIQUE` (`email`),
  ADD UNIQUE KEY `cnpj_UNIQUE` (`cnpj`);

--
-- Índices de tabela `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`),
  ADD KEY `fk_products_categories1_idx` (`categories_id`),
  ADD KEY `fk_products_manufacturers1_idx` (`manufacturers_id`);

--
-- Índices de tabela `products_has_sizes`
--
ALTER TABLE `products_has_sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_products_has_sizes_sizes1_idx` (`sizes_id`),
  ADD KEY `fk_products_has_sizes_products_idx` (`products_id`);

--
-- Índices de tabela `removals`
--
ALTER TABLE `removals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_removals_sellers1_idx` (`sellers_id`);

--
-- Índices de tabela `removals_has_products_has_sizes`
--
ALTER TABLE `removals_has_products_has_sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_removals_has_products_has_sizes_products_has_sizes1_idx` (`products_has_sizes_id`),
  ADD KEY `fk_removals_has_products_has_sizes_removals1_idx` (`removals_id`);

--
-- Índices de tabela `repairs`
--
ALTER TABLE `repairs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_repairs_removals_has_products_has_sizes1_idx` (`removals_has_products_has_sizes_id`),
  ADD KEY `fk_repairs_entries1_idx` (`entries_id`);

--
-- Índices de tabela `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `e_mail_UNIQUE` (`email`),
  ADD UNIQUE KEY `phone_UNIQUE` (`phone`),
  ADD KEY `fk_sellers_cities1_idx` (`cities_id`);

--
-- Índices de tabela `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `size_UNIQUE` (`size`);

--
-- Índices de tabela `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`),
  ADD UNIQUE KEY `initials_UNIQUE` (`initials`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `e_mail_UNIQUE` (`email`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `categories`
--
ALTER TABLE `categories`
  MODIFY `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de categorias.';
--
-- AUTO_INCREMENT de tabela `checks`
--
ALTER TABLE `checks`
  MODIFY `id` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de cheques.';
--
-- AUTO_INCREMENT de tabela `cities`
--
ALTER TABLE `cities`
  MODIFY `id` tinyint(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de cidade.';
--
-- AUTO_INCREMENT de tabela `entries`
--
ALTER TABLE `entries`
  MODIFY `id` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de estrada.';
--
-- AUTO_INCREMENT de tabela `entries_has_products_has_sizes`
--
ALTER TABLE `entries_has_products_has_sizes`
  MODIFY `id` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de entradas que tem produtos com tamanhos.';
--
-- AUTO_INCREMENT de tabela `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para estoque.';
--
-- AUTO_INCREMENT de tabela `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de fabricante.';
--
-- AUTO_INCREMENT de tabela `products`
--
ALTER TABLE `products`
  MODIFY `id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de produto.';
--
-- AUTO_INCREMENT de tabela `products_has_sizes`
--
ALTER TABLE `products_has_sizes`
  MODIFY `id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de produto com tamanho.';
--
-- AUTO_INCREMENT de tabela `removals`
--
ALTER TABLE `removals`
  MODIFY `id` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de saída.';
--
-- AUTO_INCREMENT de tabela `removals_has_products_has_sizes`
--
ALTER TABLE `removals_has_products_has_sizes`
  MODIFY `id` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de saída que tem produtos com tamanhos.';
--
-- AUTO_INCREMENT de tabela `repairs`
--
ALTER TABLE `repairs`
  MODIFY `id` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de saída reparo.';
--
-- AUTO_INCREMENT de tabela `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de vendedor.';
--
-- AUTO_INCREMENT de tabela `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para tamanho.';
--
-- AUTO_INCREMENT de tabela `states`
--
ALTER TABLE `states`
  MODIFY `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de estado.';
--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Este campo serve como identificador único para usuário.', AUTO_INCREMENT=2;
--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `checks`
--
ALTER TABLE `checks`
  ADD CONSTRAINT `fk_checks_sellers1` FOREIGN KEY (`sellers_id`) REFERENCES `sellers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `fk_cities_states1` FOREIGN KEY (`states_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `entries`
--
ALTER TABLE `entries`
  ADD CONSTRAINT `fk_entries_sellers1` FOREIGN KEY (`sellers_id`) REFERENCES `sellers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `entries_has_products_has_sizes`
--
ALTER TABLE `entries_has_products_has_sizes`
  ADD CONSTRAINT `fk_entries_has_products_has_sizes_entries1` FOREIGN KEY (`entries_id`) REFERENCES `entries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entries_has_products_has_sizes_products_has_sizes1` FOREIGN KEY (`products_has_sizes_id`) REFERENCES `products_has_sizes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `inventories`
--
ALTER TABLE `inventories`
  ADD CONSTRAINT `fk_inventories_products_has_sizes1` FOREIGN KEY (`products_has_sizes_id`) REFERENCES `products_has_sizes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_products_manufacturers1` FOREIGN KEY (`manufacturers_id`) REFERENCES `manufacturers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `products_has_sizes`
--
ALTER TABLE `products_has_sizes`
  ADD CONSTRAINT `fk_products_has_sizes_products` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_products_has_sizes_sizes1` FOREIGN KEY (`sizes_id`) REFERENCES `sizes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `removals`
--
ALTER TABLE `removals`
  ADD CONSTRAINT `fk_removals_sellers1` FOREIGN KEY (`sellers_id`) REFERENCES `sellers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `removals_has_products_has_sizes`
--
ALTER TABLE `removals_has_products_has_sizes`
  ADD CONSTRAINT `fk_removals_has_products_has_sizes_products_has_sizes1` FOREIGN KEY (`products_has_sizes_id`) REFERENCES `products_has_sizes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_removals_has_products_has_sizes_removals1` FOREIGN KEY (`removals_id`) REFERENCES `removals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `repairs`
--
ALTER TABLE `repairs`
  ADD CONSTRAINT `fk_repairs_entries1` FOREIGN KEY (`entries_id`) REFERENCES `entries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_repairs_removals_has_products_has_sizes1` FOREIGN KEY (`removals_has_products_has_sizes_id`) REFERENCES `removals_has_products_has_sizes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `sellers`
--
ALTER TABLE `sellers`
  ADD CONSTRAINT `fk_sellers_cities1` FOREIGN KEY (`cities_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
