"use client";

import React, {useState, useEffect} from "react";
import axios from "axios";

import Connection from "./connection/connection";
import Disconnection from "./connection/disconnection";
import ListModules from "./listModules";
import InfosModule from "./modules/infosModule"
import Loader from "@/app/loader";

export default function Home() {
    axios.defaults.withCredentials = true // Autorise le partage de cookies (fonctionne pour les composants enfants)
    const [isConnect, setIsConnect] = useState(false)
    const [infosModule, setInfosModule] = useState({code_module:"null"})
    const [isLoading, setIsLoading] = useState(true)

    useEffect(() => {


        axios.get("http://localhost:8080/connection/isConnect.php")
            .then(response => {
                let data = response.data
                setIsConnect(data.loggedin)
                console.log(data)
                setIsLoading(false)
            })

        const handleBeforeUnload = (event: BeforeUnloadEvent) => {
            // Déclenche l'animation de rechargement
            setIsLoading(true);

            // Optionnel : Afficher une boîte de confirmation
            // Ne fonctionne pas dans tous les navigateurs modernes
            // event.preventDefault();
            setTimeout(() => {
                window.location.reload(); // Recharge manuellement après le délai
            }, 1000); // Affiche l'animation pendant 1 seconde
        };

        window.addEventListener("beforeunload", handleBeforeUnload);

        return () => {
            window.removeEventListener("beforeunload", handleBeforeUnload);
        };

    },[])

    return (
        <>
            {!isConnect ?
                <main className={"h-screen flex items-center justify-center"}>
                    <Connection setIsConnect={setIsConnect}/>
                </main>
                :
                <main className={"h-screen grid grid-cols-4"}>
                    <aside className={"h-screen col-span-1 p-2.5 overflow-y-scroll bg-usmb-dark-blue text-white"}>
                        <ListModules setInfosModule={setInfosModule}/>
                        <Disconnection setIsConnect={setIsConnect}/>
                    </aside>
                    <div className={"col-span-3"}>
                        {Object.keys(infosModule).length > 0 && <InfosModule infos={infosModule}/>}
                    </div>
              </main>
          }
      </>
    );
}