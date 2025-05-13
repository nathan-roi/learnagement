'use client'

import axios from "axios";
import {signOut} from "next-auth/react";
import {useListModulesStore} from "@/app/store/useListModulesStore";
import {useRouter} from "next/navigation";
import LogoutIcon from "@/public/logout.svg"

export default function Disconnection(){
    const resetStore = useListModulesStore.getState().reset
    const router = useRouter()

    async function sendDeconnection() {
        try {
            await axios.get("/api/proxy/connection/logout", { withCredentials: true });
            resetStore()
            await signOut({ redirect: false })
            router.push('/')
        } catch (error) {
            console.error("Erreur lors de la déconnexion :", error);
        }
    }



    return(
        <LogoutIcon width={35} height={35} onClick={sendDeconnection} className={"clickable-animation cursor-pointer"}/>
    )
}