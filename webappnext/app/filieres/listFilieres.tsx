// Composant des filières
// Affiche la liste des filières et gère l'ouverture de la modale
// Props: Aucune
// Composants importés:
// - ModaleFiliere: Composant de la modale
// - polytechLogo, usmbLogo: Images des logos
// - Loader: Composant d'indicateur de chargement

import axios from "axios";
import {useEffect, useState} from "react";

import ModaleFiliere from "@/app/filieres/modaleFiliere";
import Loader from "@/app/indicators/loading";

import polytechLogo from "@/public/logos/Logo_Reseau_Polytech.svg";
import usmbLogo from "@/public/logos/Logo_USMB_web_grand_RVB.png";



/**
 * Composant des filières
 * Affiche la liste des filières et gère l'ouverture de la modale
 * 
 * @returns {JSX.Element} Composant React
 */
export default function ListFilieres({filieres} : {filieres: Filiere[]}){
    const [nomFiliereClicked, setNomFiliereClicked] = useState<string[]>([])
    const [isLoading, setIsLoading] = useState(false)

    function filiereClicked(str: string){
        let filiere:Filiere|undefined = filieres.find((element: Filiere): boolean => str == element.nom_filiere)

        if(filiere != undefined){
            let nom_long:string = ""
            if(filiere.nom_long != undefined){
                nom_long = filiere.nom_long
            }
            setNomFiliereClicked([filiere.nom_filiere, nom_long])
        }
    }

    if (isLoading){
        return <Loader />

    }else{
        return (
            <>
                <div className='w-full flex flex-wrap justify-center items-center gap-6'>
                    {filieres.map((filiere) => (
                            <div
                                key={filiere.nom_filiere}
                                className="
                                    h-28 w-1/4 group cursor-pointer flex flex-col justify-center items-center
                                    text-center shadow-md shadow-[rgba(193,193,193,0.45)] rounded-lg p-2 my-2
                                    border border-[#e5e7eb] hover:bg-usmb-dark-blue hover:border-usmb-dark-blue
                                "

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
                    ))}
                </div>
                {nomFiliereClicked.length > 0 && (
                    <ModaleFiliere
                        nomFiliere={nomFiliereClicked}
                        setNomFiliere={setNomFiliereClicked}
                    />
                )}
            </>
        )
    }

}