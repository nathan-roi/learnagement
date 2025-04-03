import {useEffect, useState} from "react";
import axios from "axios";
import {isEmpty} from "@jsonjoy.com/util/lib/isEmpty";

export default function listApprentissagesCritiques({idCompetence}:{idCompetence: number}) {
    const [apprentissagesCritques, setApprentissagesCritques] = useState<Record<string, []>>({})
    const [levels, setLevels] = useState<string[]>([])
    const [levelClicked, setLevelClicked] = useState<string>("")

    useEffect(() => {
        if (levels.length > 0 && apprentissagesCritques != undefined){
            let default_level = levels[0]
            setLevelClicked(default_level)
        }
    }, [levels, apprentissagesCritques]);

    useEffect(() => {
        setLevelClicked("")
        let form_data = new FormData
        form_data.append("idCompetence", idCompetence.toString())
        axios.post("http://localhost:8080/select/selectApprentissageCritique.php", form_data)
            .then(response => {
                let data = response.data
                setApprentissagesCritques(data)
                setLevels(Object.keys(data))
            })
    }, [idCompetence]);

    function levelOfApcToShow(event: any) {
        let text_event = event.target.innerText
        let niveau = text_event.split(" ")
        setLevelClicked(niveau[1])
    }

    return(
        <div className={"w-2/4 px-1 flex flex-col gap-4"}>

            <div className={"flex flex-row justify-around"}>
                {levels.map((niveau: string) => (
                    <div id={niveau} key={niveau} className={`w-32 h-14 px-2 flex justify-center items-center rounded-lg text-white cursor-pointer
                            ${levelClicked === niveau ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}

                         onClick={levelOfApcToShow}
                    >
                        <p className={"font-semibold text-base/5"}>niveau {niveau}</p>
                    </div>
                ))}
            </div>

            <div className={"flex flex-col gap-4"}>
                {(!isEmpty(apprentissagesCritques) && levelClicked != "") && (
                    apprentissagesCritques[levelClicked].map((elem: any) => (
                        <div key={elem.id_apprentissage_critique} className={"p-2 font-semibold shadow-md rounded-lg"}>{elem.libelle_apprentissage}</div>
                    ))
                )}
            </div>

        </div>
    )
}