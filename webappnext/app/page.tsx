"use client";
import React, {useState} from "react";

import Connection from "./connection/connection";



export default function Home() {
  const [isConnect, setIsConnect] = useState(false)
    console.log(isConnect)
  return (
      <>
          {!isConnect ?  <Connection setConnect={setIsConnect}/> : <p>successfully connected</p>}

      </>
  );
}
