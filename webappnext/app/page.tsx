"use client";

import React, {useState, useEffect} from "react";
import axios from "axios";

import Connection from "./connection/connection";
import Disconnection from "./connection/disconnection"

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
              <Connection setIsConnect={setIsConnect}/>
              :
              <>
                  <p>successfully connected</p>
                  <Disconnection setIsConnect={setIsConnect}/>
              </>
          }

      </>
  );
}
