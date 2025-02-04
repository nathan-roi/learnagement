"use client";

import React, {useState, useEffect} from "react";
import axios from "axios";

import Connection from "./connection/connection";
import Disconnection from "./connection/disconnection";
import ListModules from "./listModules";
import InfosModule from "./modules/infosModule"
import Loader from "@/app/loader";
import Homepage from "@/app/homepage/homepage";

interface User {
    loggedin: boolean,
    start: number,
    timeout: number,
    userFirstname: string,
    userId: string,
    userLastname: string,
    userLogin: string
}

export default function Home() {
    axios.defaults.withCredentials = true // Autorise le partage de cookies (fonctionne pour les composants enfants)
    const [isConnect, setIsConnect] = useState(false)
    const [userInfos, setUserInfos] = useState<User>()
    const [infosModule, setInfosModule] = useState({code_module:"null"})
    const [isLoading, setIsLoading] = useState(true)

    useEffect(() => {
        setIsLoading(true)

        axios.get("http://localhost:8080/connection/isConnect.php")
            .then(response => {
                let data = response.data
                setIsConnect(data.loggedin)
                setUserInfos(data)
                setIsLoading(false)
            })
    },[])

    return (
        <>
            {!isConnect ?
                <main className={"h-screen flex items-center justify-center"}>
                    {isLoading ? <Loader /> : <Connection setIsConnect={setIsConnect}/>}

                </main>
                :
                <main className={"h-screen grid grid-cols-4"}>
                    {/*Si pas d'infos utilisateurs ou alors loading on affiche le loader*/}
                    {isLoading || !userInfos ? <Loader /> :
                        <>
                            <aside className={"h-screen col-span-1 p-2.5 overflow-y-scroll bg-usmb-dark-blue text-white"}>
                                <ListModules setInfosModule={setInfosModule}/>
                                <Disconnection setIsConnect={setIsConnect}/>
                            </aside>
                            {/*Si aucun module affiché alors homepage s'affiche sinon le module*/}
                            {infosModule.code_module == "null" ?
                                <div className={"col-span-3"}>
                                    <Homepage userId={userInfos.userId}/>
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