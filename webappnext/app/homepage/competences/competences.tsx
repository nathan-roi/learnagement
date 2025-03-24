import {useEffect} from "react";
import axios from "axios";

export default function competences({nomFiliere, setNomFiliere}:{nomFiliere: string, setNomFiliere:any}){ /*TODO changer le type*/
    useEffect(() => {
        let form_data = new FormData()
        form_data.append("nom_filiere", nomFiliere)
        axios.post("http://localhost:8080/select/selectCompetencesOfFiliere.php", form_data)
            .then(response => {
                console.log(response.data)
            })
    }, [nomFiliere]);

    return(
        <>
            <p>Compétences</p>
            <button onClick={() => {setNomFiliere(null)}}>close</button>
        </>
    )
}