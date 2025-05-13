'use client'

import FiliereContent from "@/app/homepage/competences/modaleFiliere"
import {useSearchParams} from "next/navigation";
import {useState} from "react";

export default function Page() {
    const searchParams = useSearchParams()
    const [nomCourt, setNomCourt] = useState<string>(searchParams.get("nomCourt") || "")
    const [nomLong, setNomLong] = useState<string>(searchParams.get("nomLong") || "")

    const [nomFiliere, setNomFiliere] = useState<string[]>([nomCourt, nomLong])

    return (
        <p>Infos d'une filière</p>
    )
}