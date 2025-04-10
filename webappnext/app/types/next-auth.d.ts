// types/next-auth.d.ts
import NextAuth from "next-auth"

declare module "next-auth" {
    interface Session {
        user: {
            id: string;
            email?: string | null;
            name?: string | null;
            sessionId: string;
        }
    }

    interface User {
        id: string;
        email?: string;
        name?: string;
        sessionId: string;
    }
}

declare module "next-auth/jwt" {
    interface JWT {
        user: {
            id: string;
            email?: string;
            name?: string;
            nom?: string;
        }
    }
}
