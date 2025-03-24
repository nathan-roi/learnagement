import {useEffect, useState} from "react";
import axios from "axios";
import {bgWhite} from "next/dist/lib/picocolors";

export default function modaleFiliere({nomFiliere, setNomFiliere}:{nomFiliere: string, setNomFiliere:any}){
    const [infosCompetences, setInfosCompetences] = useState([])

    useEffect(() => {
        let form_data = new FormData()
        form_data.append("nom_filiere", nomFiliere)
        axios.post("http://localhost:8080/select/selectCompetencesOfFiliere.php", form_data)
            .then(response => {
                setInfosCompetences(response.data)
            })
    }, [nomFiliere]);

    return(
        <div className={"absolute top-0 w-3/4 h-3/4 bg-white"}>
            <p>Modale filière : {nomFiliere}</p>
            <button onClick={() => {setNomFiliere(null)}}>close</button>
        </div>
    )
}