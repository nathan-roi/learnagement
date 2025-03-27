import {useEffect, useState} from "react";
import axios from "axios";

export default function listApprentissagesCritiques(){
    const [apc, setApc] = useState<Record<string, []>>({})
    const [apcShow, setApcShow] = useState([])
    const [niveaux, setNiveaux] = useState<string[]>([])
    const [niveauClicked, setClicked] = useState<string>("")

    useEffect(() => {
        let form_data = new FormData
        form_data.append("idCompetence", "1")
        axios.post("http://localhost:8080/select/selectApprentissageCritique.php", form_data)
            .then(response => {
                let data = response.data
                setApc(data)
                setNiveaux(Object.keys(data))
            })
    }, []);

    function levelOfApcToShow(event: any){
        setApcShow(apc[event.target.lastChild.data])
        console.log(event)
    }

    return(
        <div className={"w-2/4 px-1 flex flex-col justify-center"}>

            <div className={"flex flex-row"}>
                {niveaux.map((niveau: string) => (
                    // <p key={niveau} onClick={levelOfApcToShow}>niveau {niveau}</p>
                    <div key={niveau} className={`w-60 h-20 px-2 flex justify-center items-center rounded-lg text-white cursor-pointer
                            ${niveauClicked === niveau ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}

                         onClick={levelOfApcToShow}
                    >
                        <p className={"font-semibold text-base/5"}>niveau {niveau}</p>
                    </div>
                ))}
            </div>


            {apcShow.map((elem:any) => (
                <div>{elem.libelle_apprentissage}</div>
            ))}
        </div>
    )
}