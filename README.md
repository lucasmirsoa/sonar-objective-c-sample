# sonar-objective-c-sample

### Objetivo

Automatizar testes e levantar estatísticas de um projeto desenvolvido em Objetive-c.

### Quais ferramentas foram utilizadas?

A solução contempla a utilização das seguintes ferramentas, docker, jenkins e sonarqube.

Também existem as gems que são necessárias, aconselho a manter seu ruby atualizado, as gems são as seguintes: oclint, xcpretty, lizard, slather e sonar.

### Iniciando a integração da solução

1. Instalações
* xcode-select --install
* \curl -sSL https://get.rvm.io | bash -s stable --ruby
* rvm install ruby
* gem install xcpretty
* gem install lizard
* gem install slather
* gem install sonar
* gem install oclint
> Caso você decida instalar o docker como eu, acesse o portal do docker e vá ná área de downloads.

2. Para baixar e configurar o sonarqube no docker é necessário inserir o comando:

* docker pull sonarqube:6.7.4 
* docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:6.7.4
> (:6.7.4 é a versão desejada atualmente|10/08/2018, também poderia ser utilizado apenas o sonarqube sem especificação de versão, pegando assim a mais atual), após isso é necessário rodar a imagem em algum container.

3. Já para o Jenkins é necessário instalar o java (JDK) mais atual, baixar o executável do Jenkins LTS no site do mesmo e após instalação abrir terminal e executar:

* export JAVA_HOME=`/usr/libexec/java_home -v 1.8` 
* java -jar /Applications/Jenkins/jenkins.war
> Você tambêm poderia adicionar <b>export JAVA_HOME=`/usr/libexec/java_home -v 1.8`</b> adicionar ao ~/.bash-profile
> Na primeira vez q é iniciado um novo jenkins, é necessário pegar a chave gerada neste caminho: <b>/var/jenkins_home/secrets/initialAdminPassword</b> e utilizar ao acessar pela primeira vez o <b>localhost:8080</b>
> Após isso, ambientes estarão parcialmente prontos podendo assim serem acessados por <b>localhost:8080</b> (jenkins) e <b>localhost:9000</b> (sonarqube)

4. Para prosseguimento de um projeto em objective-c é necessário que seja instalado o plugin backelite-sonar-objective-c-plugin no sonarqube, este pode ser encontrado no github <b>backelite/sonar-objective-c</b>

> Após este ser baixado é necessário que seja acessado pelo terminal o diretório onde esteja localizado o plugin e, lembrando que esse caminho esta utilizando a versão atual do plugin como demonstração:

* docker cp backelite-sonar-objective-c-plugin-0.6.2.jar sonarqube:opt/sonarqube/extensions/plugins
* docker restart sonarqube

  * Logo após a instalação do plugin é necessário restartar o sonarqube e após o restart você deve selecionar esta aba:
  ![alt text](https://i.imgur.com/r12j0my.png)
  * E buscar este Quality Profile para validar se foi instalado corretamente no sonarqube
  ![alt text](https://i.imgur.com/CdJF2uC.png)

5. Para prosseguir é necessário que no projeto iOS você vá em edit scheme e na opção Test entre em Options, selecione "Gather coverage for" e selecione all targets
> Ah, e também marque o Scheme como <b>Shared</b>

> Não esqueça do arquivo <b>sonar-project.properties</b> configurado como deve para o seu projeto, este arquivo com modelo a ser seguido pode ser encontrado na raiz deste projeto.

Após instalação é necessário que seja adicionado ao diretório do projeto o script, que o próprio plugin fornece, chamado run-sonar.sh

Bom, depois de tudo isso, abra o terminal, de um cd para o diretorio raiz do seu projeto onde estão localizados run-sonar.sh e sonar-project.properties

Ve no que dá, se tudo foi configurado direitinho, e não tivemos nenhuma grande atualização no ambiente do xcode, deve dar tudo certo.

Foi? Sem erro?

Confere no sonarqube, lembrando que é localhost:9000

admin:admin normalmente é o acesso padrão inicial

Apareceu o projeto lá? Show, agora podemos ir para a parte do Jenkins

Vá no jenkins, <b>localhost:8080</b>

Após entrar no jenkins, acesse a opção de "new freestyle project", de um nome para o projeto, siga adiante.



Nesta primeira etapa você pode deixar algumas informações especificando um pouco sobre o projeto

![alt text](https://i.imgur.com/vJIhFwe.png)



Já nesta você precisa configurar o ambiente git (repositório e branch desejada), caso o repositório seja privado será necessário adicionar suas credenciais de git no Jenkins e dps selecioná-las posteriormente nesta opção.

Lembrando que você pode adicionar inúmeros repositórios para serem checados com essa mesma rotina

![alt text](https://i.imgur.com/uTQ3Gtn.png)



Aqui eu adiciono um tempo médio de checagem do repositório, desta maneira ai ajustada ele fica checando de 5 em 5 minutos por commits e também decidi que gostaria de limpar todo o workspace a cada novo update de codigo.

![alt text](https://i.imgur.com/Ocsb8yt.png)



Esta opção é onde você adiciona o codigo shell necessário, caso seja do seu interesse, dessa forma acabei optando por copiar o diretório onde o Jenkins baixa a aplicação, dentro do seu ambiente, e colei em um diretório fora do ambiente do Jenkins e posteriormente acesso a pasta e mando rodar o script shell que indiquei logo no inicio deste tutorial.

![alt text](https://i.imgur.com/yUknK9i.png)



PRONTO

Feito isso, a cada novo commit na branch configurada no Jenkins, o mesmo detecta e manda rodar sua rotina de build, no meu caso foram aqueles comandos shell, assim que chega no ./run-sonar.sh ele inicia o processo de build do projeto, teste e a geração de relatórios, tudo dando certo ele já envia todos esses para o sonarqube e vualá.
