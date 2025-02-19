import { create } from 'zustand'

type userInfosConn = {
    loggedin: boolean,
    start: number,

    setLoggedin: (bool:boolean) => void
}

export const useAuthStore = create<userInfosConn>()((set) => ({
    loggedin: false,
    start: 0,

    setLoggedin: (bool) => set({loggedin: bool})
}))
