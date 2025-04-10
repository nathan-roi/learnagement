"use client"

import axios from "axios";
import { useInfosModuleStore } from "@/app/store/useInfosModuleStore";

import Disconnection from "@/app/connection/disconnection";
import ListModules from "@/app/modules/listModules";
import InfosModule from "@/app/modules/infosModule"
import Homepage from "@/app/homepage/homepage";
import LinkHomepage from "@/app/homepage/linkHomepage";

export default function Home() {
    axios.defaults.withCredentials = true // Autorise le partage de cookies (fonctionne pour les composants enfants)
    const { module } = useInfosModuleStore()

    function shownHomepage(){
        return module.code_module === "";
    }

    return (
        <>
            <main className={"h-screen grid grid-cols-4"}>
                <aside className={"h-screen col-span-1 p-2.5 bg-usmb-dark-blue text-white"}>
                    <LinkHomepage />
                    <ListModules homepageShown= {shownHomepage()} />
                    <Disconnection />
                </aside>
                {/*Si aucun module affiché alors homepage s'affiche sinon le module*/}
                {shownHomepage() ?
                    <div className={"col-span-3 overflow-y-auto"}>
                        <Homepage />
                    </div>
                    :
                    <div className={"col-span-3 overflow-y-auto"}>
                        {Object.keys(module).length > 0 && <InfosModule />}
                    </div>
                }
          </main>
      </>
    );
}