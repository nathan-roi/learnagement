import Link from "next/link";
import LinkHomepage from "@/app/homepage/linkHomepage";
import ListModules from "@/app/modules/listModules";
import Disconnection from "@/app/connection/disconnection";

export default function sideMenu(){
    return (
        <aside className={"h-screen col-span-1 p-2.5 bg-usmb-dark-blue text-white"}>
            <Link href={'/homepage'}><LinkHomepage /></Link>
            <ListModules />
            <Disconnection />
        </aside>
    )
}