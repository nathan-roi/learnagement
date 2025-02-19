"use client";

import axios from "axios";
import Link from "next/link";
import React, {useState} from "react";
import { useUserInfosStore } from "@/app/store/useUserInfosStore";


export default function Connection() {
    const {setUser} = useUserInfosStore()
    const [login, setLogin] = useState('')
    const [mdp, setMdp] = useState('')

    const [wrongLogin, setWrongLogin] = useState(false)
    const [wrongMdp, setWrongMdp] = useState(false)

    function sendConnection(event:any){
        event.preventDefault()
        let form = event.currentTarget

        let form_data = new FormData()
        form_data.append("username", login)
        form_data.append("password", mdp)

        axios.post("http://localhost:8080/connection/authenticate.php", form_data)
            .then(response => {
                let data = response.data
                setUser(data)
                // setWrongLogin(!(data.login))
                // setWrongMdp(!(data.mdp)
            })
        form.reset()

    }

    return (
        <form className={"flex flex-col items-center justify-center pb-3 shadow-lg"} method="post" onSubmit={sendConnection}>
            <div className={"flex flex-col px-9 pb-9 pt-5"}>
                <div className={"mb-2"}>
                    <label htmlFor="login">Login :</label>
                    <input type="text" id="login" name="user_login" required={true} value={login}
                           onChange={e => setLogin(e.target.value)}/>
                </div>

                <div className={"mb-7"}>
                    <label htmlFor="mdp">Mot de passe :</label>
                    <input type="password" id="mdp" name="user_mdp" required={true} value={mdp}
                           onChange={e => setMdp(e.target.value)}/>
                </div>
                {/*{wrongLogin && <p className={"formError"}>Login inexistant</p>}*/}
                {/*{wrongMdp && <p className={"formError"}>Mauvais mot de passe</p>}*/}
                <button type="submit" className={"self-center bg-usmb-cyan"}>Se connecter</button>
            </div>
            <Link href={"/activateAccount"} className={"text-xs underline text-usmb-cyan cursor-pointer"}>Activer mon compte</Link>
        </form>

    );
}
