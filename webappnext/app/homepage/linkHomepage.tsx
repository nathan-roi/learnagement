import React from "react";
import HomeIcon from "@/public/home.svg"

export default function LinkHomepage({setInfosModule}:{setInfosModule:any}){

    return(
        <div className={"flex flex-row items-center gap-4 text-xl mt-2 mb-8 cursor-pointer"}>
            <HomeIcon width={24} height={24} />
            <p onClick={() => setInfosModule({code_module: "null"})}>HOMEPAGE</p>
        </div>
    )
}