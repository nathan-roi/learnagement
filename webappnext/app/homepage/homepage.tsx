// Composant de la homepage
// Affiche la page principale avec la charge de cours et les compétences
// Props: Aucune
// Composants importés:
// - ListCardsCharge: Composant pour afficher la charge de cours
// - ListFilieres: Composant pour afficher les filières
// - Loader: Composant d'indicateur de chargement

import {useSession} from "next-auth/react";
import {Suspense, useEffect} from "react";
import {useRouter} from "next/navigation";

import ListCardsCharge from "@/app/homepage/charge/listCardsCharge";
import ListFilieres from "@/app/filieres/listFilieres"

/**
 * Composant de la homepage
 * Affiche la page principale avec la charge de cours et les compétences
 * 
 * @returns {JSX.Element} Composant React
 */
export default function Homepage(){
    const {data: session, status} = useSession()
    const router = useRouter()

    useEffect(() => {
        if(status == 'unauthenticated'){
            router.push('/connection')
        }
    }, [session, router]);

    return(
        <>
            {session && <h1>Bonjour, {session.user.firstname} ! 👋</h1>}
            <div className={"h-screen flex flex-col items-center justify-around"}>
                <div className={"w-full self-start"}>
                    <h3>Ma charge de cours</h3>
                    <ListCardsCharge />
                </div>
                <div className={"w-full self-start"}>
                    <h3>Compétences par filières</h3>
                    <ListFilieres />
                </div>
            </div>
        </>
    )
}