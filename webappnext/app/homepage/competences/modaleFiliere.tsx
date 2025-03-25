import {useEffect, useState} from "react";
import axios from "axios";

import ListCompetences from "./listCompetences"
import ComposantesEssentielles from "./composantesEssentielles"

export default function modaleFiliere({nomFiliere, setNomFiliere}: { nomFiliere: string, setNomFiliere: any }) {
    const [infosCompetences, setInfosCompetences] = useState<infosCompetence[]>([])
    const [idCompetenceClicked, setIdCompetenceClicked] = useState<number>(-1)
    const [composanteEssentielle, setComposanteEssentielle] = useState<any[]>([])

    useEffect(() => {
        let form_data = new FormData
        form_data.append("nom_filiere", nomFiliere)
        axios.post("http://localhost:8080/select/selectCompetencesOfFiliere.php", form_data)
            .then(response => {
                setInfosCompetences(response.data)
            })

    }, [nomFiliere]);

    useEffect(() => {
        if(idCompetenceClicked >= 0){
            let form_data = new FormData
            form_data.append("idCompetence", idCompetenceClicked.toString())
            axios.post("http://localhost:8080/select/selectComposanteEssentielle.php", form_data)
                .then(response => {
                    setComposanteEssentielle(response.data)
                })
        }

    }, [idCompetenceClicked]);

    return(
        <div className={"absolute top-0 w-3/4 h-3/4 bg-white"}>
            <p>Modale filière : {nomFiliere}</p>
            <button onClick={() => {setNomFiliere(null); setIdCompetenceClicked(-1)}}>close</button>
            <ListCompetences infosCompetences={infosCompetences} setIdCompetenceClicked={setIdCompetenceClicked} />
            <ComposantesEssentielles composanteEssentielle={composanteEssentielle}/>
        </div>
    )
}