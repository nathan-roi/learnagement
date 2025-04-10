import React from "react";
import HomeIcon from "@/public/home.svg"
import {useInfosModuleStore} from "@/app/store/useInfosModuleStore";

export default function LinkHomepage(){
    const {setModule} = useInfosModuleStore()

    return(
        <div className={"flex flex-row items-center gap-4 text-xl mt-2 mb-8 cursor-pointer"}>
            <HomeIcon width={24} height={24} />
            <p onClick={() => setModule({id_discipline: -1, id_module: -1, id_semestre: -1, nom: "", code_module: ""})}>HOMEPAGE</p>
        </div>
    )
}