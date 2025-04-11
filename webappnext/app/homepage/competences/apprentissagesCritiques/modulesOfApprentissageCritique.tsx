export default function modulesOfApprentissageCritique({listModules}:{listModules:ModuleOfApc[]}){

    return(
        <div className={`shadow-md rounded-b-lg bg-white`}>
            <p className={`border-t border-gray-300`}></p>
            <div className="p-2">
                {listModules.map((module: ModuleOfApc) => (
                    <p className="cursor-pointer text-sm">{module.code_module} - {module.nom}</p>
                ))}
            </div>

        </div>
    )
}