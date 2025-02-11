import {useEffect, useState} from "react";
import axios from "axios";

import listCardsCharge from "@/app/homepage/listCardsCharge";
import ListCardsCharge from "@/app/homepage/listCardsCharge";

interface User{
    userFirstname: string,
    userLastname: string
}

export default function Homepage({userInfos} : {userInfos : User}){
    const [detailsCharge, setDetailsCharge] = useState({
        Charge: -1,
        CM: -1,
        TD: -1,
        TP: -1
    })

    useEffect(() => {

        let form_data = new FormData()
        form_data.append("userFirstname", userInfos.userFirstname)
        form_data.append("userLastname", userInfos.userLastname)
        axios.post("http://localhost:8080/select/selectChargeEnseignant.php", form_data)
            .then(response => {
                setDetailsCharge(response.data)
            })
    }, [userInfos]);


    return(
        <div>
            <h1 className={"text-center text-4xl font-bold mt-5"}>Bonjour, {userInfos.userFirstname} ! 👋</h1>
            <div>
                <h3 className={"text-2xl font-bold ml-5 mb-16"}>Ma charge de cours</h3>
                <ListCardsCharge detailsCharge={detailsCharge}/>
            </div>

        </div>
    )
}