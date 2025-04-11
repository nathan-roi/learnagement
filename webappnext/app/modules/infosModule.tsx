"use client";
import MaquetteModule from './maquetteModule/maquetteModule'
import {useInfosModuleStore} from "@/app/store/useInfosModuleStore";

export default function InfosModule(){
    const {module} = useInfosModuleStore()

    return (
        <div className={"h-screen flex flex-col items-center"}>
            <div>
                <h1 className={"font-bold text-4xl mb-5"}>
                    {(module.code_module != null && module.nom != null) && <>{module.code_module} - {module.nom}</>}
                </h1>
                <div className={"w-full flex justify-around font-bold"}>
                    {module.hCM != null && <p>Heures CM : {module.hCM}</p>}
                    {module.hTD != null && <p>Heures TD : {module.hTD}</p>}
                    {module.hTP != null && <p>Heures TP : {module.hTP}</p>}
                </div>
            </div>
            {module.nom != null && <MaquetteModule code_module={module.code_module}/>}
        </div>
    )
}