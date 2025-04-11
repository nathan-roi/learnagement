export default function modulesOfApprentissageCritique({listModules}:{listModules:ModuleOfApc[]}){

    return(
        <div className={`shadow-md rounded-b-lg bg-white`}>
            <p className={`border-t border-gray-300`}></p>
            <div className="p-2">
                {listModules.map((module: ModuleOfApc) => (
                    <ul className={`list-disc list-inside text-sm/6`}>
                        <li className="cursor-pointer">{module.code_module} - {module.nom}</li>
                    </ul>
                ))}
            </div>

        </div>
    )
}