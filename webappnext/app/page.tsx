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

import Loader from '@/app/indicators/loading';
import ModaleFiliere from "@/app/homepage/competences/modaleFiliere";

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
  const [nomFiliereClicked, setNomFiliereClicked] = useState<string[]>([])
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    setIsLoading(true);
  
    axios.get('/api/proxy/list/listAllFilieres', {withCredentials: true})
      .then((response) => {
        console.log('Données reçues:', response.data);  // Ajoute cette ligne pour voir les données
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

  function filiereClicked(str: string){
    let filiere:Filiere|undefined = filieres.find((element: Filiere): boolean => str == element.nom_filiere)

    if(filiere != undefined){
      setNomFiliereClicked([filiere.nom_filiere, filiere.nom_long])
    }
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

      <div className='h-[88%] pt-[2%] pb-[2%] grid grid-cols-3'>
        <div className='col-span-3 border-r-[1px] border-[#C6C6C6] px-4'>
          <div className='text-black opacity-50 italic'>Résultats</div>
          <div className='flex flex-row flex-wrap gap-6 justify-center h-full overflow-y-auto'>

              {isLoading ? (
                <Loader />
              ) : filteredFilieres.length === 0 ? (
                <div className='text-gray-400 italic'>Aucune filière trouvée</div>
              ) : (
                filteredFilieres.map((filiere, index) => (
                <div
                  key={filiere.id ?? filiere.nom_filiere ?? index}
                  className="group cursor-pointer flex flex-col justify-center items-center
                  text-center
                  shadow-md shadow-black/30 rounded-lg p-2 my-2 h-1/6 w-1/4
                  border border-[#C6C6C6] hover:bg-usmb-dark-blue hover:border-usmb-dark-blue"

                  onClick={(): void => {
                    filiereClicked(filiere.nom_filiere);
                  }}
                >
                  <p className="text-black text-2xl font-bold group-hover:text-white">
                    {filiere.nom_filiere}
                  </p>
                  <p className="text-gray-400 text-xs ">
                    {filiere.nom_long}
                  </p>
                </div>
                ))
              )}
          </div>
        </div>

        {/*<div className='col-span-1 px-4'>*/}
        {/*  <div className='text-black opacity-50 italic'>Dernières pages consultées</div>*/}
        {/*</div>*/}
      </div>
      {nomFiliereClicked.length > 0 && (
          <ModaleFiliere
              nomFiliere={nomFiliereClicked}
              setNomFiliere={setNomFiliereClicked}
          />
      )}
    </main>
  );
}

