# 📚 BibliotecaCLI — Sistema de Gerenciamento de Biblioteca

Aplicação de linha de comando (**CLI**) desenvolvida em **Swift** para gerenciar um acervo de livros físicos e digitais. O projeto oferece operações de cadastro, consulta, edição e remoção de livros, além do controle de empréstimos e devoluções, por meio de um menu interativo no terminal.

## ✨ Funcionalidades

- **Cadastrar livros físicos e digitais:** informe ID, título, autor e ano de publicação; para livros digitais, informe também o tamanho do arquivo em MB.
- **Listar o acervo:** visualize os detalhes e a situação dos livros cadastrados.
- **Buscar livros:** consulte por ID ou por parte do título, sem diferenciar maiúsculas e minúsculas.
- **Editar informações:** atualize título, autor e ano de publicação; altere o tamanho de um livro digital.
- **Gerenciar empréstimos:** empreste livros disponíveis e registre devoluções, evitando operações incompatíveis com o estado atual.
- **Remover livros:** exclua itens pelo ID após confirmação.
- **Validar entradas:** o leitor de console verifica texto obrigatório, números inteiros/decimais, valores mínimos e respostas de confirmação.
- **Exibir resumo:** opção presente no menu, mas **ainda em desenvolvimento**; atualmente mostra apenas uma mensagem informativa.

> **Persistência:** os livros ficam armazenados em memória durante a execução. Ao encerrar o programa, o acervo não é salvo em arquivo ou banco de dados.

## 🛠️ Tecnologias e conceitos

- **Swift 6 / Swift Package Manager** (`swift-tools-version: 6.0`)
- **macOS 15 ou superior** (plataforma declarada no `Package.swift`)
- **Foundation** para recursos básicos da linguagem
- **Programação orientada a objetos:** classes, herança e sobrescrita de métodos
- **Protocolos:** `Documento` estabelece os requisitos de identificação e exibição
- **Encapsulamento:** propriedades com `private(set)` e acesso controlado
- **Organização em camadas:** aplicação, modelos, serviço e utilitários

## 📁 Estrutura do projeto

```text
cli_biblioteca_ios/
├── Package.swift
├── README.md
└── cli_biblioteca_ios/
    ├── App/
    │   └── BibliotecaApp.swift       # Menu e fluxo de interação
    ├── Models/
    │   ├── Documento.swift           # Protocolo dos documentos
    │   ├── Livro.swift               # Modelo de livro e empréstimos
    │   ├── LivroDigital.swift        # Especialização de Livro
    │   └── main.swift                # Ponto de entrada
    ├── Services/
    │   └── BibliotecaService.swift   # Acervo e operações de gerenciamento
    └── Utils/
        └── LeitorConsole.swift       # Leitura e validação de entradas
```

*A árvore mostra os arquivos-fonte principais; o repositório também contém arquivos gerados pelo ambiente de desenvolvimento.*

## 🚀 Como executar

**Pré-requisitos:** macOS com Swift e ferramentas do Xcode instaladas e configuradas.

1. Clone o repositório:

   ```bash
   git clone https://github.com/ItaloRochaj/cli_biblioteca_ios.git
   cd cli_biblioteca_ios
   ```

2. Confira a instalação do Swift:

   ```bash
   swift --version
   ```

3. Compile o projeto:

   ```bash
   swift build
   ```

4. Inicie o programa:

   ```bash
   swift run BibliotecaCLI
   ```

O programa exibe um menu e solicita que você digite o número da operação desejada.

## 💻 Menu principal

```text
================ MENU ================
1 - Cadastrar livro
2 - Listar todos os livros
3 - Buscar livro
4 - Editar livro
5 - Remover livro
6 - Exibir resumo
0 - Sair
======================================
```

Na opção **Buscar livro**, escolha entre busca por ID ou por título. Na opção **Editar livro**, é possível alterar dados cadastrais, emprestar, devolver ou atualizar o tamanho de um livro digital.

## 🧩 Como o código está organizado

| Arquivo | Responsabilidade |
| --- | --- |
| `BibliotecaApp.swift` | Exibe menus, recebe comandos e coordena as operações. |
| `Documento.swift` | Define o protocolo com `id` e `exibirDetalhes()`. |
| `Livro.swift` | Representa um livro e seu estado de empréstimo. |
| `LivroDigital.swift` | Herda de `Livro`, adiciona `tamanhoEmMB` e personaliza a exibição. |
| `BibliotecaService.swift` | Mantém uma coleção `[Livro]` em memória e implementa operações de gerenciamento. |
| `LeitorConsole.swift` | Centraliza leitura e validação de dados digitados. |
| `main.swift` | Inicializa e executa `BibliotecaApp`. |

## 📌 Regras implementadas

- Cada livro recebe um **ID único**; cadastros com ID já existente são rejeitados.
- A busca por título admite correspondências parciais e ignora diferenças entre letras maiúsculas e minúsculas.
- Um livro já emprestado não pode ser emprestado novamente sem devolução.
- Um livro disponível não pode ser devolvido novamente.
- O tamanho dos livros digitais deve ser um número positivo.
- A remoção exige confirmação do usuário.

## 🔭 Possíveis evoluções

- Implementar um resumo estatístico real do acervo (total de livros, digitais, disponíveis e emprestados).
- Adicionar persistência local em arquivo ou banco de dados.
- Criar testes automatizados para cadastro, busca e empréstimos.
- Melhorar a organização de arquivos gerados e backups por meio de `.gitignore`.

## 👨‍💻 Autor

**Italo Rocha** — [GitHub: @ItaloRochaj](https://github.com/ItaloRochaj)

Projeto desenvolvido para praticar Swift, orientação a objetos e organização de uma aplicação de terminal.
