"use client";

import axios from "axios";
import React, {useEffect, useState} from "react";


export default function Connection({setIsConnect}:any) {
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

        axios.post("http://localhost:8080/authenticate.php", form_data)
            .then(response => {
                let data = response.data
                setIsConnect(data.loggedin)
                // setWrongLogin(!(data.login))
                // setWrongMdp(!(data.mdp))
                console.log(data)
            })
        form.reset()

    }

    return (
        <div className={"h-screen flex items-center justify-center"}>
            <form className={"flex flex-col p-10 shadow-lg"} method="post" onSubmit={sendConnection}>
                <div className="mb-2">
                    <label htmlFor="login">Login :</label>
                    <input type="text" id="login" name="user_login" required={true} value={login}
                           onChange={e => setLogin(e.target.value)}/>
                </div>

                <div className="mb-7">
                    <label htmlFor="mdp">Mot de passe :</label>
                    <input type="password" id="mdp" name="user_mdp" required={true} value={mdp}
                           onChange={e => setMdp(e.target.value)}/>
                </div>
                {wrongLogin && <p className={"formError"}>Login inexistant</p>}
                {wrongMdp && <p className={"formError"}>Mauvais mot de passe</p>}
                <button type="submit" className={"self-center"}>Se connecter</button>
            </form>
        </div>
    );
}
