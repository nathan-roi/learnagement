
export default function listCompetences({infosCompetences}:{infosCompetences: infosCompetence[]}){
    console.log(infosCompetences)
    return(
        <>
            <p>Compétences</p>
            {infosCompetences.length > 0 ?
                infosCompetences.map((competence:infosCompetence) => (
                <p>{competence.libelle_competence}</p>
            )):
                <p>Pas d'informations sur les compétences pour cette filière</p>}
        </>
    )
}