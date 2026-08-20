Ambiente de Desenvolvimento e Tecnologias

Ambiente de Desenvolvimento

Para o desenvolvimento do jogo **Brick Breaker**, será utilizado o **Visual Studio Code (VS Code)** como ambiente de desenvolvimento. A ferramenta foi escolhida por possuir suporte ao Flutter e à linguagem Dart através de extensões, além de permitir a integração com ferramentas de versionamento como o Git.

Durante o desenvolvimento, a aplicação poderá ser executada e testada utilizando um dispositivo Android físico ou um emulador Android.

O código-fonte e a documentação do projeto serão armazenados em um repositório público no **GitHub**, permitindo que todos os integrantes do grupo participem do desenvolvimento e mantenham um histórico das alterações realizadas.

Tecnologias e Linguagens

Flutter

O Flutter será utilizado como framework principal para o desenvolvimento da aplicação móvel. Com ele serão construídas as interfaces do aplicativo, incluindo a tela inicial, a tela de integrantes, as configurações e a integração com a tela do jogo.

Dart

A linguagem de programação utilizada no projeto será Dart, linguagem utilizada pelo Flutter. Através dela serão implementadas as funcionalidades da aplicação e a lógica necessária para o funcionamento do jogo.

Flame Engine

Para auxiliar na implementação do Brick Breaker será utilizado o Flame Engine, uma engine de jogos 2D integrada ao Flutter.

O Flame será utilizado principalmente para:

* movimentação da bola;
* controle da plataforma (paddle);
* criação e posicionamento dos blocos;
* detecção e tratamento das colisões;
* destruição dos blocos;
* controle e progressão dos níveis;
* reprodução dos efeitos sonoros do jogo.

A utilização do Flame facilita o desenvolvimento das mecânicas do jogo, principalmente o controle dos elementos gráficos e das colisões.

Git e GitHub

O Git será utilizado para o controle de versão do projeto e o GitHub para hospedagem do repositório público e colaboração entre os integrantes do grupo.

As alterações serão realizadas através de commits incrementais, seguindo o padrão Conventional Commits, permitindo identificar com maior facilidade o tipo de alteração realizada durante o desenvolvimento.

Exemplos:

feat: create initial game screen
feat: implement ball movement
fix: correct paddle collision
docs: add technologies documentation

Geração do APK

O aplicativo será desenvolvido inicialmente para dispositivos Android. Após a implementação e os testes, será gerado um arquivo APK para permitir a instalação e execução do jogo em dispositivos Android.

A geração da versão final será realizada através das ferramentas disponibilizadas pelo Flutter utilizando o seguinte comando:

flutter build apk --release

Após a compilação, o arquivo APK será disponibilizado pelo Flutter no diretório:

build/app/outputs/flutter-apk/app-release.apk

Esse arquivo poderá ser utilizado para instalar e testar a versão final do aplicativo em dispositivos Android.

Resumo das Tecnologias

Tecnologia/Finalidade

Flutter / Desenvolvimento da aplicação móvel e das interfaces 
Dart / Linguagem de programação utilizada no projeto       
Flame Engine / Desenvolvimento das mecânicas do jogo               
Visual Studio Code / Ambiente de desenvolvimento                         
Git / Controle de versão                                  
GitHub / Hospedagem e desenvolvimento colaborativo           
Android / Plataforma de execução do aplicativo                
