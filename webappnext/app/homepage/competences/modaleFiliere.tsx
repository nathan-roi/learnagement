import {useEffect, useState} from "react";
import axios from "axios";

import ListCompetences from "./listCompetences"
import ComposantesEssentielles from "./composantesEssentielles"
import ListApprentissagesCritiques from "@/app/homepage/competences/apprentissagesCritiques/listApprentissagesCritiques"

export default function modaleFiliere({nomFiliere, setNomFiliere}: { nomFiliere: string[], setNomFiliere: any }) {
    const [infosCompetences, setInfosCompetences] = useState<infosCompetence[]>([])
    const [idCompetenceClicked, setIdCompetenceClicked] = useState<number>(-1)
    const [composanteEssentielle, setComposanteEssentielle] = useState<composanteEssentielle[]>([])

    useEffect(() => {
        let form_data = new FormData
        form_data.append("nom_filiere", nomFiliere[0])
        axios.post("/api/proxy/select/selectCompetencesOfFiliere", form_data, {withCredentials: true})
            .then(response => {
                setInfosCompetences(response.data)
            })
        setIdCompetenceClicked(-1)
    }, [nomFiliere]);

    useEffect(() => {
        if(idCompetenceClicked >= 0){
            let form_data = new FormData
            form_data.append("idCompetence", idCompetenceClicked.toString())
            axios.post("/api/proxy/select/selectComposanteEssentielle", form_data, {withCredentials: true})
                .then(response => {
                    setComposanteEssentielle(response.data)
                })
        }else{
            setComposanteEssentielle([]);
        }

    }, [idCompetenceClicked]);

    useEffect(() => {
        const handleKeyDown = (event: KeyboardEvent) => {
            if(event.key == "Escape"){
                closeModale()
            }
        };

        window.addEventListener("keydown", handleKeyDown);

        return (): void => {
            window.removeEventListener("keydown", handleKeyDown);
        };
    }, []);

    function closeModale(){
        setNomFiliere([]);
        setIdCompetenceClicked(-1)
    }

    return(
        <div className={"foreground-full flex justify-center items-center"} onClick={closeModale}>
            <div className={"w-[90%] h-4/5 p-4 rounded-lg bg-white overflow-auto"} onClick={(e) => {
                e.stopPropagation()
            }}>
                <div className={"relative"}>
                    <button onClick={closeModale} className={"absolute top-0 right-0 bg-usmb-red hover:bg-red-600"}>close</button>
                    <h1 className={"mt-0 mb-8"}>{nomFiliere[1] != null ? <>{nomFiliere[0]} - {nomFiliere[1]}</>  : nomFiliere[0]}</h1>
                    <ListCompetences infosCompetences={infosCompetences} setIdCompetenceClicked={setIdCompetenceClicked} />
                    <div className={"w-full flex flex-row justify-between"}>
                        <ComposantesEssentielles composanteEssentielle={composanteEssentielle}/>
                        {idCompetenceClicked >= 0 && <ListApprentissagesCritiques idCompetence={idCompetenceClicked}/>}
                    </div>
                </div>
            </div>
        </div>
    )
}