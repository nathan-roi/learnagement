import { withAuth } from "next-auth/middleware"

export default withAuth({
    pages: {
        signIn: "/connection", // Page de login si pas connecté
    },
})

export const config = {
    matcher: [
        "/homepage:path*",
    ],
}