"use client"

import axios from "axios";
import {useEffect, useState} from "react";
import {useInfosModuleStore} from "@/app/store/useInfosModuleStore";
import {useListModulesStore} from "@/app/store/useListModulesStore";
import {useSession} from "next-auth/react";
import {useSearchParams} from "next/navigation";

import Loader from "@/app/indicators/loader";
import router from "next/router";
import Link from "next/link";

export default function ListModule(){
    const {setModule} = useInfosModuleStore()
    const {listModules} = useListModulesStore()
    const [moduleClicked, setModuleClicked] = useState(-1)

    const {data: session, status} = useSession()
    const searchParams = useSearchParams()

    useEffect(() => {
        let id_module = searchParams.get("id_module")
        if (id_module != undefined){
            setModuleClicked(parseInt(id_module))
        }
    }, [searchParams]);

    async function getModuleInfos(event:any){
        let id_module

        if (event.target.localName == "div"){
            id_module = event.target.id //div cliqué
        }else{
            id_module = event.target.parentElement.id // enfant de la div cliqué
        }

        let form_data = new FormData()
        form_data.append("id_module", id_module)
        axios.post("/api/proxy/select/selectInfosModule",form_data, {withCredentials: true})
            .then(response => {
                let data = response.data
                setModule(data)
            })
    }


    return (
        <>
            {
                status === "authenticated" ? (
                    <div className={"h-3/4 overflow-y-auto"}>
                        {Object.values(listModules).map((module: ModuleInfos) =>
                            <Link href={{pathname : '/modules', query: {id_module: module.id_module}}}>
                                <div key={module.id_module} id={String(module.id_module)}
                                     className=
                                         {`w-full h-20 mb-2.5 pl-2.5 rounded-lg hover:bg-usmb-blue cursor-pointer 
                                         ${moduleClicked === module.id_module ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}
                                     onClick={getModuleInfos}>
                                    <p className={"font-medium"}>{module.nom}</p>
                                    <p>{module.code_module}</p>
                                </div>
                            </Link>
                        )}
                    </div>
                ) : status === "loading" ? (
                    <div className="flex justify-center">
                        <Loader />
                    </div>
                ) : (
                    <>
                        {router.push('/connection')}
                    </>
                )
            }
        </>
    )


}