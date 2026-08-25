# Construção das Paredes de Blocos

## Método de Construção

As paredes de blocos do jogo Brick Breaker serão construídas utilizando uma estrutura baseada em matrizes.

Cada posição da matriz representa uma possível posição de um tijolo na tela. Para facilitar a definição dos diferentes níveis, serão utilizados os valores:

* **`1`**: Indica uma posição que contém um tijolo.
* **`0`**: Indica uma posição vazia.

Durante a criação de cada nível, a matriz será percorrida linha por linha. Para cada posição com valor 1, será criado um tijolo na posição correspondente da tela. As posições com valor 0 permanecerão vazias.

Dessa maneira, diferentes paredes podem ser criadas apenas modificando a disposição dos valores da matriz.

O tamanho e o padrão de cores dos tijolos serão definidos de acordo com as opções selecionadas anteriormente pelo usuário na tela de configurações.

## Níveis do Jogo

### Nível 1 - Parede Completa

O primeiro nível utilizará uma parede totalmente preenchida. Seu objetivo é apresentar ao jogador a mecânica básica do jogo.

Exemplo simplificado da matriz:

```text
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
```

Nesse nível, todas as posições disponíveis possuem tijolos.

### Nível 2 - Parede com Espaços Vazios

O segundo nível utiliza posições preenchidas e posições vazias, criando uma parede menos uniforme.

Exemplo simplificado:

```text
1 1 0 1 1 1 0 1 1
1 0 1 1 0 1 1 0 1
0 1 1 0 1 0 1 1 0
1 0 1 1 0 1 1 0 1
```

Os espaços representados por 0 não recebem tijolos.

Esse padrão também poderá utilizar um fator de aleatoriedade durante sua geração, permitindo variar determinadas posições da parede sem alterar a estrutura geral do nível.

### Nível 3 - Pirâmide

No terceiro nível, os tijolos serão organizados formando uma pirâmide.

Exemplo simplificado:

```text
0 0 0 1 1 1 0 0 0
0 0 1 1 1 1 1 0 0
0 1 1 1 1 1 1 1 0
1 1 1 1 1 1 1 1 1
```

Nesse caso, a matriz possui uma estrutura previamente definida para produzir o formato apresentado no wireframe.

### Nível 4 - Padrão Alternado

O quarto nível utilizará um padrão alternado, distribuindo os tijolos com espaços entre eles.

Exemplo simplificado:

```text
1 0 1 0 1 0 1 0 1
0 1 0 1 0 1 0 1 0
1 0 1 0 1 0 1 0 1
0 1 0 1 0 1 0 1 0
```

Esse formato cria uma parede mais espaçada e modifica os ângulos e possibilidades de colisão da bola durante o nível.

### Nível 5 - Losango

No quinto nível, os tijolos serão posicionados formando um losango.

Exemplo simplificado:

```text
0 0 0 0 1 0 0 0 0
0 0 0 1 1 1 0 0 0
0 0 1 1 1 1 1 0 0
0 0 0 1 1 1 0 0 0
0 0 0 0 1 0 0 0 0
```

A utilização de uma matriz predefinida permite manter o formato do losango sempre que o nível for iniciado.

## Geração dos Tijolos

Durante a implementação do jogo, cada matriz será percorrida para verificar quais posições devem receber tijolos. De forma simplificada, o processo seguirá os seguintes passos:

Selecionar a matriz correspondente ao nível atual;

Percorrer suas linhas e colunas;

Verificar o valor de cada posição;

Criar um tijolo quando o valor encontrado for 1;

Calcular sua posição na tela de acordo com a linha, coluna e tamanho selecionado;

Aplicar o padrão de cores escolhido pelo usuário;

Adicionar o tijolo à área do jogo.

As posições contendo 0 serão ignoradas, criando os espaços vazios observados em determinados níveis.

## Progressão dos Níveis

Cada parede corresponde a um nível do jogo. Quando todos os tijolos presentes na parede forem destruídos, o nível será considerado concluído e o próximo será iniciado automaticamente.

Ao iniciar o novo nível, a matriz correspondente será carregada e uma nova parede será construída.

Essa abordagem permite criar novos níveis futuramente apenas adicionando novas matrizes ou novos métodos de geração, sem necessidade de alterar a estrutura principal do jogo.
