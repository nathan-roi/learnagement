import axios from "axios";
import {useEffect, useState} from "react";

import InfosModule from './modules/infosModule'

interface Module {
    id_module: string;
    nom: string;
    code_module: string;
}

export default function ListModule({setInfosModule}:{setInfosModule:any}){
    const [listeModules, setListeModules] = useState<Module[]>([]);
    // const [infosModule, setInfosModule] = useState({});

    useEffect(() => {

        axios.get("http://localhost:8080/list/listResponsableModule.php")
            .then(response => {
                setListeModules(response.data)
            })

    }, []);

    const listeModulesHTML = listeModules.map(module =>
        <div key={module.id_module} id={module.id_module} className={"w-full mb-2.5 p-1 rounded-lg bg-usmb-cyan cursor-pointer"} onClick={getModuleInfos}>
            <p>{module.nom}</p>
            <p>{module.code_module}</p>
        </div>
    )

    async function getModuleInfos(event:any){
        let id_module
        console.log(event)
        if (event.target.localName == "div"){
            id_module = event.target.id //div cliqué
        }else{
            id_module = event.target.parentElement.id // enfant de la div cliqué
        }

        let form_data = new FormData()
        form_data.append("id_module", id_module)
        axios.post("http://localhost:8080/select/selectModuleById.php",form_data)
            .then(response => {
                setInfosModule(response.data[0])
            })
    }

    return (
        <>
            {listeModulesHTML}
        </>


    )
}