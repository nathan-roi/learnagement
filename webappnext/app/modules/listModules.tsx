"use client"

import axios from "axios";
import {useEffect, useState} from "react";
import {useInfosModuleStore} from "@/app/store/useInfosModuleStore";
import {useSession} from "next-auth/react";
import Loader from "@/app/indicators/loader";

export default function ListModule({homepageShown}:{homepageShown:boolean}){
    const {setModule} = useInfosModuleStore()
    const [listeModules, setListeModules] = useState<Module["module"][]>([]);
    const [moduleClicked, setModuleClicked] = useState(-1)
    const {data: session, status} = useSession()

    useEffect(() => {

        if (status === "authenticated"){
            let form_data = new FormData
            form_data.append("userId", session?.user.id)
            axios.post("http://localhost:8080/list/listResponsableModule.php", form_data)
                .then(response => {
                    setListeModules(response.data)
                })
        }

    }, [status]);

    useEffect(() => {
        if (homepageShown){
            setModuleClicked(-1)
        }
    }, [homepageShown]);


    async function getModuleInfos(event:any){
        let id_module

        if (event.target.localName == "div"){
            id_module = event.target.id //div cliqué
        }else{
            id_module = event.target.parentElement.id // enfant de la div cliqué
        }

        let form_data = new FormData()
        form_data.append("id_module", id_module)
        axios.post("http://localhost:8080/select/selectInfosModule.php",form_data)
            .then(response => {
                let data = response.data
                setModule(data)
                setModuleClicked(data.id_module)
            })
    }

    if (status == "authenticated"){
        return (
            <div className={"h-3/4 overflow-y-auto"}>
                {listeModules.map(module =>
                    <div key={module.id_module} id={String(module.id_module)} className={`w-full h-20 mb-2.5 pl-2.5 rounded-lg hover:bg-usmb-blue cursor-pointer 
                    ${moduleClicked === module.id_module ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`} onClick={getModuleInfos}>
                        <p className={"font-medium"}>{module.nom}</p>
                        <p>{module.code_module}</p>
                    </div>
                )}
            </div>
        )
    }else{
        return (
            <div className={"h-3/4 overflow-y-auto"}>
                <Loader />
            </div>
        )
    }


}