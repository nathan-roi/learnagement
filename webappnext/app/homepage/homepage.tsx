import { useUserInfosStore } from "@/app/store/useUserInfosStore";

import ListCardsCharge from "@/app/homepage/charge/listCardsCharge";
import Filieres from "@/app/homepage/competences/filieres";


export default function Homepage(){
    const {user} = useUserInfosStore()

    return(
        <>
            <h1 className={"w-full text-center text-4xl font-bold mt-5"}>Bonjour, {user.userFirstname} ! 👋</h1>
            <div className={"h-screen flex flex-col items-center justify-around"}>
                {/*<h1 className={"absolute top-0 text-4xl font-bold mt-5"}>Bonjour, {user.userFirstname} ! 👋</h1>*/}
                <div className={"w-full self-start"}>
                    <h3 className={"text-2xl font-bold ml-5 mb-16"}>Ma charge de cours</h3>
                    <ListCardsCharge />
                </div>
                <div className={"w-full self-start"}>
                    <h3 className={"text-2xl font-bold ml-5 mb-16"}>Compétences par filières</h3>
                    <Filieres />
                </div>
            </div>

        </>
    )
}