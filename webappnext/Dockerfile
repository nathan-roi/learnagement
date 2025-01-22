# Utiliser l'image officielle de Node.js
FROM node:18-alpine

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers nécessaires pour installer les dépendances
COPY package.json package-lock.json ./

# Supprimer les dépendances existantes et les réinstaller
RUN npm install

# Copier tout le code de l'application dans l'image
COPY . .

# Exposer le port 3000 pour le serveur Next.js
EXPOSE 3000

# Commande par défaut pour Docker Compose
CMD ["npm", "run", "dev"]