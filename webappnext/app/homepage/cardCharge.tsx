import {useEffect, useState} from "react";

import Donut from "@/app/homepage/donutCharge";

interface ResCharge{
    Charge?: number,
    CM?: number,
    TD?: number,
    TP?: number
}
export default function CardCharge({detailsCharge}:{detailsCharge:ResCharge}){
    const [chargeTotal, setChargeTotal] = useState(-1)
    const [chargeCM, setChargeCM] = useState(-1)
    const [chargeTD, setChargeTD] = useState(-1)
    const [chargeTP, setChargeTP] = useState(-1)
    useEffect(() => {
        if (detailsCharge.Charge != undefined && detailsCharge.CM != undefined && detailsCharge.TD != undefined && detailsCharge.TP != undefined){
            setChargeTotal(detailsCharge.Charge)
            setChargeCM(detailsCharge.CM)
            setChargeTD(detailsCharge.TD)
            setChargeTP(detailsCharge.TP)
        }

    }, [detailsCharge]);

    console.log(chargeTotal)
    console.log(chargeCM)
    console.log(chargeTD)
    console.log(chargeTP)

    return(
        <div className={"w-full flex flex-grow justify-evenly"}>
            <div className={"h-56 w-56 shadow-md rounded-lg flex flex-col items-center justify-between"}>
                <h3 className={"text-2xl font-bold"}>CM</h3>
                <Donut chargeTotal={chargeTotal} chargePartielle={chargeCM} label={'CM'}/>
            </div>
            <div className={"h-56 w-56 shadow-md rounded-lg flex flex-col items-center justify-between"}>
                <h3 className={"text-2xl font-bold"}>TD</h3>
                <Donut chargeTotal={chargeTotal} chargePartielle={chargeTD} label={'TD'}/>
            </div>
            <div className={"h-56 w-56 shadow-md rounded-lg flex flex-col items-center justify-between"}>
                <h3 className={"text-2xl font-bold"}>TP</h3>
                <Donut chargeTotal={chargeTotal} chargePartielle={chargeTP} label={'TP'}/>
            </div>
        </div>
    )
}