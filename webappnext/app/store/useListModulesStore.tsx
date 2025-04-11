import { create } from 'zustand'

type ListModules = {
    listModules: Record<number, ModuleInfos>,
    charged: boolean,
    setListModules: (module: Record<number, ModuleInfos>) => void,
    setCharged: (charged: boolean) => void
}
export const useListModulesStore = create<ListModules>((set) => ({
    listModules: {},
    charged: false,
    setListModules: (modules: Record<number, ModuleInfos>) => set({ listModules: modules }),
    setCharged: (charged: boolean) => set({charged: charged})
}))

