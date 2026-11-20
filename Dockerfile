# Image nginx légère déjà prête à l'emploi
FROM nginx:alpine

# Copie les fichiers du site dans le dossier publié par nginx
COPY index.html style.css /usr/share/nginx/html/

# Le site est servi sur le port 80 du conteneur
EXPOSE 80
