# Conduit – projet ALTN72

Conduit est un clone de Medium (blogging) issu du projet [RealWorld](https://github.com/gothinkster/realworld).
Ce dépôt regroupe deux projets open source, modifiés pour ce cours (voir [Origine du code](#origine-du-code)) :

| Dossier     | Dépôt d'origine                                                                           | Stack                              | Port |
|-------------|-------------------------------------------------------------------------------------------|------------------------------------|------|
| `backend/`  | [raeperd/realworld-springboot-java](https://github.com/raeperd/realworld-springboot-java) | Java 25, Spring Boot 4, Gradle, H2 | 8080 |
| `frontend/` | [mutoe/vue3-realworld-example-app](https://github.com/mutoe/vue3-realworld-example-app)   | Vue 3, Vite, TypeScript, pnpm      | 4173 |

## Lancer le projet

### Ouvrir le projet dans IntelliJ IDEA

Utilisez IntelliJ IDEA **Ultimate** (gratuit avec la [licence éducation JetBrains](https://www.jetbrains.com/community/education/#students)) :
l'édition Community ne gère pas Vue.js ni TypeScript.

1. *File > Open*, choisissez **la racine du dépôt** (le dossier qui contient `backend/` et `frontend/`).
   Grâce au `settings.gradle` de la racine, IntelliJ importe automatiquement le backend Gradle.
2. Le backend a besoin d'un JDK 25. S'il n'est pas installé : *File > Project Structure > Project > SDK >
   Download JDK*, version 25.
3. Le frontend utilise pnpm : dans *Settings > Languages & Frameworks > Node.js*, choisissez `pnpm` comme
   *Package manager*.

### Backend

Ouvrez la classe `io.github.raeperd.realworld.RealWorldApplication` (dans `backend/src/main/java`) et
lancez-la avec la flèche verte à côté de la méthode `main`.

L'API est disponible sur <http://localhost:8080/api> (par exemple <http://localhost:8080/api/articles>).

- La base de données est une base H2 **en mémoire** : elle est recréée et remplie par
  `src/main/resources/data.sql` à chaque démarrage. Les modifications sont perdues à l'arrêt du serveur.
- Tous les utilisateurs de `data.sql` ont le mot de passe `Password1!`. On se connecte avec l'email,
  par exemple `lambda_lucy@example.com`.
- Les requêtes SQL exécutées s'affichent dans la console (`logging.level.sql=DEBUG` dans
  `application.properties`).

### Consulter la base de données depuis IntelliJ

La base H2 est en mémoire, à l'intérieur du processus du backend. Pour qu'un outil externe puisse s'y
connecter, `RealWorldApplication#main` démarre un serveur TCP H2 sur le port 9092. La base n'est donc
accessible que **pendant que le backend tourne**.

1. Lancez le backend.
2. Ouvrez la fenêtre *Database* (*View > Tool Windows > Database*), puis *+ > Data Source > H2*.
3. Renseignez :
   - *URL* : `jdbc:h2:tcp://localhost:9092/mem:test`
   - *User* : `sa`
   - *Password* : laisser vide
4. Si IntelliJ le propose, cliquez sur *Download missing driver files*, puis *Test Connection* et *OK*.

Les tables sont dans le schéma `public`. Après un redémarrage du backend, la base est recréée : cliquez sur
*Refresh* dans la fenêtre *Database* pour voir les nouvelles données.

#### Tests et couverture de code

Dans IntelliJ : clic droit sur le dossier `backend/src/test/java` > *More Run/Debug* >
*Run 'All Tests' with Coverage*. Le pourcentage de couverture s'affiche par package et par classe dans
la fenêtre *Coverage*. Dans l'éditeur, une bande colorée dans la marge indique pour chaque ligne si elle
est couverte (vert), partiellement couverte (jaune) ou non couverte (rouge). On peut aussi lancer une
seule classe de test avec couverture : clic droit sur la classe > *More Run/Debug* > *Run with Coverage*.

En ligne de commande :

```shell
cd backend
./gradlew test
```

Le rapport JaCoCo est généré dans `backend/build/reports/jacoco/test/html/index.html`. Les chiffres
peuvent être légèrement différents de ceux d'IntelliJ, qui utilise son propre outil de mesure.

### Frontend

Prérequis : Node.js ≥ 20 et [pnpm](https://pnpm.io/) (`corepack enable` ou `npm install -g pnpm`).

Dans IntelliJ : clic droit sur `frontend/package.json` > *Show npm Scripts*, puis lancez `install` la première
fois, et `dev` pour démarrer le serveur. En ligne de commande :

```shell
cd frontend
pnpm install
pnpm dev
```

Ouvrez <http://localhost:4173>. Le frontend appelle le backend défini dans `frontend/.env`
(`VITE_API_HOST=http://localhost:8080`) : le backend doit donc être lancé.

Tests unitaires : `pnpm test:unit`.

## Origine du code

Ce dépôt est construit à partir de deux projets open source (licence MIT) :

- backend : [raeperd/realworld-springboot-java](https://github.com/raeperd/realworld-springboot-java)
- frontend : [mutoe/vue3-realworld-example-app](https://github.com/mutoe/vue3-realworld-example-app)

L'historique git des deux projets a été conservé : `git log -- backend/` ou `git log -- frontend/`
montre les commits des auteurs d'origine. Les fichiers `LICENSE` de chaque projet sont conservés dans
leur dossier.

### Modifications par rapport aux dépôts d'origine

Organisation du dépôt :

- les deux projets ont été déplacés dans `backend/` et `frontend/` d'un même dépôt ;
- ajout à la racine d'un `settings.gradle` (et du wrapper Gradle) pour ouvrir les deux projets ensemble dans
  IntelliJ. Le backend reste un projet Gradle autonome : `cd backend && ./gradlew ...` fonctionne toujours ;
- suppression des fichiers inutiles ici : configurations GitHub Actions et dependabot (`.github/`),
  `frontend/CLAUDE.md`, `frontend/FRONTEND_INSTRUCTIONS.md`.

Frontend :

- `.env` pointe vers le backend local (`http://localhost:8080`) au lieu de l'API publique
  `https://api.realworld.show`.

Backend :

- **Configuration** : l'API est servie sous `/api` (`server.servlet.context-path`), et le CORS autorise
  le frontend sur `http://localhost:4173`.
- **Accès à la base** : `RealWorldApplication#main` démarre un serveur TCP H2 (port 9092) pour consulter
  la base en mémoire depuis IntelliJ. La dépendance H2 passe de `runtimeOnly` à `implementation`.
- **Données d'exemple** : `src/main/resources/data.sql` remplit la base au démarrage (utilisateurs,
  articles, commentaires, tags, favoris, abonnements).
- **Renommage des modèles de réponse** : les records `XyzModel` / `XyzModelNested` sont devenus
  `XyzResponse` (l'enveloppe JSON, par exemple `{"article": {...}}`) et `XyzDTO` (les données), par
  exemple `ArticleResponse(ArticleDTO article)`. Le JSON produit n'a pas changé.
- **Pagination** : les paramètres `offset` et `limit` de `GET /api/articles` sont maintenant
  interprétés comme dans la spécification RealWorld (`offset` = nombre d'articles à sauter) grâce à
  `OffsetLimitRequest`, et les articles sont triés du plus récent au plus ancien. Avant, `offset` était
  utilisé comme un numéro de page.
- **Erreurs 403 à la place des 500** : quand une requête échouait, Spring Security bloquait le
  renvoi vers la page `/error` et le client recevait un 403 au lieu de l'erreur d'origine. Voir
  `SecurityConfiguration` et `ErrorDispatchTest`.
