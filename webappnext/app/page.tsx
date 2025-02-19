"use client";

import React, {useState, useEffect} from "react";
import axios from "axios";
import { useUserInfosStore } from "./store/useUserInfosStore"

import Connection from "./connection/connection";
import Disconnection from "./connection/disconnection";
import ListModules from "./modules/listModules";
import InfosModule from "./modules/infosModule"
import Loader from "@/app/loader";
import Homepage from "@/app/homepage/homepage";
import LinkHomepage from "@/app/homepage/linkHomepage";

export default function Home() {
    axios.defaults.withCredentials = true // Autorise le partage de cookies (fonctionne pour les composants enfants)
    const { user, setUser } = useUserInfosStore()
    const [infosModule, setInfosModule] = useState({code_module:"null"})
    const [isLoading, setIsLoading] = useState(true)


    useEffect(() => {
        setIsLoading(true)

        axios.get("http://localhost:8080/connection/isConnect.php")
            .then(response => {
                let data = response.data
                setUser(data)
                setIsLoading(false)
            })
    },[])
    function shownHomepage(){
        return infosModule?.code_module === "null";
    }
    
    return (
        <>
            {!user.loggedin ?
                <main className={"h-screen flex items-center justify-center"}>
                    {isLoading ? <Loader /> : <Connection />}

                </main>
                :
                <main className={"h-screen grid grid-cols-4"}>
                    {/*Si pas d'infos utilisateurs ou alors loading on affiche le loader*/}
                    {isLoading ? <Loader /> :
                        <>
                            <aside className={"h-screen col-span-1 p-2.5 bg-usmb-dark-blue text-white"}>
                                <LinkHomepage setInfosModule={setInfosModule}/>
                                <ListModules setInfosModule={setInfosModule} homepageShown= {shownHomepage()}/>
                                <Disconnection />
                            </aside>
                            {/*Si aucun module affiché alors homepage s'affiche sinon le module*/}
                            {shownHomepage() ?
                                <div className={"col-span-3"}>
                                    <Homepage />
                                </div>
                                :
                                <div className={"col-span-3"}>
                                    {Object.keys(infosModule).length > 0 && <InfosModule infos={infosModule}/>}
                                </div>
                            }
                        </>
                    }
              </main>
          }
      </>
    );
}