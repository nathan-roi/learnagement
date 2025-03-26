export default function composantesEssentielles({composanteEssentielle}:{composanteEssentielle: any[]}){
    return (
        <div className={"w-2/4 px-1"}>
            <h4>Composantes essentielles</h4>
            <ul className={"list-disc list-inside"}>
                {composantesEssentielles.length > 0  ? composanteEssentielle.map((composante: any) => (
                        <li key={composante.id_composante_essentielle}>{composante.libelle_composante_essentielle}</li>
                    )):
                    <p>Pas d'informations dispo sur les composantes essentielles</p>
                }
            </ul>
        </div>

    )
}