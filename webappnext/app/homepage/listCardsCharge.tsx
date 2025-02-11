import {useEffect, useState} from "react";

import CardCharge from "@/app/homepage/cardCharge";
import { ChargeState, ChargeType } from "@/app/types/charges";

interface ResCharge{
    Charge?: number,
    CM?: number,
    TD?: number,
    TP?: number
}

export default function ListCardsCharge({detailsCharge}:{detailsCharge:ResCharge}){
    const [charges, setCharges] = useState<ChargeState>({
        total: -1,
        CM: -1,
        TD: -1,
        TP: -1
    })

    useEffect(() => {
        if (detailsCharge.Charge != undefined && detailsCharge.CM != undefined && detailsCharge.TD != undefined && detailsCharge.TP != undefined){
            setCharges({
                total: detailsCharge.Charge,
                CM: detailsCharge.CM,
                TD: detailsCharge.TD,
                TP: detailsCharge.TP
            })
        }

    }, [detailsCharge]);

    console.log(detailsCharge)
    const chargeTypes: ChargeType[] = ['CM', 'TD', 'TP'];

    return(
        <div className={"w-full flex flex-grow justify-evenly"}>
            {chargeTypes.map((type) => (
                <CardCharge
                    key={type}
                    label={type}
                    chargeTotal={charges.total}
                    charge={charges[type]}
                />
            ))}
        </div>
    )
}