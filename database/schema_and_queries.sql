-- ============================================================
-- PROJETO SENTINELA-CIDADÃO - ESTRUTURA DDL E CONSULTAS DQL
-- Banco de Dados: PostgreSQL
-- Bacia do Aricanduva - RMSP
-- ============================================================

-- 1. ESTRUTURA DDL (CRIAÇÃO DE TABELAS)

-- Tabela Piscinao (com auto-relacionamento topológico)
CREATE TABLE Piscinao (
    id_piscinao SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    bacia_hidrografica VARCHAR(100) NOT NULL,
    curso_agua_comum VARCHAR(100) NOT NULL,
    latitude NUMERIC(10, 8) NOT NULL,
    longitude NUMERIC(11, 8) NOT NULL,
    capacidade_maxima_m3 DOUBLE PRECISION NOT NULL,
    id_piscinao_montante INTEGER,
    id_piscinao_jusante INTEGER,
    CONSTRAINT fk_piscinao_montante FOREIGN KEY (id_piscinao_montante) REFERENCES Piscinao(id_piscinao),
    CONSTRAINT fk_piscinao_jusante FOREIGN KEY (id_piscinao_jusante) REFERENCES Piscinao(id_piscinao)
);

-- Tabela AlertaServicoPublico
CREATE TABLE AlertaServicoPublico (
    id_alerta SERIAL PRIMARY KEY,
    data_hora_emissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    provedor_origem VARCHAR(50) NOT NULL,
    nivel_gravidade VARCHAR(20) CHECK (nivel_gravidade IN ('Atenção', 'Alerta', 'Emergência')),
    mensagem_texto TEXT NOT NULL,
    bacia_afetada VARCHAR(100) NOT NULL
);

-- Tabela OcorrenciaCidada (Relatos dos Moradores)
CREATE TABLE OcorrenciaCidada (
    id_ocorrencia SERIAL PRIMARY KEY,
    latitude NUMERIC(10, 8) NOT NULL,
    longitude NUMERIC(11, 8) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descricao_situacao TEXT,
    status_alagamento VARCHAR(30) NOT NULL
);

-- Tabela StatusSistemaGeral
CREATE TABLE StatusSistemaGeral (
    id_status SERIAL PRIMARY KEY,
    id_alerta INTEGER,
    status_aplicativo VARCHAR(30) NOT NULL,
    ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_status_alerta FOREIGN KEY (id_alerta) REFERENCES AlertaServicoPublico(id_alerta) ON DELETE SET NULL
);

-- 2. POVOAMENTO INICIAL (DML)

INSERT INTO Piscinao (nome, bacia_hidrografica, curso_agua_comum, latitude, longitude, capacidade_maxima_m3)
VALUES 
('Piscinão Aricanduva 1', 'Bacia do Aricanduva', 'Córrego Aricanduva', -23.56500000, -46.52000000, 200000.0),
('Piscinão Ragueb Chohfi', 'Bacia do Aricanduva', 'Córrego Aricanduva', -23.58000000, -46.49000000, 350000.0);

-- Ajuste de topologia (Montante/Jusante)
UPDATE Piscinao SET id_piscinao_jusante = 2 WHERE id_piscinao = 1;
UPDATE Piscinao SET id_piscinao_montante = 1 WHERE id_piscinao = 2;

-- Inserção de Alerta da Defesa Civil
INSERT INTO AlertaServicoPublico (provedor_origem, nivel_gravidade, mensagem_texto, bacia_afetada)
VALUES ('Defesa Civil SP', 'Alerta', 'Risco iminente de transbordo na calha do Aricanduva próximo à Av. Ragueb Chohfi.', 'Bacia do Aricanduva');

-- 3. CONSULTAS DE VERIFICAÇÃO (DQL COM JOIN)

SELECT 
    p.nome AS Piscinao_Atual,
    p.bacia_hidrografica,
    pm.nome AS Piscinao_Montante,
    pj.nome AS Piscinao_Jusante
FROM Piscinao p
LEFT JOIN Piscinao pm ON p.id_piscinao_montante = pm.id_piscinao
LEFT JOIN Piscinao pj ON p.id_piscinao_jusante = pj.id_piscinao;