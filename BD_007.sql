CREATE TABLE Produto(
  nome VARCHAR(80),
  tipo VARCHAR(20),
  designacao_generica VARCHAR(30),
  marca VARCHAR(30),
  mercado VARCHAR(20),
  numero_identificacao INT(10),
  PRIMARY KEY (numero_identificacao)
);

CREATE TABLE Empresa(
  morada_sede VARCHAR(100),
  nif INT(9),
  capital_social INT(20),
  nome VARCHAR(80),
  PRIMARY KEY (nif)
);

CREATE TABLE Contactos_EcoFCUL(
  email VARCHAR(254),
  nome VARCHAR(80),
  telefone INT(9),
  nif INT(9),
  PRIMARY KEY (email, nif),
  FOREIGN KEY (nif) REFERENCES Empresa ON DELETE CASCADE
);

CREATE TABLE Contactos_Publicos(
  morada VARCHAR(100),
  linha_atendimento INT(9),
  email VARCHAR(254),
  nif INT(9),
  PRIMARY KEY (email, nif),
  FOREIGN KEY (nif) REFERENCES Empresa
);

CREATE TABLE Especialista(
  nacionalidade VARCHAR(20),
  telefone INT(9),
  nome VARCHAR(80),
  nif INT(9),
  senha_acesso INT(512),
  email VARCHAR(254),
  morada VARCHAR(100),
  PRIMARY KEY (nif)
);

CREATE TABLE Regista_Empresa(
  nif_especialista INT(9),
  nif_empresa INT(9),
  identificacao INT(10),
  PRIMARY KEY (identificao, nif_empresa, nif_especialista),
  FOREIGN KEY (nif_especialista) REFERENCES Especialista,
  FOREIGN KEY (nif_empresa) REFERENCES Empresa
);

CREATE TABLE Regista_Produto(
  identificacao INT(10),
  num_identificacao INT(10),
  nif INT(9),
  PRIMARY KEY (identificacao, num_identificacao, nif),
  FOREIGN KEY (nif) REFERENCES Especialista,
  FOREIGN KEY (num_identificacao) REFERENCES Produto
);
