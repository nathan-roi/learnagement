"use client";
import React, {useState} from "react";
import axios from "axios";

import Connection from "./connection/connection";
import Disconnection from "./connection/disconnection"

export default function Home() {
  const [isConnect, setIsConnect] = useState(false);

  return (
      <>
          {!isConnect ?
              <Connection setConnect={setIsConnect}/>
              :
              <>
                  <p>successfully connected</p>
                  <Disconnection setIsConnect={setIsConnect}/>
              </>
          }

      </>
  );
}
