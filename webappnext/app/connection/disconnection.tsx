import axios from "axios";
import {signOut} from "next-auth/react";
import {useListModulesStore} from "@/app/store/useListModulesStore";

export default function Disconnection(){
    const resetStore = useListModulesStore.getState().reset

    function sendDeconnection(){
        axios.get("/api/proxy/connection/logout", {withCredentials: true})
            .catch((error) => {
                console.log(error)
            })
        resetStore()
        signOut()
    }

    return(
        <p onClick={sendDeconnection} className={"underline text-usmb-red cursor-pointer"}>Déconnexion</p>
    )
}