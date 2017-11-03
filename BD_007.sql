CREATE TABLE Especialista(
  nacionalidade VARCHAR(20),
  telefone INT(9),
  nome VARCHAR(80),
  nif INT(9),
  senha_acesso INT(254),
  email VARCHAR(254),
  morada VARCHAR(100),
  PRIMARY KEY (nif)
);

CREATE TABLE Produto(
  nome VARCHAR(80),
  tipo VARCHAR(20),
  designacao_generica VARCHAR(30),
  marca VARCHAR(30),
  mercado VARCHAR(20),
  numero_identificacao INT(10),
  nif_especialista INT(9),
  FOREIGN KEY (nif_especialista) REFERENCES Especialista(nif),
  PRIMARY KEY (numero_identificacao)
);

CREATE TABLE Empresa(
  morada_sede VARCHAR(100),
  nif INT(9),
  capital_social INT(20),
  nome VARCHAR(80),
  nif_especialista INT(9),
  FOREIGN KEY (nif_especialista) REFERENCES Especialista(nif),
  PRIMARY KEY (nif)
);

CREATE TABLE Contactos_EcoFCUL(
  email VARCHAR(254),
  nome VARCHAR(80),
  telefone INT(9),
  nif INT(9),
  FOREIGN KEY (nif) REFERENCES Empresa(nif) ON DELETE CASCADE,
  PRIMARY KEY (email, nif)
);


CREATE TABLE Contactos_Publicos(
  morada VARCHAR(100),
  linha_atendimento INT(9),
  email VARCHAR(254),
  nif INT(9),
  FOREIGN KEY (nif) REFERENCES Empresa(nif),
  PRIMARY KEY (email, nif)
);

CREATE TABLE Tem_contactos_publicos(
  nif_empresa INT(9),
  email VARCHAR(254),
  FOREIGN KEY (nif_empresa) REFERENCES Empresa(nif),
  PRIMARY KEY (nif_empresa, email)
);

CREATE TABLE Consumidor(
  email VARCHAR(254),
  senha_acesso INT(254),
  sexo VARCHAR(1),
  PRIMARY KEY (email)
);

CREATE TABLE Elemento_do_agregado_familiar(
  nif INT(9),
  data_de_nascimento DATE,
  email VARCHAR(254),
  FOREIGN KEY (email) REFERENCES Consumidor(email) ON DELETE CASCADE,
  PRIMARY KEY (nif)
);

CREATE TABLE Riscos_de_saude(
  valor INT(3),
  texto_explicativo VARCHAR(254),
  numero_identificacao INT(10),
  PRIMARY KEY (numero_identificacao)
);

CREATE TABLE Pegada_ecologica(
  valor INT(3),
  texto_explicativo VARCHAR(254),
  numero_identificacao INT(10),
  PRIMARY KEY (numero_identificacao)
);

CREATE TABLE Defesa_dos_direitos_humanos(
  valor INT(3),
  texto_explicativo VARCHAR(254),
  numero_identificacao INT(10),
  PRIMARY KEY (numero_identificacao)
);

CREATE TABLE Elemento(
  nome VARCHAR(100),
  numero_identificacao INT(10),
  numero_identificacao_riscos_saude INT(10),
  numero_identificacao_pegada_ecologica INT(10),
  numero_identificacao_defesa_direitos_humanos INT(10),
  FOREIGN KEY (numero_identificacao_riscos_saude) REFERENCES Riscos_de_saude(numero_identificacao),
  FOREIGN KEY (numero_identificacao_pegada_ecologica) REFERENCES Pegada_ecologica(numero_identificacao),
  FOREIGN KEY (numero_identificacao_defesa_direitos_humanos) REFERENCES Defesa_dos_direitos_humanos(numero_identificacao),
  PRIMARY KEY (numero_identificacao)
);

CREATE TABLE Composto_por(
  percentagem DECIMAL(3,2),
  numero_identificacao_produto INT(10),
  numero_identificacao_elemento INT(10),
  FOREIGN KEY (numero_identificacao_elemento) REFERENCES Elemento(numero_identificacao),
  FOREIGN KEY (numero_identificacao_produto) REFERENCES Produto(numero_identificacao),
  PRIMARY KEY (numero_identificacao_produto, numero_identificacao_elemento),
  CHECK (percentagem>000.00 AND percentagem < 100.00)
);

CREATE TABLE Artigo_cientifico(
  id INT(10),
  autor VARCHAR(40),
  titulo VARCHAR(30),
  editora VARCHAR(30),
  data_publicacao DATE,
  PRIMARY KEY (id)
);

CREATE TABLE Referencia_RS(
  riscos_de_saude INT(10),
  artigo_cientifico INT(10),
  FOREIGN KEY (riscos_de_saude) REFERENCES Riscos_de_saude(numero_identificacao),
  FOREIGN KEY (artigo_cientifico) REFERENCES Artigo_cientifico(id),
  PRIMARY KEY (riscos_de_saude,artigo_cientifico)
);

CREATE TABLE Referencia_PE(
  pegada_ecologica INT(10),
  artigo_cientifico INT(10),
  FOREIGN KEY (pegada_ecologica) REFERENCES Pegada_ecologica(numero_identificacao),
  FOREIGN KEY (artigo_cientifico) REFERENCES Artigo_cientifico(id),
  PRIMARY KEY (pegada_ecologica,artigo_cientifico)
);

CREATE TABLE Referencia_DdH(
  defesa_dos_direitos_humanos INT(10),
  artigo_cientifico INT(10),
  FOREIGN KEY (defesa_dos_direitos_humanos) REFERENCES Defesa_dos_direitos_humanos(numero_identificacao),
  FOREIGN KEY (artigo_cientifico) REFERENCES Artigo_cientifico(id),
  PRIMARY KEY (defesa_dos_direitos_humanos,artigo_cientifico)
);

