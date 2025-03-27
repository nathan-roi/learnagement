import {SetStateAction, useEffect, useState} from "react";
import axios from "axios";

export default function listApprentissagesCritiques({idCompetence}:{idCompetence: number}) {
    const [apc, setApc] = useState<Record<string, []>>({})
    const [uniqueAPC, setUniqueAPC] = useState<any[]>([])
    const [niveaux, setNiveaux] = useState<string[]>([])
    const [niveauClicked, setNiveauClicked] = useState<string>("")

    useEffect(() => {
        setUniqueAPC([])
        setNiveauClicked("")
        let form_data = new FormData
        form_data.append("idCompetence", idCompetence.toString())
        axios.post("http://localhost:8080/select/selectApprentissageCritique.php", form_data)
            .then(response => {
                let data = response.data
                console.log(response.data)
                setApc(data)
                setNiveaux(Object.keys(data))
            })
    }, [idCompetence]);

    function levelOfApcToShow(event: any) {
        let text_event = event.target.innerText
        let niveau = text_event.split(" ")
        setNiveauClicked(niveau[1])
        showAPC(apc[niveau[1]])
    }

    function showAPC(apc: any) {
        let apc_keys = Object.keys(apc)
        let temp_array: SetStateAction<any[]> = []
        apc_keys.forEach((id_APC:string)=>{
            temp_array.push(apc[parseInt(id_APC)][0])
        })

        setUniqueAPC(temp_array)
    }

    return(
        <div className={"w-2/4 px-1 flex flex-col gap-4"}>

            <div className={"flex flex-row justify-around"}>
                {niveaux.map((niveau: string) => (
                    <div id={niveau} key={niveau} className={`w-32 h-14 px-2 flex justify-center items-center rounded-lg text-white cursor-pointer
                            ${niveauClicked === niveau ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}

                         onClick={levelOfApcToShow}
                    >
                        <p className={"font-semibold text-base/5"}>niveau {niveau}</p>
                    </div>
                ))}
            </div>

            <div className={"flex flex-col gap-4"}>
                {uniqueAPC.length > 0 && (
                    uniqueAPC.map((elem: any) => (
                        <div key={elem.id_apprentissage_critique} className={"p-2 font-semibold shadow-md rounded-lg"}>{elem.libelle_apprentissage}</div>
                    ))
                )}
            </div>

        </div>
    )
}