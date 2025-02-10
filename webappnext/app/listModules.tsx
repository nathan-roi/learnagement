import axios from "axios";
import {useEffect, useState} from "react";

import InfosModule from './modules/infosModule'

interface Module {
    id_module: string;
    nom: string;
    code_module: string;
}

export default function ListModule({setInfosModule, homepageShown}:{setInfosModule:any, homepageShown:boolean}){
    const [listeModules, setListeModules] = useState<Module[]>([]);
    const [moduleClicked, setModuleClicked] = useState('')

    useEffect(() => {

        axios.get("http://localhost:8080/list/listResponsableModule.php")
            .then(response => {
                setListeModules(response.data)
            })

    }, []);

    useEffect(() => {
        if (homepageShown){
            setModuleClicked('')
        }
    }, [homepageShown]);

    const listeModulesHTML = listeModules.map(module =>
            <div key={module.id_module} id={module.id_module} className={`w-full h-20 mb-2.5 pl-2.5 rounded-lg hover:bg-usmb-blue cursor-pointer 
            ${moduleClicked === module.id_module ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`} onClick={getModuleInfos}>
                <p className={"font-medium"}>{module.nom}</p>
                <p>{module.code_module}</p>
            </div>
    )

    async function getModuleInfos(event:any){
        let id_module

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
                setModuleClicked(response.data[0].id_module)
            })
    }

    return (
        <div className={"h-3/4 overflow-y-auto"}>
            {listeModulesHTML}
        </div>


    )
}