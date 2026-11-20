# TP 3 — Docker : votre site dans un conteneur

Site du groupe **LesPtitChousB1**, servi par Nginx dans un conteneur Docker. Suis les étapes du cours dans l'ordre. Sur Windows, les commandes Docker ci-dessous peuvent être exécutées dans PowerShell ou le terminal Codex, depuis la racine du dépôt. `uname -r` est une commande Linux : exécute-la dans le conteneur ou dans Ubuntu/WSL.

## Étape 0 — Installer et vérifier Docker

Dans Ubuntu/WSL, si Docker n'est pas encore installé :

```sh
sudo apt update
sudo apt install -y docker.io
sudo service docker start
sudo usermod -aG docker $USER
newgrp docker
docker --version
docker ps
```

Si tu utilises Docker Desktop, ne réinstalle pas Docker dans Ubuntu : dans Docker Desktop, active **Settings > Resources > WSL integration > Ubuntu**, puis rouvre Ubuntu. Dans PowerShell ou le terminal Codex, vérifie le moteur avec `docker ps`.

## Étape 1 — Premier conteneur

```sh
docker run hello-world
docker images
docker ps
docker ps -a
```

Le message « Hello from Docker! » confirme que le moteur a téléchargé l'image et lancé le premier conteneur. `docker ps` affiche les conteneurs en cours ; `docker ps -a` affiche aussi ceux qui sont terminés.

## Étape 2 — Nginx dans un conteneur

```sh
docker run -d --name web -p 8080:80 nginx:alpine
docker ps
curl http://localhost:8080
```

Ouvre ensuite `http://localhost:8080` dans le navigateur. L'option `-p 8080:80` relie le port 8080 de la machine au port 80 de Nginx dans le conteneur. Si le nom `web` ou le port est déjà pris, supprime l'ancien conteneur (`docker rm -f web`) ou choisis un port libre.

## Étape 3 — Consulter et explorer le conteneur

Recharge la page sur le port 8080, puis consulte les accès et entre dans le conteneur :

```sh
docker logs web
docker exec -it web sh
```

Dans le conteneur, essaie les commandes du cours :

```sh
cat /etc/os-release
ls /usr/share/nginx/html
ps
uname -r
exit
```

Compare `uname -r` dans le conteneur et sur le serveur : le noyau est celui du serveur, car le conteneur partage le noyau de l'hôte.

## Étape 4 — Construire l'image du site

Le `Dockerfile` à la racine part de `nginx:alpine`, copie `index.html` et `style.css` dans `/usr/share/nginx/html/`, puis indique `EXPOSE 80`.

Depuis ce dossier (sous WSL, va dans le dossier où se trouvent ces fichiers), construis puis lance le site :

```powershell
docker build -t site-equipe .
docker images
docker run -d --name site -p 8081:80 site-equipe
docker ps
curl.exe http://localhost:8081
```

Ouvre `http://localhost:8081`. Sur Mac ou une machine virtuelle séparée, utilise l'adresse IP du serveur au lieu de `localhost`. Si le port 8081 est occupé, utilise `-p 8082:80` et ouvre `http://localhost:8082`.

Après une modification du site, reconstruis l'image et remplace le conteneur :

```sh
docker build -t site-equipe .
docker stop site && docker rm site
docker run -d --name site -p 8081:80 site-equipe
```

## Étape 5 — Arrêter et nettoyer

Le cours demande de conserver le conteneur `site` en marche pour le rendu. Le conteneur `web` de l'exercice Nginx peut être arrêté et supprimé :

```sh
docker stop web
docker ps -a
docker start web
docker stop web
docker rm web
```

Pour arrêter et supprimer `site` plus tard : `docker stop site` puis `docker rm site`.

## Réponses à remettre

1. **Quelle est la différence entre une image et un conteneur ?** Une image est le modèle contenant l'application et ses fichiers. Un conteneur est une instance lancée à partir de cette image ; plusieurs conteneurs peuvent provenir de la même image.
2. **Que signifie `-p 8081:80` ?** Cela relie le port 8081 de l'hôte au port 80 du conteneur. Le site est donc accessible dans le navigateur sur `http://localhost:8081`.
3. **Pourquoi `uname -r` donne-t-il le même résultat dedans et dehors ?** Le conteneur partage le noyau Linux de l'hôte. Il isole l'application et ses fichiers, mais ne démarre pas un noyau complet comme le ferait une machine virtuelle.

## Éléments demandés pour le rendu

- Capture du navigateur montrant le site sur le port 8081 et son adresse.
- Capture du terminal montrant `docker ps` avec le conteneur `site` en cours.
- Lien de la pull request de l'équipe contenant le Dockerfile, si vous travaillez avec le dépôt Git du cours.

Ces captures et le lien de pull request sont à produire depuis le serveur et le dépôt de votre cours.
