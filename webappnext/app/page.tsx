"use client";

import React, {useState, useEffect} from "react";
import dynamic from "next/dynamic";
import axios from "axios";

import Connection from "./connection/connection";
import Disconnection from "./connection/disconnection";
import ListModules from "./listModules";

export default function Home() {
    axios.defaults.withCredentials = true; // Autorise le partage de cookies (fonctionne pour les composants enfants)
    const [isConnect, setIsConnect] = useState(false);

    useEffect(() => {

        axios.get("http://localhost:8080/connection/isConnect.php")
            .then(response => {
                let data = response.data
                setIsConnect(data.loggedin)
                console.log(data)
            })

    },[])

    return (
      <>
          {!isConnect ?
              <main className={"h-screen flex items-center justify-center"}>
                <Connection setIsConnect={setIsConnect}/>
              </main>
              :
              <main>
                  <aside className={"h-screen w-1/4 p-2.5 overflow-y-scroll bg-usmb-dark-blue text-white"}>
                      <ListModules/>
                      <Disconnection setIsConnect={setIsConnect}/>
                  </aside>
              </main>
          }

              </>
              );
          }
