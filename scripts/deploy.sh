
#!/bin/bash
# Indique que ce script doit être exécuté avec Bash.

set -e
# Arrête le script immédiatement si une commande échoue.

SITE_DIR="$HOME/serveur/site-equipe"
# Définit le chemin du dossier contenant le site de notre équipe.

if [ ! -d "$SITE_DIR" ]; then
# Vérifie si le dossier du site existe.

    echo "Erreur : le dossier du site n'existe pas."
    # Affiche un message si le dossier est introuvable.

    exit 1
    # Arrête le script avec un code d'erreur.

fi
# Termine la vérification du dossier.

cd "$SITE_DIR"
# Entre dans le dossier du site de notre équipe.

git pull
# Récupère les dernières modifications depuis GitHub.

cp index.html style.css /var/www/html/
# Copie les fichiers HTML et CSS dans le dossier du serveur web.

echo "Déploiement terminé avec succès !"
# Affiche un message pour confirmer la fin du déploiement.
