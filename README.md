# Umani - Sistema de Gerenciamento de Usuários

O Umani é uma aplicação web full-stack construída com **Ruby on Rails 7** para gerenciar usuários. Ele possui um sistema completo de autenticação, controle de acesso baseado em papéis (roles) e um painel administrativo. Este projeto foi desenvolvido como um teste para desenvolvedor full-stack para demonstrar as melhores práticas em desenvolvimento web, arquitetura de software e segurança.

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

## ✨ Principais Funcionalidades Implementadas

-   **Autenticação Completa**: Registro seguro de usuários, login e recuperação de senha utilizando **Devise**.
-   **Controle de Acesso Baseado em Papéis**: Diferenciação entre os papéis de `Admin` e `User` (usuário comum), redirecionando-os para suas respectivas páginas após o login.
-   **Painel Administrativo**: Exibe métricas importantes, como o número total de usuários e a distribuição por papel.
-   **Gerenciamento Completo de Usuários (CRUD)**: Administradores podem listar, criar, editar e excluir usuários.
-   **Importação de Usuários em Massa**: Administradores podem criar usuários em lote através do upload de um arquivo **CSV**.
-   **Perfis de Usuário**: Usuários podem visualizar e editar suas informações pessoais, bem como excluir suas próprias contas.
-   **Upload de Avatares**: Suporte para upload de arquivos de imagem ou uso de URLs para a foto de perfil, utilizando Active Storage.
-   **Interface Responsiva**: Interface moderna e adaptável construída com **Bootstrap 5** e **SCSS**.
-   **Containerizado**: Pronto para ser executado com **Docker** e **Docker Compose**.

## 🏗️ Tecnologias Utilizadas

-   **Backend**: Ruby 3.1.4, Rails 7.1.5, PostgreSQL, Puma
-   **Frontend**: Bootstrap 5, SCSS, Stimulus.js, Turbo Rails
-   **Autenticação**: Devise
-   **Upload de Arquivos**: Active Storage
-   **Testes**: Capybara para testes de sistema
-   **Deployment**: Docker

## 🚀 Como Executar o Projeto

### Pré-requisitos

Log in credentials:
-   Admin   email: "admin@example.com"  password: "password123"
-   User    email: "user5@example.com"  password: "password123"


Certifique-se de que você tem o seguinte instalado:
-   Ruby `3.1.4`
-   Rails `7.1.5`
-   PostgreSQL
-   Docker (opcional)

### Instalação e Configuração

1.  **Clone o repositório:**
    ```bash
    git clone [url-do-seu-repositorio]
    cd umanni
    ```

2.  **Instale as dependências:**
    ```bash
    bundle install
    ```

3.  **Configure as variáveis de ambiente:**
    Copie o arquivo de exemplo e preencha com suas credenciais do banco de dados e uma chave secreta.
    ```bash
    cp .env.example .env
    ```

4.  **Crie e popule o banco de dados:**
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

5.  **Execute a aplicação:**
    -   **Usando o servidor Rails:**
        ```bash
        rails server
        ```
    -   **Usando Docker:**
        ```bash
        docker-compose up
        ```

Acesse a aplicação em `http://localhost:3000`.
