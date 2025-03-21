import axios from "axios";
import {useEffect, useState} from "react";
export default function Filieres(){
    const [MCCCmodule, setMCCCmodule] = useState()

    useEffect(() => {
        axios.get("http://localhost:8080/select/selectFilieres.php")
            .then(response => {
                setMCCCmodule(response.data)
            })
    }, []);
    return (
        <p>Filières</p>
    )
}