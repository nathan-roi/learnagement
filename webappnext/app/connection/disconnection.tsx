"use client";
import axios from "axios";

export default function Disconnection({setIsConnect}:any){
    function sendDeconnection(){
        axios.get("http://localhost:8080/connection/logout.php")
            .then(r => setIsConnect(r.data))
    }

    return(
        <p onClick={sendDeconnection} className={"underline text-blue-700 cursor-pointer"}>Déconnexion</p>
    )
}