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
  PRIMARY KEY (email)
);


CREATE TABLE Contactos_Publicos(
  morada VARCHAR(100),
  linha_atendimento INT(9),
  email VARCHAR(254),
  nif INT(9),
  FOREIGN KEY (nif) REFERENCES Empresa(nif) ON DELETE CASCADE,
  PRIMARY KEY (email, nif)
);

CREATE TABLE Tem_contactos_ecofcul(
  nif_empresa INT(9),
  email VARCHAR(254),
  FOREIGN KEY (nif_empresa) REFERENCES Empresa(nif),
  FOREIGN KEY (email) REFERENCES Contactos_EcoFCUL(email),
  PRIMARY KEY (nif_empresa, email)
);

CREATE TABLE Consumidor(
  email VARCHAR(254),
  senha_acesso INT(254),
  sexo VARCHAR(1),
  PRIMARY KEY (email),
  CHECK (sexo="M" OR sexo="F")
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

--ESPECIALISTAS
INSERT INTO Especialista (nacionalidade, telefone, nome, nif, senha_acesso, email, morada) VALUES ('Portuguesa', 918726345, 'Alberto Ferreira', 255364788, 'AF3rr31r4', 'albferrspecialist@gmail.com', 'Rua Domingos Paciência, nr 20');
INSERT INTO Especialista (nacionalidade, telefone, nome, nif, senha_acesso, email, morada) VALUES ('Belga', 969837456, 'Kevin Hazard', 234830248, 'H4z4rDou$', 'specialisthazard@gmail.com', 'Rue de Mérode, nr 184');
--END

--PRODUTO
INSERT INTO Produto (nome, tipo, designacao_generica, marca, mercado, numero_identificacao, nif_especialista) VALUES ('Bolachas belgas', 'comida','Bolachas belgas','Belgas','Retalhista', 234, 234830248);
INSERT INTO Produto (nome, tipo, designacao_generica, marca, mercado, numero_identificacao, nif_especialista) VALUES ('Pneus Pirelli', 'Material de carros','Pneus Pirelli','Pirelli','Retalhista', 320, 255364788);
--END

--EMPRESA
INSERT INTO Empresa (morada_sede, nif, capital_social, nome, nif_especialista) VALUES ('Rua António Boto, nr 32', 132654789, 30000000000,'Pirelli Enterprises', 255364788);
INSERT INTO Empresa (morada_sede, nif, capital_social, nome, nif_especialista) VALUES ('Rue Delwart, nr 107', 243765890, 90000000,'Belgas Company', 234830248);
--END

--CONTACTOS ECOFCUL
INSERT INTO Contactos_EcoFCUL (email, nome, telefone) VALUES ('belgascomp@ecofcul.ul.pt','BelgasCompany',216734984);
INSERT INTO Contactos_EcoFCUL (email, nome, telefone) VALUES ('pirellienterprises@ecofcul.ul.pt','Pirelli Enterprises',217845095);
--END

--CONTACTOS PUBLICOS
INSERT INTO Contactos_Publicos (morada, linha_atendimento, email, nif) VALUES ('Rua António Boto, nr 32',215687098,'pirellienterprises@gmail.com',132654789);
INSERT INTO Contactos_Publicos (morada, linha_atendimento, email, nif) VALUES ('Rue Delwart, nr 107', 213048707, 'belgascomp@gmail.com',243765890);
--END

--TEM CONTACTOS ECOFCUL
INSERT INTO Tem_contactos_ecofcul (nif_empresa,email) VALUES (243765890,'belgascomp@ecofcul.ul.pt');
INSERT INTO Tem_contactos_ecofcul (nif_empresa,email) VALUES (132654789,'pirellienterprises@gmail.com');
--END

--CONSUMIDOR
INSERT INTO Consumidor (email,senha_acesso,sexo) VALUES ('gbis@gmail.com','gb1$','M');
INSERT INTO Consumidor (email,senha_acesso,sexo) VALUES ('acsc@gmail.com','4C$c','F');
--END

--ELEMENTO DO AGREGADO FAMILIAR
INSERT INTO Elemento_do_agregado_familiar (nif, data_de_nascimento, email) VALUES (253984769,1998-08-24,'gbis@gmail.com');
INSERT INTO Elemento_do_agregado_familiar (nif, data_de_nascimento, email) VALUES (254095870,1998-01-15,'acsc@gmail.com');
--END

--RISCOS DE SAUDE
INSERT INTO Riscos_de_saude (valor, texto_explicativo, numero_identificacao) VALUES (2,'óxido de zinco a níveis acima de 2g da 2 pontos negativos', 18);
INSERT INTO Riscos_de_saude (valor, texto_explicativo, numero_identificacao) VALUES (5,'co2 a níveis acima de 8g da 5 pontos negativos', 12);
--END

--PEGADA ECOLOGICA
INSERT INTO Pegada_ecologica (valor, texto_explicativo, numero_identificacao) VALUES (10,'100g de borracha da 1 ponto negativos', 10);
INSERT INTO Pegada_ecologica (valor, texto_explicativo, numero_identificacao) VALUES (20,'10g de cartao nao reciclado da 10 pontos negativos', 8);
--END

--DEFESA DOS DIREITOS HUMANOS
INSERT INTO Defesa_dos_direitos_humanos (valor, texto_explicativo, numero_identificacao) VALUES (18,'comprar 1 produto de material reciclado da 1 ponto positivo', 5);
INSERT INTO Defesa_dos_direitos_humanos (valor, texto_explicativo, numero_identificacao) VALUES (35,'comprar produtos que apoiem causas solidarias reais da 5 pontos positivos', 2);
--END

--ELEMENTO
INSERT INTO Elemento (nome, numero_identificacao, numero_identificacao_riscos_saude, numero_identificacao_pegada_ecologica, numero_identificacao_defesa_direitos_humanos,) VALUES (1,12,8,2);
INSERT INTO Elemento (nome, numero_identificacao, numero_identificacao_riscos_saude, numero_identificacao_pegada_ecologica, numero_identificacao_defesa_direitos_humanos,) VALUES (2,18,10,5);
--END

--COMPOSTO POR
INSERT INTO Composto_por (percentagem, numero_identificacao_produto, numero_identificacao_elemento) VALUES (0.1,234,1);
INSERT INTO Composto_por (percentagem, numero_identificacao_produto, numero_identificacao_elemento) VALUES (0.5,320,2);
--END

--ARTIGO CIENTIFICO
INSERT INTO Artigo_cientifico (id, autor, titulo, editora, data_publicacao) VALUES (230,'Borracha grave para o ambiente','RubberOff', 2017-03-28);
INSERT INTO Artigo_cientifico (id, autor, titulo, editora, data_publicacao) VALUES (125,'Cartão não reciclado afeta saúde','RubberOff', 2017-01-12);
--END

--REFERENCIA RISCOS DE SAUDE
INSERT INTO Referencia_RS (riscos_saude, artigo_cientifico) VALUES (18,230);
INSERT INTO Referencia_RS (riscos_saude, artigo_cientifico) VALUES (12,125);
--END

--REFERENCIA PEGADA ECOLOGICA
INSERT INTO Referencia_PE (pegada_ecologica, artigo_cientifico) VALUES (10,230);
INSERT INTO Referencia_PE (pegada_ecologica, artigo_cientifico) VALUES (8,125);
--END

--REFERENCIA DIREITOS HUMANOS
INSERT INTO Referencia_DH (defesa_dos_direitos_humanos, artigo_cientifico) VALUES (5,230);
INSERT INTO Referencia_DH (defesa_dos_direitos_humanos, artigo_cientifico) VALUES (2,125);
--END
