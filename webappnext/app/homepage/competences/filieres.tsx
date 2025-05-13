// Composant des filières
// Affiche la liste des filières et gère l'ouverture de la modale
// Props: Aucune
// Composants importés:
// - ModaleFiliere: Composant de la modale
// - polytechLogo, usmbLogo: Images des logos
// - Loader: Composant d'indicateur de chargement

import axios from "axios";
import {useEffect, useState} from "react";

import ModaleFiliere from "@/app/homepage/competences/modaleFiliere";
import polytechLogo from "@/app/images/Logo_Reseau_Polytech.svg";
import usmbLogo from "@/app/images/Logo_USMB_web_grand_RVB.png";

import Loader from "@/app/indicators/loading";

/**
 * Composant des filières
 * Affiche la liste des filières et gère l'ouverture de la modale
 * 
 * @returns {JSX.Element} Composant React
 */
export default function Filieres(){
    const [nomFilieres, setNomFilieres] = useState<string[]>([])
    const [nomFiliereClicked, setNomFiliereClicked] = useState([])
    const [isLoading, setIsLoading] = useState(true)

    useEffect(() => {

        axios.get('/api/proxy/select/selectFilieres', {withCredentials: true})
            .then(response => {
                if (response.status == 200){
                    setNomFilieres(response.data)
                    setIsLoading(false)
                }else{
                    console.log('error : filiere.tsx')
                }
            })

    }, []);

    function filiereClicked(str: string){
        let res:any = nomFilieres.find((element: string): boolean => str == element[0])
        if(res != undefined){
            setNomFiliereClicked(res)
        }
    }

    if (isLoading){
        return <Loader />
    }else{
        return (
            <>
                <div id="cards-container" className={"w-full px-3 flex flex-wrap justify-center gap-10 gap-y-8"}>
                    {nomFilieres.length > 0 ? (
                        nomFilieres.map((nom: string, index: number) => (
                            <div
                                key={index}
                                onClick={(): void => {
                                    filiereClicked(nom[0]);
                                }}
                                className={
                                    "w-60 h-16 flex justify-start items-center rounded-lg shadow-default cursor-pointer gap-2 px-2"
                                }
                            >
                                <img
                                    src={nom[0] === "POLYTECH" ? polytechLogo.src : usmbLogo.src}
                                    alt="logo"
                                    className="w-8 h-8 object-contain"
                                />
                                <p className={"font-semibold"}>{nom[0]}</p>
                            </div>
                        ))
                    ) : (
                        <p>Aucune filière disponible.</p>
                    )}
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