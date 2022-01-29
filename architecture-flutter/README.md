# Módulos Flutter

Para compilar o projeto nativo, é necessário antes gerar o build dos módulos
```sh
sh build.sh
```

Caso queira atualizar apenas 1 módulo, passe o nome do módulo como  
```sh
sh build.sh task
```

Existem também, uma opção para tirar a dependência do Flutter dos módulos, uma vez que irá usar o módulo estrutural: `--separate-flutter`