import { useUserInfosStore } from "@/app/store/useUserInfosStore";

import ListCardsCharge from "@/app/homepage/charge/listCardsCharge";
import Filieres from "@/app/homepage/competences/filieres";


export default function Homepage(){
    const {user} = useUserInfosStore()

    return(
        <>
            <h1>Bonjour, {user.userFirstname} ! 👋</h1>
            <div className={"h-screen flex flex-col items-center justify-around"}>
                <div className={"w-full self-start"}>
                    <h3>Ma charge de cours</h3>
                    <ListCardsCharge />
                </div>
                <div className={"w-full self-start"}>
                    <h3>Compétences par filières</h3>
                    <Filieres />
                </div>
            </div>

        </>
    )
}