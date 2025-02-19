import { create } from 'zustand'

type userInfos = {
    user: UserInfos
    setUser: (infos: UserInfos) => void
    setLoggedin: (bool: boolean) => void
}
export const useUserInfosStore = create<userInfos>()((set) => ({
    user: {loggedin:false, start:0, userLogin:"", userId:"", userFirstname:"", userLastname:""},
    setUser: (userInfos: UserInfos) => set({user: userInfos}),
    setLoggedin: (bool: boolean) => set((state) => ({user: {...state.user, loggedin:bool}}))
}))
