// app/api/proxy/[...phpPath]/route.ts
import axios from "axios";
import { NextRequest } from "next/server";

export async function POST(req: NextRequest) {
    // Récupère tout ce qu’il y a après /api/proxy/
    const fullPath = req.nextUrl.pathname.replace(/^\/api\/proxy\//, "");

    // Récupère le type de content utilisé
    const contentType = req.headers.get("content-type") || "application/x-www-form-urlencoded";

    // Récupère le corps tel quel
    const body = await req.text();

    try {
        const cookie = req.headers.get("cookie") || "";

        const response = await axios.post(`http://php/${fullPath}.php`, body, {
            headers: {
                "Content-Type": contentType,
                Cookie: cookie
            },
            withCredentials: true,
        });

        return new Response(JSON.stringify(response.data), {
            status: response.status,
            headers: {
                "Content-Type": "application/json",
            },
        });

    } catch (error: any) {
        console.error("Erreur proxy:", error.message);
        return new Response(JSON.stringify({ error: "Erreur dans le proxy." }), {
            status: 500,
        });
    }
}
