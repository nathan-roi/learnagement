import axios from "axios";
import {useEffect, useState} from "react";
import { useUserInfosStore } from "@/app/store/useUserInfosStore";

export default function Filieres(){
    const {user} = useUserInfosStore()
    const [MCCCmodule, setMCCCmodule] = useState()

    useEffect(() => {
        let form_data = new FormData()
        form_data.append("userId", user.userId)
        axios.post("http://localhost:8080/select/selectFilieres.php", form_data)
            .then(response => {
                setMCCCmodule(response.data)
            })
    }, []);
    return (
        <p>Filières</p>
    )
}