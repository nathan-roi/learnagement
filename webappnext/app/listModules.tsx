import axios from "axios";
import {useEffect, useState} from "react";

interface Module {
    id_module: string;
    nom: string;
    code_module: string;
}

export default function ListModule(){
    const [listeModules, setListeModules] = useState<Module[]>([]);

    useEffect(() => {

        axios.get("http://localhost:8080/list/listResponsableModule.php")
            .then(response => {
                setListeModules(response.data)
            })

    }, []);
    console.log(listeModules)
    const listeModulesHTML = listeModules.map(module =>
        <div key={module.id_module} className={"w-full mb-2.5 p-1 rounded-lg bg-usmb-cyan cursor-pointer"}>
            <p>{module.nom}</p>
            <p>{module.code_module}</p>
        </div>
    )

    return (
        <>
            {listeModulesHTML}
        </>

    )
}