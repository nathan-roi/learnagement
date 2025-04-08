import NextAuth from "next-auth"
import Credentials from "next-auth/providers/credentials"
import axios from "axios";

export const handler= NextAuth({
    providers: [
        Credentials({
            id: "",
            // You can specify which fields should be submitted, by adding keys to the `credentials` object.
            // e.g. domain, username, password, 2FA token, etc.
            credentials: {
                username: {label: "username", type: "text"},
                password: {label: "password", type: "password"},
            },
            authorize: async (credentials): Promise<UserInfos | null> => {
                if (!credentials){return null}
                let user = null
               axios.post("http://localhost:8080/connection/authenticate.php", {username: credentials.username, password: credentials.password})
                   .then(response => {

                       if (response.status === 200){
                           user = response.data
                       }else{
                           throw new Error("Invalid credentials")
                       }
                   })
                   .catch(error => {
                       console.error("Authentication failed", error)
                       throw new Error("Invalid credentials.")
                   })

                return user
            }
        }),
    ]
})

export {handler as POST, handler as GET}