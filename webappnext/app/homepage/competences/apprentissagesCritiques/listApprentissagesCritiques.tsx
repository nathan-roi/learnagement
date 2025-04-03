import {useEffect, useState} from "react";
import axios from "axios";
import {isEmpty} from "@jsonjoy.com/util/lib/isEmpty";

interface ModuleOfAPC{
    id_apprentissage_critique: number,
    id_module: number,
    code_module: string,
    nom: string
}

export default function listApprentissagesCritiques({idCompetence}:{idCompetence: number}) {
    const [apprentissagesCritques, setApprentissagesCritques] = useState<apprentissagesCritiquesStruct>({})
    const [apcAsModule, setApcAsModule] = useState<ModuleOfAPC[]>([])

    const [levels, setLevels] = useState<string[]>([])
    const [levelClicked, setLevelClicked] = useState<number>(-1)

    const [showTooltip, setShowTooltip] = useState(false)
    const [tooltipPostion, setTooltipPosition] = useState({x: 0, y:0})


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
                setApprentissagesCritques(data)
                setLevels(Object.keys(data))
            })
    }, [idCompetence]);

    useEffect(() => {
        let form_data = new FormData
        form_data.append("id_user", "18")
        axios.post("http://localhost:8080/select/selectModulesOfAllAPC.php", form_data)
            .then(response => {
                let data = response.data
                setApcAsModule(data)
            })
    }, []);

    function levelOfApcToShow(event: any) {
        let text_event: string = event.target.innerText
        let level: string[] = text_event.split(" ")
        setLevelClicked(parseInt(level[1]))
    }


    function tooltip(event: any){
        let id = parseInt(event.target.id)

        if (!apcAsModule.some(item => item.id_apprentissage_critique === id)){
            setShowTooltip(true)
        }
    }

    function moveTooltip(event: React.MouseEvent){
        setTooltipPosition({x: event.clientX, y: event.clientY})
        console.log(event)
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
                {(!isEmpty(apprentissagesCritques) && levelClicked >= 0 && apcAsModule.length > 0) && (
                    apprentissagesCritques[levelClicked].map((apc: apprentissageCritique) => (
                        <div id={apc.id_apprentissage_critique.toString()}
                             key={apc.id_apprentissage_critique}
                             className={`p-2 font-semibold shadow-md rounded-lg 
                             ${apcAsModule.some(item => item.id_apprentissage_critique === apc.id_apprentissage_critique) ? 
                                 'bg-white cursor-pointer' : 'bg-gray-100'}`}

                             onMouseOver={tooltip}
                             onMouseLeave={() => setShowTooltip(false)}
                             onMouseMove={moveTooltip}
                        >
                            {apc.libelle_apprentissage}

                        </div>
                    ))
                )}
            </div>
            {showTooltip && (
                <div
                    className="fixed bg-black text-white p-2 rounded-lg text-sm pointer-events-none"
                    style={{ left: `${tooltipPostion.x}px`, top: `${tooltipPostion.y}px` }}
                >
                    Vous n'avez pas de module pour cet apprentissage critique
                </div>
            )}
        </div>
    )
}