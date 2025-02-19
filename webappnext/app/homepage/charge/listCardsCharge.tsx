import axios from "axios";
import {useEffect, useState} from "react";
import { useUserInfosStore } from "@/app/store/useUserInfosStore";

import CardCharge from "@/app/homepage/charge/cardCharge";
import { ChargeState, ChargeType } from "@/app/types/charges";


export default function ListCardsCharge(){
    const [charges, setCharges] = useState<ChargeState>({
        Charge: -1,
        CM: -1,
        TD: -1,
        TP: -1
    })

    const {user} = useUserInfosStore()

    const chargeTotCmTdTp = charges.CM + charges.TD + charges.TP

    useEffect(() => {

        let form_data = new FormData()
        form_data.append("user_id", user.userId)
        axios.post("http://localhost:8080/select/selectChargeEnseignant.php", form_data)
            .then(response => {
                if (response.data[0] != false){
                    setCharges(response.data)
                }else{
                    console.log('erreur')
                }

            })

    }, [user.userId]);

    const chargeTypes: ChargeType[] = ['CM', 'TD', 'TP'];

    return(
        <div className={"w-full flex flex-grow justify-evenly"}>
            {charges.Charge == chargeTotCmTdTp ?
                <CardCharge label={'TOTAL'} dataDonut={[charges.CM, charges.TD, charges.TP]}/>
                :
                <CardCharge label={'TOTAL'} dataDonut={[charges.CM, charges.TD, charges.TP, charges.Charge - chargeTotCmTdTp]}/>
            }
            {chargeTypes.map((type) => (
                <CardCharge
                    key={type}
                    label={type}
                    dataDonut={[charges[type], charges.Charge - charges[type]]}
                />
            ))}
        </div>
    )
}