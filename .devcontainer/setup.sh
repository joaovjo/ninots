#!/bin/sh

# Script de configuração do ambiente de desenvolvimento NinoTS
echo "🚀 Configurando ambiente de desenvolvimento NinoTS..."

# Atualizar sistema Alpine
echo "📦 Atualizando sistema Alpine..."
sudo apk update && sudo apk upgrade

# Instalar dependências adicionais se necessário
echo "🔧 Verificando dependências..."
sudo apk add --no-cache \
    curl \
    wget \
    git \
    vim \
    nano \
    htop \
    tree \
    jq \
    unzip \
    zip

# Verificar se o Bun está instalado e funcionando
echo "🍞 Verificando instalação do Bun..."
if command -v bun > /dev/null 2>&1; then
    echo "✅ Bun está instalado: $(bun --version)"
else
    echo "❌ Bun não encontrado, instalando..."
    curl -fsSL https://bun.sh/install | bash
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Verificar Node.js (deve estar removido)
if command -v node > /dev/null 2>&1; then
    echo "⚠️  Node.js detectado, mas usaremos apenas Bun"
else
    echo "✅ Node.js não instalado - usando apenas Bun como runtime"
fi

# Configurar Git (se não estiver configurado)
echo "📝 Configurando Git..."
if [ -z "$(git config --global user.name)" ]; then
    echo "⚠️  Configure seu nome no Git: git config --global user.name 'Seu Nome'"
fi

if [ -z "$(git config --global user.email)" ]; then
    echo "⚠️  Configure seu email no Git: git config --global user.email 'seu@email.com'"
fi

# Instalar dependências do projeto
echo "📚 Instalando dependências do projeto..."
cd /workspace
bun install

# Criar diretórios necessários
echo "📁 Criando estrutura de diretórios..."
mkdir -p .cache/bun
mkdir -p logs
mkdir -p tmp

# Configurar permissões
echo "🔐 Configurando permissões..."
sudo chown -R vscode:vscode /workspace
chmod +x /workspace/.devcontainer/setup.sh

# Configurar aliases para todos os shells
echo "⚡ Configurando aliases para shells..."

# Bashrc
cat >> ~/.bashrc << 'EOF'

# NinoTS Aliases
alias ninots="bun run packages/cli/src/index.ts"
alias ninots-dev="bun run --watch packages/cli/src/index.ts"
alias ninots-build="bun run build"
alias ninots-test="bun test"
alias ninots-lint="bun run lint"
alias ninots-clean="rm -rf node_modules packages/*/node_modules .cache && bun install"

# Bun Aliases
alias b="bun"
alias bi="bun install"
alias br="bun run"
alias bt="bun test"
alias bw="bun --watch"

# Utilitários
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."
alias tree="tree -I 'node_modules|.git|dist|build'"

# Git Aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"
alias gco="git checkout"
alias gb="git branch"

EOF

# Zshrc
cat >> ~/.zshrc << 'EOF'

# NinoTS Aliases
alias ninots="bun run packages/cli/src/index.ts"
alias ninots-dev="bun run --watch packages/cli/src/index.ts"
alias ninots-build="bun run build"
alias ninots-test="bun test"
alias ninots-lint="bun run lint"
alias ninots-clean="rm -rf node_modules packages/*/node_modules .cache && bun install"

# Bun Aliases
alias b="bun"
alias bi="bun install"
alias br="bun run"
alias bt="bun test"
alias bw="bun --watch"

# Utilitários
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."
alias tree="tree -I 'node_modules|.git|dist|build'"

# Git Aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"
alias gco="git checkout"
alias gb="git branch"

EOF

# Fish config
mkdir -p ~/.config/fish
cat >> ~/.config/fish/config.fish << 'EOF'

# NinoTS Aliases
alias ninots "bun run packages/cli/src/index.ts"
alias ninots-dev "bun run --watch packages/cli/src/index.ts"
alias ninots-build "bun run build"
alias ninots-test "bun test"
alias ninots-lint "bun run lint"
alias ninots-clean "rm -rf node_modules packages/*/node_modules .cache && bun install"

# Bun Aliases
alias b "bun"
alias bi "bun install"
alias br "bun run"
alias bt "bun test"
alias bw "bun --watch"

# Utilitários
alias ll "ls -alF"
alias la "ls -A"
alias l "ls -CF"
alias .. "cd .."
alias ... "cd ../.."

# Git Aliases
alias gs "git status"
alias ga "git add"
alias gc "git commit"
alias gp "git push"
alias gl "git log --oneline"
alias gco "git checkout"
alias gb "git branch"

EOF

# Nushell config
mkdir -p ~/.config/nushell
cat >> ~/.config/nushell/config.nu << 'EOF'

# NinoTS Aliases
alias ninots = bun run packages/cli/src/index.ts
alias ninots-dev = bun run --watch packages/cli/src/index.ts
alias ninots-build = bun run build
alias ninots-test = bun test
alias ninots-lint = bun run lint
alias ninots-clean = rm -rf node_modules packages/*/node_modules .cache && bun install

# Bun Aliases
alias b = bun
alias bi = bun install
alias br = bun run
alias bt = bun test
alias bw = bun --watch

# Utilitários
alias ll = ls -la
alias la = ls -A
alias l = ls
alias .. = cd ..
alias ... = cd ../..

# Git Aliases
alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gl = git log --oneline
alias gco = git checkout
alias gb = git branch

EOF

# Verificar instalação
echo "🔍 Verificando instalação..."
echo "Bun: $(bun --version)"
if command -v tsc > /dev/null 2>&1; then
    echo "TypeScript: $(bun x typescript --version)"
else
    echo "TypeScript: Disponível via Bun"
fi

# Executar testes para verificar se tudo está funcionando
echo "🧪 Executando testes de verificação..."
cd /workspace
if bun test --help > /dev/null 2>&1; then
    echo "✅ Ambiente de testes configurado corretamente"
else
    echo "⚠️  Ambiente de testes pode precisar de configuração adicional"
fi

# Configurar hooks do Git (se existirem)
if [ -d ".git/hooks" ]; then
    echo "🪝 Configurando Git hooks..."
    # Adicionar hooks personalizados aqui se necessário
fi

echo ""
echo "🎉 Ambiente de desenvolvimento NinoTS configurado com sucesso!"
echo ""
echo "🐚 Shells disponíveis:"
echo "  bash   - Shell padrão"
echo "  zsh    - Z Shell com Oh My Zsh"
echo "  fish   - Friendly Interactive Shell"
echo "  nu     - Nushell (moderno)"
echo ""
echo "💡 Para trocar de shell:"
echo "  bash   - digite 'bash'"
echo "  zsh    - digite 'zsh'"
echo "  fish   - digite 'fish'"
echo "  nu     - digite 'nu'"
echo ""
echo "📋 Comandos úteis:"
echo "  ninots --help          - Ajuda do CLI"
echo "  ninots create <nome>   - Criar novo projeto"
echo "  ninots dev             - Modo desenvolvimento"
echo "  bun run dev            - Executar em modo watch"
echo "  bun test               - Executar testes"
echo ""
echo "📂 Estrutura do projeto:"
echo "  /workspace/packages/cli  - CLI do NinoTS"
echo "  /workspace/packages/core - Core do framework"
echo ""
echo "🔗 Portas expostas:"
echo "  3000 - Aplicação principal"
echo "  3001 - Servidor de desenvolvimento"
echo "  8080 - Preview"
echo "  9229 - Debug"
echo ""
echo "🚀 Pronto para desenvolver! Escolha seu shell preferido!"
