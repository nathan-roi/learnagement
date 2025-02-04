import {useEffect, useState} from "react";
import axios from "axios";

export default function Homepage({userId} : {userId : string}){
    const [err, setErr] = useState('')
    const [charge, setCharge] = useState(-1)

    useEffect(() => {

        let form_data = new FormData()
        form_data.append("user_id", userId)
        axios.post("http://localhost:8080/select/selectChargeEnseignant.php", form_data)
            .then(response => {
                let data = response.data
                if (!data[0]){
                    setErr(data[1])
                }else{
                    setCharge(data[0].Charge)
                }
            })
    }, [userId]);
    console.log(userId)
    return(
        <div className={"h-screen flex justify-center items-center"}>
            <h1>HOMEPAGE</h1>
            <p>{charge >= 0 && charge}</p>
            <p>{err != '' && err}</p>
        </div>
    )
}