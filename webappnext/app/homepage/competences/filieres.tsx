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
            <p>Filières</p>
            {nomFilieres.length > 0 ? (
                nomFilieres.map((nom, index) => <p key={index}>{nom[1] != null ? <>{nom[0]} - {nom[1]}</>:<>{nom[0]}</>}</p>)
            ) : (
                <p>Aucune filière disponible.</p>
            )}
        </>
    )
}