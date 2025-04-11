import { create } from 'zustand'

type ListModules = {
    listModules: ModuleInfos[],
    charged: boolean,
    setListModules: (module: ModuleInfos[]) => void,
    setCharged: (charged: boolean) => void
}
export const useListModulesStore = create<ListModules>((set) => ({
    listModules: [],
    charged: false,
    setListModules: (modules: ModuleInfos[]) => set({ listModules: modules }),
    setCharged: (charged: boolean) => set({charged: charged})
}))

