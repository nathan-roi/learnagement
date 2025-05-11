// Composant des modules d'apprentissage critique
// Affiche la liste des modules associés à un apprentissage critique
// Props:
// - listModules: Tableau des modules
// Composants importés:

import Link from "next/link";

/**
 * Composant des modules d'apprentissage critique
 * Affiche la liste des modules associés à un apprentissage critique
 * 
 * @param {ModuleOfApc[]} listModules - Tableau des modules
 * @returns {JSX.Element} Composant React
 */
export default function modulesOfApprentissageCritique({listModules}:{listModules:ModuleOfApc[]}){

    return(
        <div className={`shadow-md rounded-b-lg bg-white`}>
            <p className={`border-t border-gray-300`}></p>
            <div className="p-2">
                <ul className={`list-disc list-inside text-sm/6`}>
                    {listModules.map((module: ModuleOfApc) => {
                        return (
                            <Link key={module.id_module}
                                  href={{pathname: '/modules', query: {id_module: module.id_module}}}>

                                <li className="cursor-pointer">
                                    <span className={"underline text-usmb-blue hover:text-usmb-dark-blue"}>
                                        {module.code_module} - {module.nom}
                                    </span>
                                </li>

                            </Link>
                        );
                    })}
                </ul>
            </div>

        </div>
    )
}