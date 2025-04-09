import axios from "axios";
import {signOut} from "next-auth/react";
export default function Disconnection(){

    function sendDeconnection(){
        axios.get("http://localhost:8080/connection/logout.php")
        signOut()

    }

    return(
        <p onClick={sendDeconnection} className={"underline text-usmb-red cursor-pointer"}>Déconnexion</p>
    )
}