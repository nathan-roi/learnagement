
export default function listCompetences({infosCompetences, setIdCompetenceClicked}:{infosCompetences: infosCompetence[], setIdCompetenceClicked:any}){
    // console.log(infosCompetences)
    return(
        <>
            <p>Compétences</p>
            {infosCompetences.length > 0 ?
                infosCompetences.map((competence:infosCompetence) => (
                <p key={competence.id_competence} onClick={() => setIdCompetenceClicked(competence.id_competence)}>{competence.libelle_competence}</p>
            )):
                <p>Pas d'informations sur les compétences pour cette filière</p>}
        </>
    )
}