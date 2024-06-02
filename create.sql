CREATE DATABASE atm;
USE atm;

CREATE TABLE Zona (
    numero INT AUTO_INCREMENT PRIMARY KEY,
    n_abitanti INT NOT NULL,
    superficie FLOAT NOT NULL,
    dati_occupazione INT
);

CREATE TABLE Mezzo_di_trasporto (
    targa VARCHAR(10) PRIMARY KEY,
    controllore INT(2) NOT NULL,
    capienza INT NOT NULL,
    inquinamento FLOAT NOT NULL,
    guidatore BOOL NOT NULL,
    tipo VARCHAR(13) NOT NULL,
    propulsione VARCHAR(10) NOT NULL
);

CREATE TABLE Fermata (
    codice INT PRIMARY KEY,
    macchinetta_biglietti BOOL,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Tratta (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    km FLOAT NOT NULL,
    n_fermate INT NOT NULL,
    mezzo VARCHAR(10) NOT NULL,
    zona_attraversata INT,
    inizio INT NOT NULL,
    fine INT NOT NULL,
    FOREIGN KEY (mezzo) REFERENCES Mezzo_di_trasporto(targa),
    FOREIGN KEY (zona_attraversata) REFERENCES Zona(numero),
    FOREIGN KEY (inizio) REFERENCES Fermata(codice),
    FOREIGN KEY (fine) REFERENCES Fermata(codice)
);

CREATE TABLE Tratta_Fermata (
    tratta INT,
    fermata INT,
    PRIMARY KEY (TRATTA, FERMATA),
    FOREIGN KEY (tratta) REFERENCES Tratta(ID),
    FOREIGN KEY (fermata) REFERENCES Fermata(codice),
    UNIQUE KEY (tratta, fermata) 
);

CREATE TABLE Corsia_prioritaria (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    inizio_corsia INT NOT NULL,
    fine_corsia INT NOT NULL,
    FOREIGN KEY (inizio_corsia) REFERENCES Fermata(codice),
    FOREIGN KEY (fine_corsia) REFERENCES Fermata(codice)
);

CREATE TABLE Zona_di_inizio_o_fine (
    tratta INT,
    zona INT,
    tipo VARCHAR(50),
    PRIMARY KEY (tratta, zona, tipo),
    FOREIGN KEY (tratta) REFERENCES Tratta(ID),
    FOREIGN KEY (zona) REFERENCES Zona(numero)
);

CREATE TABLE Corsa (
	ID varchar(50) PRIMARY KEY,
    ora_inizio TIME NOT NULL,
    data DATE NOT NULL,
    ora_fine TIME NOT NULL,
    tratta INT NOT NULL,
    FOREIGN KEY (tratta) REFERENCES Tratta(ID)
);

CREATE TABLE Tessera (
    numero INT AUTO_INCREMENT PRIMARY KEY,
    data_scadenza DATE NOT NULL,
    obliterazione_tessera INT NOT NULL,
    FOREIGN KEY (obliterazione_tessera) REFERENCES Biglietto(ID)
);

CREATE TABLE Biglietto (
    ID INT PRIMARY KEY,
    corsa VARCHAR(50) NOT NULL,
    ora_obliterazione TIME NOT NULL,
    FOREIGN KEY (corsa) REFERENCES Corsa(ID)
);

CREATE TABLE Biglietto_cartaceo (
    data_emissione DATE,
    codice_transazione INT,
    obliterazione INT NOT NULL,
    PRIMARY KEY (data_emissione, codice_transazione),
    FOREIGN KEY (obliterazione) REFERENCES Biglietto(ID)
);

CREATE TABLE Proprietario (
    nome VARCHAR(50),
    cognome VARCHAR(50),
    mail VARCHAR(100),
    tessera INT,
    uso VARCHAR(50),
    abbonamento VARCHAR(50),
    eta INT,
    professione VARCHAR(50),
    PRIMARY KEY (nome, cognome, mail, numero_di_tessera),
    FOREIGN KEY (tessera) REFERENCES Tessera(numero) ON DELETE CASCADE
);

CREATE TABLE Tratta_CP (
    CP INT,
    tratta INT,
    PRIMARY KEY (CP, tratta),
    FOREIGN KEY (tratta) REFERENCES Tratta(ID),
    FOREIGN KEY (CP) REFERENCES Corsia_prioritaria(ID)
);

