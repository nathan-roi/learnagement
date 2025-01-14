"use client";

import React, {useState} from "react";
import Link from "next/link";
import bcrypt from 'bcryptjs';

export default function ActivateAccount() {
    const [pwd, setPwd] = useState('')
    const [hash, setHash] = useState('')
    async function hashPassword(event:any) {
        event.preventDefault()
        let form = event.currentTarget

        try {
            setHash(await bcrypt.hash(pwd, 10));
            console.log('Hash généré :', hash);
        } catch (err) {
            console.error('Erreur lors du hashage :', err);
        }
        form.reset()
    }

    return (
        <div>
            <p>
                To activate (or change your password of) your account, send the hash of your password to Learnagement admin.
                WARNING! Communications are not crypted, do not use a main password.
            </p>
            <form method='post' onSubmit={hashPassword}>
                <input type="password" id="pwd" name="password" onChange={e => setPwd(e.target.value)} />
                <button type="submit" value="hash" />
            </form>
            {pwd != '' && hash}
            <Link href={"/"} className={"underline text-usmb-cyan"}>Retour</Link>
        </div>
    );
}
