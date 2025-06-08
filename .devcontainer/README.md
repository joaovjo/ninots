# Configuração do DevContainer para NinoTS

Este diretório contém a configuração do ambiente de desenvolvimento em container para o projeto
NinoTS.

## 🐳 Sobre o DevContainer

O DevContainer fornece um ambiente de desenvolvimento consistente e isolado usando Docker,
garantindo que todos os desenvolvedores trabalhem com as mesmas versões de ferramentas e
dependências.

## 🚀 Como usar

### Pré-requisitos

1. **Docker Desktop** instalado e em execução
2. **Visual Studio Code** com a extensão **Dev Containers** instalada

### Iniciando o ambiente

1. Abra o projeto no VS Code
2. Execute o comando: `Dev Containers: Reopen in Container`
    - Ou use `Ctrl+Shift+P` e digite "Dev Containers: Reopen in Container"
3. Aguarde a construção do container (primeira vez pode demorar alguns minutos)

## 📦 O que está incluído

### Base

-   **Alpine Linux** - Sistema operacional leve e seguro
-   **Bun.js** - Runtime único para JavaScript/TypeScript (sem Node.js)
-   **TypeScript** - Suporte completo via Bun
-   **Git** - Controle de versão

### Shells disponíveis

-   **Bash** - Shell padrão do sistema
-   **Zsh** - Z Shell com Oh My Zsh configurado
-   **Fish** - Friendly Interactive Shell
-   **Nushell** - Shell moderno e estruturado

### Ferramentas de desenvolvimento

-   **GitHub CLI** - Integração com GitHub
-   **Utilitários essenciais** (curl, wget, vim, nano, htop, tree, jq)
-   **Internacionalização** - Suporte a pt_BR.UTF-8

### Extensões do VS Code

-   **Bun for VS Code** - Suporte oficial ao Bun
-   **TypeScript** - Suporte avançado ao TypeScript
-   **Prettier** - Formatação de código
-   **ESLint** - Linting
-   **GitHub Copilot** - Assistente de IA
-   **Test Explorer** - Execução de testes
-   **Markdown** - Suporte a documentação

## 🔧 Configurações

### Portas expostas

-   **3000** - Aplicação principal NinoTS
-   **3001** - Servidor de desenvolvimento
-   **8080** - Preview/demonstrações
-   **9229** - Debug do Node.js

### Volumes

-   **Código fonte** - Montado em `/workspace`
-   **node_modules** - Volume nomeado para performance
-   **Cache** - Diretório `.cache` persistente

### Variáveis de ambiente

```bash
NODE_ENV=development
BUN_INSTALL=/usr/local/bun
PATH=/usr/local/bun/bin:$PATH
LANG=pt_BR.UTF-8
LC_ALL=pt_BR.UTF-8
```

## 🐚 Shells disponíveis

O ambiente oferece múltiplas opções de shell para diferentes preferências:

### Bash (padrão)
```bash
bash  # Muda para bash
```

### Zsh com Oh My Zsh
```bash
zsh   # Muda para zsh
```

### Fish Shell
```bash
fish  # Muda para fish
```

### Nushell
```bash
nu    # Muda para nushell
```

Todos os shells têm os mesmos aliases configurados automaticamente.

## 🎯 Comandos úteis

### NinoTS CLI

```bash
ninots --help          # Ajuda do CLI
ninots create <nome>   # Criar novo projeto
ninots dev             # Modo desenvolvimento
ninots-test            # Executar testes
ninots-clean           # Limpar e reinstalar dependências
```

### Bun (sem Node.js)

```bash
b                      # Alias para bun
bi                     # bun install
br <script>            # bun run <script>
bt                     # bun test
bw <file>              # bun --watch <file>
```

### Git

```bash
gs                     # git status
ga <files>             # git add
gc <message>           # git commit
gp                     # git push
gl                     # git log --oneline
```

## 📁 Estrutura de arquivos

```
.devcontainer/
├── devcontainer.json  # Configuração principal
├── Dockerfile         # Imagem Docker customizada (Alpine + Bun)
├── setup.sh          # Script de configuração automatizada
├── settings.json     # Configurações específicas do VS Code
├── .prettierrc       # Configuração do Prettier
├── .prettierignore   # Arquivos ignorados pelo Prettier
└── README.md         # Esta documentação
```

E no raiz do projeto:
```
.editorconfig         # Configuração do EditorConfig
```

## 🔄 Atualizações

### Reconstruir container

Se você fez alterações na configuração:

```
Dev Containers: Rebuild Container
```

### Atualizar dependências

```bash
bun install
```

### Limpar cache

```bash
ninots-clean
```

## 🐛 Resolução de problemas

### Container não inicia

1. Verifique se o Docker está em execução
2. Reinicie o Docker Desktop
3. Tente reconstruir o container

### Bun não encontrado

```bash
curl -fsSL https://bun.sh/install | bash
# Para bash/zsh
source ~/.bashrc
# ou source ~/.zshrc

# Para fish
source ~/.config/fish/config.fish
```

### Permissões de arquivo

```bash
sudo chown -R vscode:vscode /workspace
```

### Performance lenta

-   Certifique-se de que o Docker está alocado com recursos suficientes
-   Use volumes nomeados para `node_modules`

## 📖 Documentação adicional

-   [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
-   [Bun Documentation](https://bun.sh/docs)
-   [NinoTS Documentation](../README.md)

## 🤝 Contribuindo

Para melhorar a configuração do DevContainer:

1. Faça suas alterações em `.devcontainer/`
2. Teste reconstruindo o container
3. Documente as mudanças neste README
4. Abra um Pull Request

## 🌍 Internacionalização

O ambiente está configurado com suporte completo ao português brasileiro:

- **Locale**: `pt_BR.UTF-8`
- **Encoding**: UTF-8
- **Mensagens**: Configuradas em português quando possível

## 🚀 Performance

O uso do **Alpine Linux** + **Bun.js** oferece:

- ⚡ **Startup mais rápido** - Alpine é extremamente leve
- 📦 **Menor uso de espaço** - Imagem base menor
- 🔋 **Menor consumo de recursos** - Sem Node.js desnecessário
- 🛡️ **Maior segurança** - Menos superficie de ataque

---

💡 **Dica**: Use `Ctrl+Shift+P` no VS Code para acessar rapidamente os comandos do Dev Container!

🐚 **Shells**: Experimente diferentes shells digitando `zsh`, `fish` ou `nu` no terminal!
