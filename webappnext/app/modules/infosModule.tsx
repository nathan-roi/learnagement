"use client";

interface Module {
    nom: string;
    code_module: string;
    hCM: string;
    hTD: string;
    hTP: string;
}

export default function InfosModule({infos}: {infos : Module}){
    console.log(infos)
    return (
        <div className={"flex flex-col items-center"}>
            <div>
                <h1 className={"font-bold text-4xl mb-5"}>{infos.code_module} - {infos.nom}</h1>
                <div className={"w-full flex justify-around font-bold"}>
                    {infos.hCM != null && <p>Heures CM : {infos.hCM}</p>}
                    {infos.hTD != null && <p>Heures TD : {infos.hTD}</p>}
                    {infos.hTP != null && <p>Heures TP : {infos.hTP}</p>}
                </div>
            </div>

        </div>

    )
}