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

    const modulesAvecLien = listModules.filter((m: ModuleInfos) => m.has_learning_unit);
    const modulesSansLien = listModules.filter((m: ModuleInfos) => !m.has_learning_unit);

    function renderModule(module: ModuleInfos, isWithoutLink = false) {
        return (
            <div
                key={module.id_module}
                id={String(module.id_module)}
                className={`w-full h-20 mb-2.5 pl-2.5 rounded-lg cursor-pointer 
          ${
                    isWithoutLink
                        ? "border border-red-500 bg-red-500/60 text-gray-300 hover:bg-red-500/80"
                        : `hover:bg-usmb-blue ${
                            moduleClicked === module.id_module
                                ? "bg-usmb-blue"
                                : "bg-usmb-cyan"
                        }`
                }`}
                onClick={getModuleInfos}
            >
                <p className={"font-medium"}>{module.nom}</p>
                <p>{module.code_module}</p>
            </div>
        );
    }

    return (
        <div className={"h-3/4 overflow-y-auto"}>
            {modulesAvecLien.map((m) => renderModule(m))}
            <div className={"border-t border-gray-400 my-4"} />
            {modulesSansLien.map((m) => renderModule(m, true))}
        </div>
    );

    // return (
    //     <>
    //         {
    //             status === "authenticated" ? (
    //                 <div className={"h-3/4 overflow-y-auto"}>
    //                     {listeModules.map((module: ModuleInfos) =>
    //                         <div key={module.id_module} id={String(module.id_module)}
    //                              className=
    //                                  {`w-full h-20 mb-2.5 pl-2.5 rounded-lg hover:bg-usmb-blue cursor-pointer
    //                                  ${moduleClicked === module.id_module ? 'bg-usmb-blue' : 'bg-usmb-cyan'}`}
    //                              onClick={getModuleInfos}>
    //                             <p className={"font-medium"}>{module.nom}</p>
    //                             <p>{module.code_module}</p>
    //                         </div>
    //                     )}
    //                 </div>
    //             ) : status === "loading" ? (
    //                 <div className="flex justify-center">
    //                     <Loader />
    //                 </div>
    //             ) : (
    //                 <>
    //                     {router.push('/connection')}
    //                 </>
    //             )
    //         }
    //     </>
    // )
}