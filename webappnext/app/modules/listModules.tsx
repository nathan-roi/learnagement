"use client"

import {useEffect, useState} from "react";
import {useListModulesStore} from "@/app/store/useListModulesStore";
import {useSession} from "next-auth/react";
import {useSearchParams} from "next/navigation";

import Loader from "@/app/indicators/loader";
import router from "next/router";
import Link from "next/link";

export default function ListModule(){
    const {data: session, status} = useSession()
    const {listModules} = useListModulesStore()
    const [moduleClicked, setModuleClicked] = useState(-1)

    /* Permet de connaitre le module qui est sélectionné et donc d'afficher d'une couleur différente la div en question */
    const searchParams = useSearchParams()
    const  id_module = searchParams.get("id_module")

    useEffect(() => {
        if (id_module != undefined){
            setModuleClicked(parseInt(id_module))
        }
    }, [searchParams]);


    return (
        <>
            {
                status === "authenticated" ? (
                    <div className={"h-3/4 overflow-y-auto"}>
                        {Object.values(listModules).map((module: ModuleInfos) =>
                            <Link key={module.id_module} href={{pathname : '/modules', query: {id_module: module.id_module}}}>
                                <div id={String(module.id_module)}
                                     className=
                                         {`w-full h-20 mb-2.5 pl-2.5 rounded-lg hover:bg-usmb-blue cursor-pointer 
                                         ${moduleClicked === module.id_module ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}
                                     >
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