# sonar-objective-c-sample

A solução contempla a utilização das seguintes ferramentas, docker, jenkins e sonarqube.

Também existem as gems que são necessárias, aconselho a manter seu ruby atualizado, as gems são as seguintes: oclint, xcpretty, xcodebuild, lizard, slather e sonar-scanner.
Apenas utilizando "gem install gemDesejada" no terminal já da cabo do assunto.

Executar também:

xcode-select --install

É necessário baixar o docker e seguir as indicações do próprio docker para a instalação dos containers que conterão tanto jenkins quanto sonarqube.

Para baixar e configurar o sonarqube no docker é necessário inserir o comando:

docker pull sonarqube:6.7.4 

(:6.7.4 é a versão desejada atualmente|10/08/2018, também poderia ser utilizado apenas o sonarqube sem especificação de versão, pegando assim a mais atual)

e após isso 

docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:6.7.4

Já para o Jenkins

instalar o java (JDK) mais atual

baixar o executável do Jenkins LTS no site do mesmo

após instalação abrir terminal e executar:

export JAVA_HOME=`/usr/libexec/java_home -v 1.8` e ou adicionar ao ~/.bash-profile

após isso executar o comando

java -jar /Applications/Jenkins/jenkins.war

Na primeira vez q é iniciado um novo jenkins, é necessário pegar a chave gerada neste caminho: /var/jenkins_home/secrets/initialAdminPassword e utilizar ao acessar pela primeira vez o localhost:8080.

Após isso ambientes estarão parcialmente prontos.

Podendo assim serem acessados por localhost:8080 (jenkins) e localhost:9000 (sonarqube)

Para prosseguimento de um projeto em objective-c é necessário que seja instalado o plugin backelite-sonar-objective-c-plugin no sonarqube, este pode ser encontrado no github backelite/sonar-objective-c

após este ser baixado é necessário que seja acessado pelo terminal o diretório onde esteja localizado o plugin e, lembrando que esse caminho esta utilizando a versão atual do plugin como demonstração:

docker cp backelite-sonar-objective-c-plugin-0.6.2.jar sonarqube:opt/sonarqube/extensions/plugins

Logo após isso, é necessário que o sonarqube seja restartado

docker restart sonarqube

Para prosseguir é necessário que no projeto iOS você vá em edit scheme e na opção Test entre em Options, selecione "Gather coverage for" e selecione all targets
Ah, e também marque o Scheme como Shared

não esqueça do arquivo sonar-project.properties configurado como deve para o seu projeto, este arquivo com modelo a ser seguido pode ser encontrado na raiz deste projeto.

Após instalação é necessário que seja adicionado ao diretório do projeto o script, que o próprio plugin fornece, chamado run-sonar.sh

Bom, depois de tudo isso, abra o terminal, de um cd para o diretorio raiz do seu projeto onde estão localizados run-sonar.sh e sonar-project.properties

Ve no que dá, se tudo foi configurado direitinho, e não tivemos nenhuma grande atualização no ambiente do xcode, deve dar tudo certo.

Foi? Sem erro?

Confere no sonarqube, lembrando que é localhost:9000

admin:admin normalmente é o acesso padrão inicial

Apareceu o projeto lá? Show, agora podemos ir para a parte do Jenkins

Vá no jenkins, localhost:8080

Após entrar no jenkins, acesse a opção de "new freestyle project", de um nome para o projeto, siga adiante.



Nesta primeira etapa você pode deixar algumas informações especificando um pouco sobre o projeto

![alt text](https://i.imgur.com/vJIhFwe.png)



Já nesta você precisa configurar o ambiente git (repositório e branch desejada), caso o repositório seja privado será necessário adicionar suas credenciais de git no Jenkins e dps selecioná-las posteriormente nesta opção.

Lembrando que você pode adicionar inúmeros repositórios para serem checados com essa mesma rotina

![alt text](https://i.imgur.com/uTQ3Gtn.png)



Aqui eu adiciono um tempo médio de checagem do repositório, desta maneira ai ajustada ele fica checando de 5 em 5 minutos por commits e também decidi que gostaria de limpar todo o workspace a cada novo update de codigo.

![alt text](https://i.imgur.com/Ocsb8yt.png)



Esta opção é onde você adiciona o codigo shell necessário, caso seja do seu interesse, dessa forma acabei optando por copiar o diretório onde o Jenkins baixa a aplicação, dentro do seu ambiente, e colei em um diretório fora do ambiente do Jenkins e posteriormente acesso a pasta e mando rodar o script shell que indiquei logo no inicio deste tutorial.

![alt text](https://i.imgur.com/NxcRjdQ.png)



PRONTO

Feito isso, a cada novo commit na branch configurada no Jenkins, o mesmo detecta e manda rodar sua rotina de build, no meu caso foram aqueles comandos shell, assim que chega no ./run-sonar.sh ele inicia o processo de build do projeto, teste e a geração de relatórios, tudo dando certo ele já envia todos esses para o sonarqube e vualá.
