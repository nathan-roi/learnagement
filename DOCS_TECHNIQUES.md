# Documentation Technique - Learnagement

## Architecture du Projet

### Vue d'ensemble
Learnagement est une application web fullstack composée de deux parties principales :

1. **Backend (webApp)**
   - Architecture PHP traditionnelle
   - Gestion des données via des fichiers PHP
   - Système de CRUD (Create, Read, Update, Delete)

2. **Frontend (webappnext)**
   - Framework Next.js
   - Styling avec Tailwind CSS
   - Typage avec TypeScript

### Architecture Backend

#### Structure des Dossiers
```
webApp/
├── connection/         # Gestion des connexions
├── crud/              # Opérations CRUD
├── db_connection/     # Connexions à la base de données
├── image/            # Gestion des images
├── inc/              # Fichiers inclus
├── list/             # Listes de données
├── select/           # Requêtes SELECT
└── *.php             # Fichiers principaux
```

#### Composants Principaux
- `functions.php` : Fonctions utilitaires
- `functions_db.php` : Fonctions de base de données
- `functions_filter.php` : Fonctions de filtrage
- `get_data.php` : Récupération de données
- `login.php` : Authentification

### Architecture Frontend

#### Structure des Dossiers
```
webappnext/
├── app/              # Pages et composants Next.js
├── lib/              # Bibliothèques utilitaires
├── public/           # Assets statiques
└── config/           # Fichiers de configuration
```

#### Technologies Frontend
- **Next.js** : Framework React pour le rendu côté serveur
- **Tailwind CSS** : Framework CSS utilitaire
- **TypeScript** : Typage statique pour JavaScript

#### Gestion des Données
1. **État et Requêtes**
   - Utilisation de `useState` pour gérer l'état local
   - Utilisation de `axios` pour les requêtes HTTP
   - Typage TypeScript pour les données

2. **Navigation**
   - Utilisation de `useRouter` de Next.js
   - Routes principales : `/` (accueil) et `/connection`
   - Navigation programmée via `router.push()`

### Communication Front/Back

#### Système de Proxy
1. **Structure**
   - Implémenté dans `/app/api/proxy/[...phpPath]/route.ts`
   - Gère les requêtes GET et POST
   - Redirige vers le backend PHP

2. **Fonctionnement**
   ```typescript
   // Exemple de requête depuis le frontend
   axios.get('/api/proxy/get_filieres')
   ```
   - Capture la requête
   - Récupère le chemin après `/api/proxy/`
   - Redirige vers le backend (`http://php/get_filieres.php`)
   - Transfère les headers et le corps
   - Retourne la réponse au frontend

3. **Gestion des Headers**
   - Transfert des headers Content-Type
   - Maintien des cookies via le header
   - Configuration withCredentials: true

4. **Gestion des Erreurs**
   - Capture des erreurs avec `.catch()`
   - Affichage des messages d'erreur
   - Gestion des états de chargement

#### Communication avec le Backend
1. **Requêtes GET**
   - Utilisation de `axios.get()`
   - Exemple : `/api/proxy/get_filieres`
   - Retourne les données en JSON

2. **Requêtes POST**
   - Utilisation de `axios.post()`
   - Transmet les données dans le corps
   - Exemple : `/api/proxy/update_filiere`

3. **Gestion des Données**
   - Typage avec TypeScript
   - Gestion des états avec useState
   - Chargement asynchrone avec useEffect

#### Gestion des Sessions
1. **Cookies**
   - Transmis via les headers
   - Maintient la session PHP
   - Permet l'authentification

2. **Navigation**
   - Utilisation de `useRouter`
   - Routes principales : `/` et `/connection`
   - Navigation programmée via `router.push()`

### Ajout de Nouvelles Fonctionnalités

#### Frontend
1. **Créer un Nouveau Composant**
   - Créer un nouveau fichier dans `/app`
   - Utiliser TypeScript pour le typage
   - Utiliser Tailwind CSS pour le styling
   - Implémenter la logique avec `useState` et `useEffect`

2. **Ajouter une Nouvelle Route**
   - Créer un nouveau dossier dans `/app`
   - Implémenter la logique de la page
   - Configurer la navigation

#### Backend
1. **Gérer une nouvelle table SQL**
   - Créer un nouveau fichier PHP dans `/crud`
   - Implémenter les fonctions CRUD

2. **Accéder au données de la nouvelle table**
   - Créer un nouveau fichier PHP dans le dossier correspondant ex: `select`, `list` etc...
   - Implémenter la logique de la requête
   - Renvoyer les données au format JSON

### Meilleures Pratiques

1. **Frontend**
   - Utiliser TypeScript pour le typage
   - Séparer la logique et le style
   - Utiliser les composants réutilisables
   - Gérer les états de chargement

2. **Backend**
   - Utiliser les fonctions existantes
   - Gérer les erreurs
   - Maintenir la cohérence des données
   - Documenter les nouvelles fonctions
