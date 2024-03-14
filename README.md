# SocialCodeApp
Simple social platform where people can post awesome code fragments with beautiful highlighting.

### Descripción del proyecto
SocialCodeApp es una aplicación que sirve como plataforma para el intercambio de publicaciones relacionadas con programación. Su principal atractivo es su editor soportando muchos lenguajes populares,(pudiera ser muchos más pero pasar a mano a un diccionario los casi cien lenguajes de la biblioteca de highligthting era demasiado tedioso) y permitiendo que los fragmentos de códigos mostrados en las publicaciones se asemejen lo más posible al aspecto que tendrían en un editor de código.

### Intrucciones para configurar y ejecutar el proyecto localmente:

1. Clone el repositorio a su computadora.
2. Abra la carpeta social_code_app en VS Code.
3. Abra una terminal desde el directorio raíz y ejecute los comandos:
- flutter pub get 
- flutter pub build
  Esto le instalará todas las dependencias del proyecto.
4. Ejecute el archivo "lib/main.dart".
5. Seleccione el emulador Android o dispositivo físico que planea usar.
6. Se necesita conexión a Internet y se recomienda usar una buena VPN, pues el backend utilizado fue Firebase.


### Breve explicación de las decisiones y arquitectura:
Para garantizar la escalabilidad del software, el desacoplamiento e intentar mantener el mayor nivel de abstracción posible se decidió utilizar una arquitectura Clean, arquitectura totalmente centrada en la idea de separación de responsabilidades y muy popular en el desarrollo de aplicaciones móviles en la actualidad. Se suma a esto, que en mi condición de recién graduado tampoco es que tenga demasiada experiencia en el uso de variadas arquitecturas de software, aunque me siento muy cómodo trabajando con Clean.


Se trabajó con Firebase como backend, específicamente con los servicios de Authentication para el registro y autenticación de los usuarios, Firestore Database para el manejo de datos en tiempo real y Storage para el almacenamiento de archivos de usuarios.

Se usó BLoC como gestor de estados y GetIt como inyector de dependencias aunque una vez empezado el proyecto me arrepentí pues pienso que riverpod hubiera sido mucho más cómodo para trabajar con tantos Stream y hubiese simplificado mucho más el código.

### Cumplimiento de Requisitos:

* Registro y Autenticación:

Actualmente la aplicación cuenta con registro y autenticación con contraseña y correo electrónico.


La lógica para la autenticación con las credenciales de Google también se encuentra implementadas, aunque no se pudieron añadir a la UI por cuestiones de tiempo y porque java para generarme la llave de la aplicación me pedía actualizar la versión del plugin de gradle y pesaba demasiado.

Tampoco me dio tiempo a implementar la verificación del email y un criterio para recuperar contraseñas, aunque a futuro es algo que se hace rápido.

* Publicación de mensajes y likes:

Actualmente la aplicación permite chatear en tiempo real aunque desde un solo chat.

Los usuarios de este chat pueden publicar, eliminar mensajes y dar like a otras publicaciones.

Las publicaciones admiten tantos fragmentos de código como de texto se deseen. Tan solo, presiona icono que tiene esta forma <> y selecciona el tipo de lenguaje que deseas que interprete el editor a la hora de publicarlo. El lenguaje por defecto es text, texto normal.

Todos estos features son extensibles, lo que se garantiza a través de la implementación de las interfaces(repositorios) que sirven como contratos para la comunicación entre capas y los usecases que agregan un nivel de abstracción para luego aplicar el principio de inversión de dependencias.

En cuanto a requisitos no funcionales la arquitectura utilizada nos proporciona estas ventajas.

### Calidad del código

Se intento hacer un buen uso de las buenas prácticas de programación y una aplicación correcta de los principios SOLID, factorización y reutilización de código, así como patrones de diseño de software.

### Diseño y Arquitectura

Creo que esto ya se abarcó. Aun así, si quisiera saber más o hacerme una pregunta más en detalle, me contacta y encantado.

### Experiencia de Usuario:

Se intento usar un diseño minimalista. Normalmente es más fácil hacer algo bonito cuando alguien t dice como quiere que se vean las cosas.

La aplicación consta de 5 rutas: 
* Home: página que muestra el chat y permite interactuar y emitir publicaciones.
* Popular: que muestra las publicaciones más populares de acuerdo al criterio implementado.
* Profile: que permite personalizar el perfil del usuario aunque la mayoría de funcionalidades las desactivé por dudas principalmente:
 Si un usuario borra su perfil, debería borrar sus publicaciones? En una plataforma donde se comparte código esto me parece un crimen. En mi opinión se podría tener un usuario especial "usuario invitado" para manejar estos casos pero no me decidí.

 ### Documentación: 

 No sé si esto es la bibliografía que usé? 
 En su mayoría Flutterfire, que es el conjunto de plugins de Firebase para Flutter. 

 Si la ejecución falla hagan flutter clean y repitan el proceso de nuevo.
 Es que yo borré las dependencias para que no pese el proyecto.
 