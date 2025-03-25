export default function composantesEssentielles({composanteEssentielle}:{composanteEssentielle: any[]}){
    console.log(composanteEssentielle)
    return (
        <>
            <p>Composantes essentielles</p>
            {composantesEssentielles.length > 0 ? composanteEssentielle.map((composante: any) => (
                <p key={composante.id_composante_essentielle}>{composante.libelle_composante_essentielle}</p>
            )):
                <p>Pas d'informations dispo sur les composantes essentielles</p>
            }
        </>

    )
}