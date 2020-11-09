CREATE TABLE `cidade` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Estado` varchar(45) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  UNIQUE KEY `Estado_UNIQUE` (`Estado`),
  UNIQUE KEY `UF_UNIQUE` (`UF`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

CREATE TABLE `cliente` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) DEFAULT NULL,
  `Cidade` varchar(45) DEFAULT NULL,
  `UF` int DEFAULT NULL,
  UNIQUE KEY `Nome_UNIQUE` (`Nome`),
  KEY `fk_cidade_idx` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

CREATE TABLE `pedido` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `CodigoCliente` int NOT NULL,
  `DataHora` datetime DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_cliente_idx` (`CodigoCliente`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`CodigoCliente`) REFERENCES `cliente` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

CREATE TABLE `pedido_item` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `CodigoPedido` int NOT NULL,
  `CodigoProduto` int NOT NULL,
  `Quantidade` int NOT NULL DEFAULT '1',
  `PrecoUnitario` decimal(8,2) DEFAULT '0.00',
  PRIMARY KEY (`Codigo`),
  KEY `fk_pedido_idx` (`CodigoPedido`),
  KEY `fk_produto_idx` (`CodigoProduto`),
  CONSTRAINT `fk_pedido` FOREIGN KEY (`CodigoPedido`) REFERENCES `pedido` (`Codigo`),
  CONSTRAINT `fk_produto` FOREIGN KEY (`CodigoProduto`) REFERENCES `produto` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `produto` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(80) NOT NULL,
  `Preco` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  UNIQUE KEY `Descricao_UNIQUE` (`Descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
