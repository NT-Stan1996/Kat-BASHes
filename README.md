# Kat#BASHes

## Sobre
Kat#BASHes (Kat BASH Entertainment System) é um ambiente de execução de jogos baseado em Bash, focado em simplicidade e compatibilidade com scripts `.sh` e executáveis `.bin`. Desenvolvido por **StanoBemLoko** (eu) e distribuído pela **Neko Interactive Systems™**, o sistema busca oferecer uma experiência intuitiva para rodar jogos de maneira prática.

## Instalador
O instalador do Kat#BASHes é um script Bash que automatiza a instalação do sistema, criando a estrutura de diretórios necessária e preparando um atalho para inicialização rápida.

### Passos do Instalador:
1. Copia a pasta `KTBASHes` para o diretório home do usuário.
2. Cria um script de inicialização (`KTBASHes_START.SH`) no diretório home.
3. O usuário pode iniciar o Kat#BASHes executando `bash KTBASHes_START.SH`.

Após a instalação, sempre que desejar acessar o Kat#BASHes, basta rodar o script criado no home.

## Menu Principal
O menu inicial do Kat#BASHes é baseado em `dialog`, oferecendo uma interface simples e funcional para navegação. As opções disponíveis são:

1. **Jogar** - Lista os jogos instalados e permite iniciar um deles.
2. **Jogos Salvos** - Gerencia arquivos `.SAV`, permitindo exclusão.
3. **Sobre** - Exibe informações sobre o Kat#BASHes e os desenvolvedores.
4. **NIS™ Store** - Loja de Jogos e Apps
5. **Sair** - Encerra o sistema.
6. **PWD** - Mostra o diretório atual.

### Suporte a Jogos
- Jogos `.sh` são executados com Bash e precisam de uma assinatura válida (`KTBASHES` ou `FIRE`).
- Jogos `.bin` são executados diretamente, sem verificação de assinatura (suporte a .bin é experimental).

### Como adicionar uma assinatura?
- Na terceira linha do seu jogo (`.sh` apenas), adicione:
```
# SIGNATURE="<assinatura aqui>"
```

## Créditos
- **Desenvolvimento:** StanoBemLoko (eu)
- **Distribuição:** Neko Interactive Systems™
- **Apoio:**
  - Fire <3

## Como Contribuir
Contribuições são bem-vindas! Você pode sugerir melhorias, reportar bugs e ajudar no desenvolvimento.

## Licença
_© 2024-2025 Neko Interactive Systems™_

_© 2019-2025 TGF! Studios™_

Todos os direitos reservados.
