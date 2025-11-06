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

## 🗺️ Roadmap: Atendendo a Todos os Requisitos do Projeto

Este projeto implementa com sucesso as funcionalidades principais solicitadas no teste. Os pontos a seguir descrevem os próximos passos para atender completamente a todos os requisitos e adicionar melhorias.

### ⏳ A Fazer

1.  **Implementar Dashboard e Progresso de Importação em Tempo Real**
    -   **Requisito**: "Você deve usar coisas relacionadas a tempo real (contadores no Dashboard Admin, progresso da importação, etc.)" e "Como Admin, devo ser capaz de ver o progresso da importação de Usuários."
    -   **Status Atual**: As estatísticas do dashboard são carregadas na renderização da página, e o feedback da importação CSV é fornecido apenas após o término do processo.
    -   **Próximo Passo**: Integrar **Action Cable** ou uma solução similar com WebSockets para atualizar os contadores do dashboard em tempo real e exibir uma barra de progresso ao vivo durante as importações de CSV.

2.  **Atingir 90% de Cobertura de Testes**
    -   **Requisito**: "Testes com pelo menos 90% de cobertura".
    -   **Status Atual**: O projeto inclui uma base sólida de testes de modelo, controller e sistema com Capybara.
    -   **Próximo Passo**: Gerar um relatório de cobertura de testes (ex: com a gem SimpleCov), escrever testes adicionais para cobrir as lacunas e garantir que a meta de 90% seja atingida.

3.  **Melhorar o Gerenciamento de Papéis (Roles)**
    -   **Requisito**: "Como Admin, devo ser capaz de alternar o Papel do Usuário."
    -   **Status Atual**: O papel do usuário pode ser alterado através do formulário de "Editar Usuário".
    -   **Próximo Passo**: Implementar um botão "alternar papel" mais intuitivo, com um clique, diretamente na lista de usuários no painel de administração para uma melhor experiência do usuário.

### ⭐ Pontos Extras (Melhorias Futuras)

-   **Introduzir Componentes React**: Para elementos altamente interativos, como a barra de progresso da importação ou um widget de dashboard com atualização ao vivo, introduzir React pode proporcionar uma experiência de usuário mais rica.
-   **Adicionar Testes de Estresse**: Implementar testes de estresse (ex: com uma ferramenta como k6) para avaliar a performance da aplicação e garantir que ela suporte uma alta carga de acessos.
-   **Suporte a Navegadores**: Realizar testes abrangentes em Edge, Chrome, Firefox e Safari para garantir a compatibilidade entre diferentes navegadores.
