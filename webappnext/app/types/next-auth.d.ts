// types/next-auth.d.ts
import NextAuth from "next-auth"

declare module "next-auth" {
    interface Session {
        user: {
            id: string;
            email?: string | null;
            name?: string | null;
            nom?: string; // Si tu as un champ nom dans ton back
            // Ajoute d'autres propriétés ici si besoin
        }
    }

    interface User {
        id: string;
        email?: string;
        name?: string;
        nom?: string;
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
