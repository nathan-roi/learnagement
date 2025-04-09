"use client"
import {signIn, signOut, useSession} from "next-auth/react"

import axios from "axios";
import Link from "next/link";
import React, {useState} from "react";
import { useUserInfosStore } from "@/app/store/useUserInfosStore";


export default function Page() {
    const {setUser} = useUserInfosStore()
    const [login, setLogin] = useState('')
    const [mdp, setMdp] = useState('')
    const [loggError, setLoggingError] = useState(false)
    const [msgLoggErr, setMsgLoggErr] = useState('')

    const {data:session} = useSession()
    if (session){console.log(session)}

    const credentialsAction = (formData: FormData) => {
        let credentials = Object.fromEntries(formData.entries())
        signIn("credentials", credentials)
    }

    return (
        <form className={"flex flex-col items-center justify-center pb-3 shadow-lg"} action={credentialsAction}>
            <div className={"flex flex-col px-9 pb-9 pt-5"}>
                <div className={"mb-2"}>
                    <label htmlFor="credentials-username">Login :</label>
                    <input type="mail" id="credentials-username" name="username" required={true}/>
                    {/*<input type="mail" id="credentials-username" name="username" required={true} value={login}*/}
                    {/*       onChange={e => setLogin(e.target.value)}/>*/}
                </div>

                <div className={"mb-7"}>
                    <label htmlFor="credentials-password">Mot de passe :</label>
                    <input type="password" id="credentials-password" name="password" required={true}/>
                    {/*<input type="password" id="credentials-password" name="password" required={true} value={mdp}*/}
                    {/*       onChange={e => setMdp(e.target.value)}/>*/}
                </div>
                {/*{loggError && <p className={"text-usmb-red self-center mb-7"}>{msgLoggErr}</p>}*/}
                <button type="submit" className={"self-center bg-usmb-cyan"}>Se connecter</button>
            </div>
            <button onClick={() => signOut()}>Sign out</button>
            <Link href={"/activateAccount"} className={"text-xs underline text-usmb-cyan cursor-pointer"}>Activer mon compte</Link>
        </form>

    )
}
