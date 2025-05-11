// Composant du menu latéral
// Affiche le menu de navigation de l'application
// Props: Aucune
// Composants importés:
// - LinkHomepage: Lien vers la homepage
// - ListModules: Liste des modules
// - Disconnection: Bouton de déconnexion
// - Loader: Composant d'indicateur de chargement

import Link from "next/link";
import LinkHomepage from "@/app/homepage/linkHomepage";
import ListModules from "@/app/modules/listModules";
import Disconnection from "@/app/connection/disconnection";
import {Suspense} from "react";
import Loader from "@/app/indicators/loading";

/**
 * Composant du menu latéral
 * Affiche le menu de navigation de l'application
 * 
 * @returns {JSX.Element} Composant React
 */
export default function sideMenu(){
    return (
        <aside className={"h-screen col-span-1 p-2.5 bg-usmb-dark-blue text-white"}>
            <Link href={'/homepage'}><LinkHomepage /></Link>
            <Suspense fallback={<Loader />}>
                <ListModules />
            </Suspense>
            <Disconnection />
        </aside>
    )
}