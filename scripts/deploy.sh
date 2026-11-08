
#!/bin/bash
# Permet d'exécuter le script avec Bash.

set -e
# Arrête le script si une commande rencontre une erreur.

SITE_DIR="$HOME/serveur/site-equipe"
# Indique le chemin du dossier du site de notre équipe.

if [ ! -d "$SITE_DIR" ]; then
# Vérifie si le dossier du site existe.

    echo "Erreur : le dossier du site n'existe pas."
    # Affiche un message si le dossier est introuvable.

    exit 1
    # Arrête le script en cas d'erreur.

fi
# Termine la vérification du dossier.

cd "$SITE_DIR"
# Se déplace dans le dossier du site.

git pull
# Récupère les dernières modifications depuis GitHub.

cp index.html style.css /var/www/html/
# Copie les fichiers HTML et CSS vers le serveur web.

echo "Déploiement terminé avec succès !"
# Affiche un message de confirmation.
