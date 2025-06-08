# Dockerfile para ambiente de desenvolvimento NinoTS
# Baseado na imagem oficial do Bun com Alpine Linux

FROM oven/bun:1.1.38-alpine

# Definir labels para documentação
LABEL maintainer="NinoTS Team"
LABEL description="Ambiente de desenvolvimento para NinoTS Framework"
LABEL version="1.0"

# Variáveis de ambiente
ENV NODE_ENV=development
ENV BUN_INSTALL=/usr/local/bun
ENV PATH="$BUN_INSTALL/bin:$PATH"
ENV LANG=pt_BR.UTF-8
ENV LC_ALL=pt_BR.UTF-8

# Atualizar sistema e instalar dependências básicas
RUN apk update && apk add --no-cache \
    curl \
    wget \
    git \
    build-base \
    ca-certificates \
    vim \
    nano \
    htop \
    tree \
    jq \
    unzip \
    zip \
    bash \
    zsh \
    fish \
    sudo \
    shadow \
    && rm -rf /var/cache/apk/*

# Instalar Nushell
RUN wget https://github.com/nushell/nushell/releases/download/0.99.1/nu-0.99.1-x86_64-unknown-linux-musl.tar.gz \
    && tar -xzf nu-0.99.1-x86_64-unknown-linux-musl.tar.gz \
    && mv nu-0.99.1-x86_64-unknown-linux-musl/nu /usr/local/bin/ \
    && rm -rf nu-0.99.1-x86_64-unknown-linux-musl* \
    && chmod +x /usr/local/bin/nu

# Criar usuário vscode com sudo
RUN addgroup -g 1000 vscode \
    && adduser -u 1000 -G vscode -s /bin/bash -D vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

# Mudar para usuário vscode e configurar shells
USER vscode

# Configurar Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

# Configurar Fish shell
RUN fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Configurar bashrc
RUN echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.bashrc \
    && echo 'export NODE_ENV=development' >> ~/.bashrc \
    && echo 'alias ll="ls -alF"' >> ~/.bashrc \
    && echo 'alias la="ls -A"' >> ~/.bashrc \
    && echo 'alias l="ls -CF"' >> ~/.bashrc

# Configurar zshrc
RUN echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.zshrc \
    && echo 'export NODE_ENV=development' >> ~/.zshrc \
    && echo 'alias ll="ls -alF"' >> ~/.zshrc \
    && echo 'alias la="ls -A"' >> ~/.zshrc \
    && echo 'alias l="ls -CF"' >> ~/.zshrc

# Configurar Fish
RUN mkdir -p ~/.config/fish \
    && echo 'set -gx PATH $BUN_INSTALL/bin $PATH' >> ~/.config/fish/config.fish \
    && echo 'set -gx NODE_ENV development' >> ~/.config/fish/config.fish \
    && echo 'alias ll "ls -alF"' >> ~/.config/fish/config.fish \
    && echo 'alias la "ls -A"' >> ~/.config/fish/config.fish \
    && echo 'alias l "ls -CF"' >> ~/.config/fish/config.fish

# Configurar Nushell
RUN mkdir -p ~/.config/nushell \
    && echo '$env.PATH = ($env.PATH | split row (char esep) | prepend "/usr/local/bun/bin")' >> ~/.config/nushell/env.nu \
    && echo '$env.NODE_ENV = "development"' >> ~/.config/nushell/env.nu

# Voltar para root para configurações finais
USER root

# Remover instalação do Node.js se existir (não precisamos)
RUN which node && rm -f $(which node) || true
RUN which npm && rm -f $(which npm) || true

# Verificar instalação do Bun
RUN bun --version

# Criar diretório de trabalho
WORKDIR /workspace

# Dar permissões ao usuário vscode
RUN chown -R vscode:vscode /workspace

# Mudar para usuário vscode
USER vscode

# Comando padrão - não define shell específico
CMD ["/bin/bash"]
