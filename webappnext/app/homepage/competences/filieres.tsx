import axios from "axios";
import {useEffect, useState} from "react";
import { useUserInfosStore } from "@/app/store/useUserInfosStore";

export default function Filieres(){
    const {user} = useUserInfosStore()
    const [nomFilieres, setNomFilieres] = useState([])

    useEffect(() => {
        let form_data = new FormData()
        form_data.append("userId", user.userId)
        axios.post("http://localhost:8080/select/selectFilieres.php", form_data)
            .then(response => {
                setNomFilieres(response.data)
            })
    }, []);
    console.log(nomFilieres)
    return (
        <>
            <div id="cards-container" className={"w-full px-3 flex flex-wrap justify-center gap-10 gap-y-8"}>
                {nomFilieres.length > 0 ? (
                    nomFilieres.map((nom, index) =>
                        <div key={index} className={"w-60 h-16 flex justify-center items-center rounded-lg shadow-default cursor-pointer"}>
                            <p className={"font-semibold"}>{nom[0]}</p>
                        </div>)
                ) : (
                    <p>Aucune filière disponible.</p>
                )}
            </div>
        </>
    )
}