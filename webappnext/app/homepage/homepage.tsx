import ListCardsCharge from "@/app/homepage/charge/listCardsCharge";

interface User{
    userId: string,
    userFirstname: string
}

export default function Homepage({userInfos} : {userInfos : User}){


    return(
        <div className={"h-screen flex flex-col items-center justify-evenly"}>
            <h1 className={"absolute top-0 text-4xl font-bold mt-5"}>Bonjour, {userInfos.userFirstname} ! 👋</h1>
            <div className={"w-full self-start"}>
                <h3 className={"text-2xl font-bold ml-5 mb-16"}>Ma charge de cours</h3>
                <ListCardsCharge userId={userInfos.userId} />
            </div>

        </div>
    )
}