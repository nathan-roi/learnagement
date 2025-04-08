import { withAuth } from "next-auth/middleware"

export default withAuth({
    pages: {
        signIn: "/", // Page de login si pas connecté
    },
})

export const config = {
    matcher: [
        "/activateAccount/:path*",
    ],
}