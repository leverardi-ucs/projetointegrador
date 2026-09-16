
# Brick Breaker

Aplicativo móvel desenvolvido para a disciplina de Projeto Integrador VI-A. O jogo desafia o usuário a controlar uma plataforma, rebater a bola e eliminar todos os tijolos de cada fase.

## Funcionalidades

* Tela inicial com acesso ao jogo, configurações e integrantes;
* Cinco níveis com paredes construídas por matrizes;
* Movimento da plataforma por toque ou arrasto horizontal;
* Colisão da bola com paredes, plataforma e tijolos;
* Pontuação, vidas, reinício do nível e progressão automática;
* Três temas de cor e três tamanhos de tijolo.

## Tecnologias

* Flutter e Dart;
* `CustomPainter` para a renderização do jogo 2D;
* Android/Gradle para geração do APK;
* Git e GitHub para versionamento.

## Como executar

Pré-requisitos: Flutter 3.47.4 (Dart 3.13.3), versão usada na compilação de entrega, Android SDK e um emulador ou dispositivo Android.

```bash
flutter pub get
flutter run
```

## APK de entrega

O APK final deve ficar obrigatoriamente em [`apk/brick-breaker.apk`](apk/brick-breaker.apk). Para gerá-lo e copiá-lo para o local de entrega, no PowerShell execute:

```powershell
.\scripts\build-apk.ps1
```

O script obtém as dependências, executa `flutter analyze` e `flutter build apk --release`, interrompendo a entrega se algum comando falhar, e copia o arquivo produzido pelo Flutter para a pasta `apk/`. Dessa forma, o arquivo versionado no repositório será exatamente o APK entregue.

Caso a política do PowerShell bloqueie a execução do script, os mesmos passos podem ser feitos manualmente:

```powershell
flutter build apk --release
New-Item -ItemType Directory -Force -Path .\apk
Copy-Item .\build\app\outputs\flutter-apk\app-release.apk .\apk\brick-breaker.apk -Force
```

O APK de entrega foi gerado em `apk/brick-breaker.apk`. Antes de enviar o repositório, ele deve ser instalado e testado em um dispositivo Android.

## Estrutura

```text
lib/                 Código Dart da interface e da mecânica do jogo
android/             Projeto Android usado pelo Flutter
apk/                 Local do APK que será entregue
docs/                Documentação do projeto
wireframes/          Wireframes das telas
```

## Documentação

* [Ambiente e tecnologias](docs/tecnologias.md)
* [Wireframes](docs/wireframes.md)
* [Construção das paredes](docs/construcao-paredes.md)
* [Arquitetura e regras implementadas](docs/arquitetura.md)

## Integrantes

* Luis Eduardo Verardi
* Thobias Cavalli
* Joe Sander
* João Gabriel Silvestrin
