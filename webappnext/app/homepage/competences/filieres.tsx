import axios from "axios";
import {useEffect, useState} from "react";
import {useSession} from "next-auth/react";

import ModaleFiliere from "@/app/homepage/competences/modaleFiliere";
import polytechLogo from "@/app/images/Logo_Reseau_Polytech.svg";
import usmbLogo from "@/app/images/Logo_USMB_web_grand_RVB.png";

export default function Filieres(){
    const {data: session, status} = useSession()
    const [nomFilieres, setNomFilieres] = useState<string[]>([])
    const [nomFiliereClicked, setNomFiliereClicked] = useState([])

    useEffect(() => {
        if (status === "authenticated"){
            axios.get('/api/proxy/select/selectFilieres', {withCredentials: true})
                .then(response => {
                    setNomFilieres(response.data)
                })
        }
    }, [status]);

    function filiereClicked(str: string){
        let res:any = nomFilieres.find((element: string): boolean => str == element[0])
        if(res != undefined){
            setNomFiliereClicked(res)
        }
    }

    return (
        <>
            <div id="cards-container" className={"w-full px-3 flex flex-wrap justify-center gap-10 gap-y-8"}>
                {nomFilieres.length > 0 ? (
                    nomFilieres.map((nom: string, index: number) => (
                        <div
                            key={index}
                            onClick={(event: any): void => {
                                filiereClicked(event.target.innerText);
                            }}
                            className={
                                "w-60 h-16 flex justify-start items-center rounded-lg shadow-default cursor-pointer gap-2 px-2"
                            }
                        >
                            <img
                                src={nom[0] === "POLYTECH" ? polytechLogo.src : usmbLogo.src}
                                alt="logo"
                                className="w-8 h-8 object-contain"
                            />
                            <p className={"font-semibold"}>{nom[0]}</p>
                        </div>
                    ))
                ) : (
                    <p>Aucune filière disponible.</p>
                )}
            </div>
            {nomFiliereClicked.length > 0 && (
                 <ModaleFiliere
                     nomFiliere={nomFiliereClicked}
                    setNomFiliere={setNomFiliereClicked}
                />
            )}
        </>
    )
}