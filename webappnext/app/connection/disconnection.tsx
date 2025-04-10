import axios from "axios";
import {signOut, useSession} from "next-auth/react";
export default function Disconnection(){
    const {data: session} = useSession()
    function sendDeconnection(){
        if(session){
            let formData = new FormData
            formData.append("sessionId", session?.user.sessionId)
            axios.post("http://localhost:8081/connection/logout.php", formData)
            signOut()
        }


    }

    return(
        <p onClick={sendDeconnection} className={"underline text-usmb-red cursor-pointer"}>Déconnexion</p>
    )
}