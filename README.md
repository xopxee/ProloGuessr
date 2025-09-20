# ProloGuesser: Jogo de Adivinhação de Países em PROLOG

> Um jogo interativo de adivinhação desenvolvido em PROLOG, onde o jogador tenta descobrir um país secreto com base em dicas lógicas geradas pelo sistema.

Este projeto foi desenvolvido como uma aplicação prática dos conceitos de programação em lógica, utilizando uma base de conhecimento sobre países para criar uma experiência de jogo desafiadora e educativa.

## 📜 Sobre o Projeto

O objetivo principal é demonstrar a eficácia da linguagem PROLOG para manipulação de bases de conhecimento e implementação de sistemas baseados em regras. O jogo seleciona aleatoriamente um país de uma lista pré-definida e o jogador deve adivinhá-lo. A cada palpite, o sistema fornece dicas comparativas, informando:

  * Quais características categóricas (continente, hemisfério, idioma) estão corretas.
  * Se a temperatura e a população do país secreto são maiores ou menores que as do país palpitado.

## ✨ Funcionalidades

  - **Base de Conhecimento Extensa:** Contém dezenas de países com atributos como hemisfério, continente, idioma, temperatura média e população.
  - **Seleção Aleatória:** A cada nova partida, um país diferente é escolhido como resposta, garantindo a rejogabilidade.
  - **Feedback Inteligente:** O sistema fornece dicas lógicas que ajudam o jogador a refinar suas próximas tentativas.
  - **Ferramenta de Dica:** O jogador pode pedir para o sistema fornecer a capital do país como dica.
  - **Interface Simples:** Interação direta via terminal de comandos PROLOG.

## 🛠️ Tecnologias Utilizadas

  - **Linguagem:** [PROLOG](https://www.swi-prolog.org/)
  - **Interpretador Recomendado:** [SWI-Prolog](https://www.swi-prolog.org/download/stable)

## 🚀 Como Executar

### Pré-requisitos

Antes de começar, você precisa ter um interpretador PROLOG instalado. Recomendamos o SWI-Prolog.

### Passo a Passo

1.  **Clone o repositório:**

    ```bash
    git clone https://github.com/xopxee/ProloGuessr
    ```

2.  **Navegue até o diretório do projeto:**

    ```bash
    cd [NOME_DO_DIRETORIO]
    ```

3.  **Inicie o interpretador SWI-Prolog:**

    ```bash
    swipl
    ```

4.  **Consulte (carregue) o arquivo do projeto:**

    ```prolog
    ?- consult('ProloGuessr3.pl').
    ```

5.  **Inicie o jogo:**

    ```prolog
    ?- jogo.
    ```

## 🎮 Como Jogar

1.  Após iniciar o jogo com o comando `jogo.`, o sistema irá notificá-lo que um país foi escolhido.
2.  Digite seu palpite em letras minúsculas, seguido de um ponto final (`.`), e pressione Enter. Exemplo: `franca.`
3.  Analise as dicas fornecidas:
      - `Atributos em comum`: Mostra as características que o seu palpite e o país secreto compartilham.
      - `Temperatura` e `População`: Indicam se os valores do país secreto são `MAIOR` ou `MENOR`.
4.  Continue fazendo palpites até acertar.
5.  Se precisar de uma dica, digite `capital.` e o jogo mostrará a Capital do país a ser adivinhado.
6.  Se quiser desistir, digite `desisto.`

## 📁 Estrutura do Código

  - `pais`: Fatos que compõem a base de conhecimento. Cada fato define um país e sua lista de atributos.
  - `iniciar_jogo`: Predicado que inicializa o jogo, escolhendo um país aleatório e armazenando-o dinamicamente.
  - `verificar_palpite`: O núcleo lógico do jogo. Compara o palpite do usuário com a resposta correta e gera as dicas.
  - `jogo` e `loop_palpites`: Controlam o fluxo principal e o loop de interação com o jogador.
  - `advinhar`: Predicado utilitário para realizar consultas diretas à base de conhecimento.

## 👨‍💻 Autores

  - **Jorge Alberto** - github.com/xopxee
  - **Bruno Costa** - github.com/brunocostaar
  - **Arthur Moreira** - https://github.com/arthurmoreirat

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
