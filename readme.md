# 🛡️ Projeto Sentinela-Cidadão

**Tecnologia da Informação e Monitoramento Hidrológico para Resiliência Comunitária**

O **Sentinela-Cidadão** é uma aplicação voltada para a mitigação de desastres ambientais provocados por grandes precipitações pluviométricas na Região Metropolitana de São Paulo, focando incialmente na **Bacia do Aricanduva** (Zona Leste).

---

## 🎯 Objetivo
Integrar o monitoramento técnico de reservatórios e piscinões públicos (dados do SPÁguas/DAEE) com alertas da Defesa Civil e relatos georreferenciados enviadas pelos próprios cidadãos.

---

## 🛠️ Tecnologias Utilizadas
- **Banco de Dados:** PostgreSQL (Modelagem Relacional e Topologia de Bacias)
- **Frontend:** HTML5, CSS3, JavaScript (Vue.js & Leaflet.js para mapas interativos)
- **Controle de Versão:** Git e GitHub

---

## 📁 Estrutura do Repositório
```text
sentinela-cidadao/
├── database/   # Scripts SQL (DDL para criação de tabelas e DQL para consultas com JOIN)
├── docs/       # Relatórios de avaliação acadêmica UFMS e diagramas DER
└── src/        # Interface web e código-fonte do mapa interativo