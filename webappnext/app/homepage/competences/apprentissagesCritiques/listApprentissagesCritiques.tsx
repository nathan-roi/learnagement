import axios from "axios";

import { useEffect, useState} from "react";
import {isEmpty} from "@jsonjoy.com/util/lib/isEmpty";

import ModulesOfApprentissageCritique from "./modulesOfApprentissageCritique"


export default function listApprentissagesCritiques({idCompetence}:{idCompetence: number}) {
    const [apprentissagesCritiques, setApprentissagesCritiques] = useState<apprentissagesCritiquesStruct>({})
    const [apcAsModule, setApcAsModule] = useState<ModulesOfAPC>({})

    const [levels, setLevels] = useState<string[]>([])
    const [levelClicked, setLevelClicked] = useState<number>(-1)

    const [idApcClicked, setApcClicked] = useState<number>(-1)

    const [showTooltip, setShowTooltip] = useState(false)
    const [tooltipPostion, setTooltipPosition] = useState({x: 0, y:0})


    useEffect(() => {
        if (levels.length > 0 && apprentissagesCritiques != undefined){
            let default_level: string = levels[0]
            setLevelClicked(parseInt(default_level))
        }
    }, [levels, apprentissagesCritiques]);

    useEffect(() => {
        let form_data = new FormData
        form_data.append("idCompetence", idCompetence.toString())
        axios.post("/api/proxy/select/selectApprentissageCritique", form_data, {withCredentials: true})
            .then(response => {
                let data = response.data
                setApprentissagesCritiques(data)
                setLevels(Object.keys(data))
            })
    }, [idCompetence]);

    useEffect(() => {
        axios.get("/api/proxy/select/selectModulesOfAllAPC", {withCredentials: true})
            .then(response => {
                setApcAsModule(response.data)
            })
    }, []);

    function levelOfApcToShow(event: any) {
        let text_event: string = event.target.innerText
        let level: string[] = text_event.split(" ")
        setLevelClicked(parseInt(level[1]))
    }

    function showModules(event: any){
        let idApc: number = parseInt(event.target.id)
        if (idApcClicked == idApc){
            setApcClicked(-1)
        }else if(idApc in Object.keys(apcAsModule)){
            setApcClicked(idApc)
        }
    }

    function tooltip(event: any){
        let id = event.target.id

        let keys = Object.keys(apcAsModule)
        if (!(id in keys)){setShowTooltip(true)}
    }

    function moveTooltip(event: React.MouseEvent){
        setTooltipPosition({x: event.clientX, y: event.clientY})
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
                {(!isEmpty(apprentissagesCritiques) && levelClicked >= 0 && Object.keys(apcAsModule).length > 0) && (
                    apprentissagesCritiques[levelClicked].map((apc: apprentissageCritique) => (
                        <div key={apc.id_apprentissage_critique}>
                            <div id={apc.id_apprentissage_critique.toString()}
                                 className={`p-2 shadow-md font-medium
                                 ${(apc.id_apprentissage_critique in Object.keys(apcAsModule)) ? 
                                     'bg-white cursor-pointer' : 'bg-gray-100'
                                 }
                                 ${idApcClicked === apc.id_apprentissage_critique ? 'rounded-t-lg' : 'rounded-lg'}
                                 `}

                                 onMouseOver={tooltip}
                                 onMouseLeave={() => setShowTooltip(false)}
                                 onMouseMove={moveTooltip}

                                 onClick={showModules}
                            >
                                {apc.libelle_apprentissage}

                            </div>
                            {
                                idApcClicked >= 0 && idApcClicked === apc.id_apprentissage_critique && (
                                    <ModulesOfApprentissageCritique listModules={apcAsModule[idApcClicked]} />
                                )
                            }
                        </div>

                    ))
                )}
            </div>
            {showTooltip && (
                <div
                    className="fixed bg-black text-white p-2 rounded-lg text-sm pointer-events-none"
                    style={{ left: `${tooltipPostion.x}px`, top: `${tooltipPostion.y}px` }}
                >
                    Vous n'avez pas de modules pour cet apprentissage critique
                </div>
            )}
        </div>
    )
}