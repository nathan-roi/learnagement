import {useEffect, useState} from "react";
import axios from "axios";
import {isEmpty} from "@jsonjoy.com/util/lib/isEmpty";

export default function listApprentissagesCritiques({idCompetence}:{idCompetence: number}) {
    const [apprentissagesCritques, setApprentissagesCritques] = useState<apprentissagesCritiquesStruct>({})
    const [levels, setLevels] = useState<string[]>([])
    const [levelClicked, setLevelClicked] = useState<number>(-1)

    useEffect(() => {
        if (levels.length > 0 && apprentissagesCritques != undefined){
            let default_level: string = levels[0]
            setLevelClicked(parseInt(default_level))
        }
    }, [levels, apprentissagesCritques]);

    useEffect(() => {
        let form_data = new FormData
        form_data.append("idCompetence", idCompetence.toString())
        axios.post("http://localhost:8080/select/selectApprentissageCritique.php", form_data)
            .then(response => {
                let data = response.data
                console.log(data)
                setApprentissagesCritques(data)
                setLevels(Object.keys(data))
            })
    }, [idCompetence]);

    function levelOfApcToShow(event: any) {
        let text_event: string = event.target.innerText
        let level: string[] = text_event.split(" ")
        setLevelClicked(parseInt(level[1]))
    }

    return(
        <div className={"w-2/4 px-1 flex flex-col gap-4"}>
            {/* Affichage des niveaux */}
            <div className={"flex flex-row justify-around"}>
                {levels.map((level: string) => (
                    <div id={level} key={level} className={`w-32 h-14 px-2 flex justify-center items-center rounded-lg text-white cursor-pointer
                            ${levelClicked.toString() === level ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}

                         onClick={levelOfApcToShow}
                    >
                        <p className={"font-semibold text-base/5"}>niveau {level}</p>
                    </div>
                ))}
            </div>

            <div className={"flex flex-col gap-4"}>
                {/* Affichage des APC*/}
                {(!isEmpty(apprentissagesCritques) && levelClicked >= 0) && (
                    apprentissagesCritques[levelClicked].map((apc: apprentissageCritique) => (
                        <div key={apc.id_apprentissage_critique} className={"p-2 font-semibold shadow-md rounded-lg"}>{apc.libelle_apprentissage}</div>
                    ))
                )}
            </div>

        </div>
    )
}