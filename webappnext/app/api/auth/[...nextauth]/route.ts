import NextAuth from "next-auth"

import Credentials from "next-auth/providers/credentials"
import axios from "axios";

interface User {
    id: string;
    email: string;
    name: string;
}

const handler= NextAuth({
    providers: [
        Credentials({

            // You can specify which fields should be submitted, by adding keys to the `credentials` object.
            // e.g. domain, username, password, 2FA token, etc.
            credentials: {
                username: {label: "username", type: "text"},
                password: {label: "password", type: "password"},
            },
            authorize: async (credentials): Promise<User | null> => {
                if (!credentials) return null

                let formData = new FormData()
                formData.append("username", credentials.username)
                formData.append("password", credentials.password)

                try {
                    const res = await axios.post("http://php/connection/authenticate.php", formData)

                    if (res.status === 200) {
                        console.log(res.data)
                        return res.data as User
                    } else {
                        return null
                    }
                } catch (err) {
                    console.error("Authentication failed", err)
                    return null
                }
            }
        }),
    ],
    callbacks: {
        async jwt({ token, user }) {
            // `user` est défini uniquement à la connexion
            if (user) {
                token.user = user
            }
            return token
        },

        async session({ session, token }) {
            // Injecte l'utilisateur dans la session
            session.user = token.user
            return session
        },

        async redirect({ url, baseUrl }) {
            // Rediriger vers une page spécifique après la connexion
            return '/homepage'; // Remplacez par la page souhaitée
        }
    },
    secret: process.env.NEXTAUTH_SECRET
})

export {handler as GET, handler as POST}