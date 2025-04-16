import Link from "next/link";

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
                                <li className="cursor-pointer">{module.code_module} - {module.nom}</li>
                            </Link>
                        );
                    })}
                </ul>
            </div>

        </div>
    )
}