import axios from "axios";
import {useEffect, useState} from "react";
import {useSession} from "next-auth/react";

import ModaleFiliere from "@/app/homepage/competences/modaleFiliere";

export default function Filieres(){
    const {data: session, status} = useSession()
    const [nomFilieres, setNomFilieres] = useState<string[]>([])
    const [nomFiliereClicked, setNomFiliereClicked] = useState([])

    useEffect(() => {
        if (status === "authenticated"){
            let form_data = new FormData()
            form_data.append("userId", session?.user.id)
            axios.post('/api/proxy/select/selectFilieres', form_data, {withCredentials: true})
                .then(response => {
                    setNomFilieres(response.data)
                })
        }
    }, [status]);

    function filiereClicked(str: string){
        let res:any = nomFilieres.find((element: string): boolean => str == element[0])
        if(res != undefined){
            setNomFiliereClicked(res)
        }
    }

    return (
        <>
            <div id="cards-container" className={"w-full px-3 flex flex-wrap justify-center gap-10 gap-y-8"}>
                {nomFilieres.length > 0 ? (
                    nomFilieres.map((nom: string, index: number) =>
                        <div key={index} onClick={(event:any): void => {filiereClicked(event.target.innerText)}} className={"w-60 h-16 flex justify-center items-center rounded-lg shadow-default cursor-pointer"}>
                            <p className={"font-semibold"}>{nom[0]}</p>
                        </div>)
                ) : (
                    <p>Aucune filière disponible.</p>
                )}
            </div>
            {nomFiliereClicked.length > 0 && <ModaleFiliere nomFiliere={nomFiliereClicked} setNomFiliere={setNomFiliereClicked}/>}
        </>
    )
}