"use client";

import axios from "axios";
import {useUserInfosStore} from "@/app/store/useUserInfosStore";

export default function Disconnection(){
    const {setLoggedin} = useUserInfosStore()
    function sendDeconnection(){
        axios.get("http://localhost:8080/connection/logout.php")
            .then(r => setLoggedin(r.data))
    }

    return(
        <p onClick={sendDeconnection} className={"underline text-usmb-red cursor-pointer"}>Déconnexion</p>
    )
}