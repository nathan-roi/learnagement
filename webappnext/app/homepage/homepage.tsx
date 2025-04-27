import {useSession} from "next-auth/react";
import {Suspense, useEffect} from "react";
import {useRouter} from "next/navigation";

import ListCardsCharge from "@/app/homepage/charge/listCardsCharge";
import Filieres from "@/app/homepage/competences/filieres"
import Loader from "@/app/indicators/loading";



export default function Homepage(){
    const {data: session, status} = useSession()
    const router = useRouter()

    useEffect(() => {
        if(status == 'unauthenticated'){
            router.push('/connection')
        }
    }, [session, router]);

    return(
        <>
            {session && <h1>Bonjour, {session.user.firstname} ! 👋</h1>}
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