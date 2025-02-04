import {useEffect, useState} from "react";
import axios from "axios";

export default function Homepage(){
    const [charge, setCharge] = useState(-1)
    useEffect(() => {

        let form_data = new FormData()
        let userId = "18"
        form_data.append("user_id", userId)
        axios.post("http://localhost:8080/select/selectChargeEnseignant.php", form_data)
            .then(response => {
                setCharge(response.data[0].Charge)
            })
    }, []);
    return(
        <div className={"h-screen flex justify-center items-center"}>
            <h1>HOMEPAGE</h1>
            <p>{charge}</p>
        </div>
    )
}