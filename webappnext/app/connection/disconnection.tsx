import axios from "axios";
import {signOut} from "next-auth/react";
export default function Disconnection(){
    function sendDeconnection(){
        axios.get("/api/proxy/connection/logout", {withCredentials: true})
            .catch((error) => {
                console.log(error)
            })
        signOut()
    }

    return(
        <p onClick={sendDeconnection} className={"underline text-usmb-red cursor-pointer"}>Déconnexion</p>
    )
}