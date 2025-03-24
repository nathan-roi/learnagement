"use client";

import axios from "axios";
import React, {useState, useEffect} from "react";
import { useUserInfosStore } from "./store/useUserInfosStore";
import { useInfosModuleStore } from "@/app/store/useInfosModuleStore";

import Connection from "@/app/connection/connection";
import Disconnection from "@/app/connection/disconnection";
import ListModules from "@/app/modules/listModules";
import InfosModule from "@/app/modules/infosModule"
import Loader from "@/app/indicators/loader";
import Homepage from "@/app/homepage/homepage";
import LinkHomepage from "@/app/homepage/linkHomepage";

export default function Home() {
    axios.defaults.withCredentials = true // Autorise le partage de cookies (fonctionne pour les composants enfants)
    const { user, setUser } = useUserInfosStore()
    const { module } = useInfosModuleStore()
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
        return module.code_module === "";
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
                        </>
                    }
              </main>
          }
      </>
    );
}