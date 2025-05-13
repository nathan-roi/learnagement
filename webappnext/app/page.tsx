// Composant principal de l'application
// Affiche la page d'accueil avec la liste des filières
// Props: Aucune
// Composants importés:
// - Loader
// - ModaleFiliere

'use client';

import axios from 'axios';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';

import ListFilieres from "@/app/filieres/listFilieres";
import Loader from "@/app/indicators/loading";

/**
 * Composant principal de l'application
 * Affiche la page d'accueil avec la barre de recherche et la liste des filières
 * 
 * @returns {JSX.Element} Composant React
 */
export default function Home() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState('');
  const [filieres, setFilieres] = useState<Filiere[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    setIsLoading(true);
  
    axios.get('/api/proxy/list/listAllFilieres', {withCredentials: true})
      .then((response) => {
        setFilieres(response.data);
        setIsLoading(false);
      })
      .catch((err) => {
        console.error('Erreur lors du fetch des filières :', err);
        setIsLoading(false);
      });
  }, []);
  

  const filteredFilieres = filieres.filter((filiere) =>
    filiere.nom_filiere.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const goToConnection = () => {
    router.push('/connection');
  }

  return (
    <main className='w-screen h-screen'>
      <header className='bg-usmb-dark-blue h-[12%] w-full grid grid-cols-4'>
        <div className='col-span-1 h-full flex justify-center content-center flex-wrap'>
          <div className='text-white text-2xl font-bold'>
            <a href='https://www.univ-smb.fr/' className='cursor-pointer'>USMB</a>
          </div>
        </div>

        <div className='col-span-2 h-full flex content-center flex-wrap'>
          <input
            type='text'
            id='research'
            placeholder='Rechercher une filière'
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className='w-full rounded-full h-1/2 shadow-inner px-4'
          />
        </div>

        <div className='col-span-1 h-full flex justify-center content-center flex-wrap'>
          <svg
            onClick={goToConnection}
            className='cursor-pointer h-6 w-6'
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
          >
            <path fill="#ffffff" d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512l388.6 0c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304l-91.4 0z"/>
          </svg>
        </div>
      </header>
      {isLoading ? <Loader /> : <ListFilieres filieres={filteredFilieres} />}
    </main>
  );
}

