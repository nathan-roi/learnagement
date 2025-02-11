import {useEffect, useState} from "react";

import Donut from "@/app/homepage/donutCharge";
export default function CardCharge({label, chargeTotal, charge}:{label:string, chargeTotal:number, charge:number}){


    return(

        <div className={"h-56 w-56 shadow-md rounded-lg flex flex-col items-center justify-between py-2"}>
            <h3 className={"text-2xl font-bold"}>{label}</h3>
            <Donut label={label} chargeTotal={chargeTotal} chargePartielle={charge}/>
        </div>

    )
}