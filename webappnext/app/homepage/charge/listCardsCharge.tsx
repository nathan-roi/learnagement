import axios from "axios";
import {useEffect, useState} from "react";

import CardCharge from "@/app/homepage/charge/cardCharge";
import { ChargeState, ChargeType } from "@/app/types/charges";


export default function ListCardsCharge({userFirstname, userLastname}:{userFirstname: string, userLastname: string}){
    const [charges, setCharges] = useState<ChargeState>({
        Charge: -1,
        CM: -1,
        TD: -1,
        TP: -1
    })

    useEffect(() => {

        let form_data = new FormData()
        form_data.append("userFirstname", userFirstname)
        form_data.append("userLastname", userLastname)
        axios.post("http://localhost:8080/select/selectChargeEnseignant.php", form_data)
            .then(response => {
                setCharges(response.data)
            })

    }, [userFirstname, userLastname]);

    const chargeTypes: ChargeType[] = ['CM', 'TD', 'TP'];

    return(
        <div className={"w-full flex flex-grow justify-evenly"}>
            <CardCharge label={'TOTAL'} dataDonut={[charges['CM'], charges['TD'], charges['TP']]}/>
            {chargeTypes.map((type) => (
                <CardCharge
                    key={type}
                    label={type}
                    dataDonut={[charges[type], charges['Charge'] - charges[type]]}
                />
            ))}
        </div>
    )
}