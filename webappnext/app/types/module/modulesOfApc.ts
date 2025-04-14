interface ModuleOfApc {
    id_apprentissage_critique: number,
    id_module: number,
    code_module: string,
    nom: string
}

interface ModulesOfAPC{
    [key: number]: ModuleOfApc[]
}
