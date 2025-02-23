import { create } from 'zustand'

export const useUserInfosStore = create<User>()((set) => ({
    user: {loggedin:false, start:0, userLogin:"", userId:"", userFirstname:"", userLastname:""},
    setUser: (userInfos: UserInfos) => set({user: userInfos}), /* Mise à jour des infos utilisateur */
    setLoggedin: (bool: boolean) => set((state) => ({user: {...state.user, loggedin:bool}})) 
}))
