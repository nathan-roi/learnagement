"use client";

import axios from "axios";
import React, {useEffect, useState} from "react";
import {Position, ReactFlowProvider} from "@xyflow/react";

import MaquetteFlow from "@/app/modules/maquetteModule/maquetteFlow";
import Loader from "@/app/loader"
export default function maquetteModule({code_module}:{code_module:string}){
    const [maquette, setMaquette] = useState([])
    const [nodes, setNodes] = useState<any[]>([])
    const [edges, setEdges] = useState<any[]>([])
    const [width, setWidth] = useState(0)
    const [isLoading, setIsLoading] = useState(true)

    useEffect(() => {
        setIsLoading(true)
        
        let form_data = new FormData()
        let id_view = '9'

        form_data.append("id_view", id_view)
        form_data.append("code_module", code_module)
        axios.post("http://localhost:8080/select/selectMaquette.php", form_data)
            .then(response => {
                setMaquette(response.data)
                setIsLoading(false)
            })

    }, [code_module]);

    useEffect(() => {
        if (maquette.length > 0) {
            // Appel de `createEdges` après la mise à jour de `maquette`
            createEdges(maquette);
        }else{
            setEdges([])
        }
    }, [maquette]);

    useEffect(() => {
        if (edges.length > 0){
            createNodes(edges)
        }else{
            setNodes([])
        }
    }, [edges,width]);

    function getSeances(edges:any){
        let tmpSeances = []

        let index = 0
        let i = 0
        let seancePred = edges[i].source
        let seanceSuiv = edges[i].target

        tmpSeances.push(seancePred)
        tmpSeances.push(seanceSuiv)

        while(i < edges.length){
            index = edges.findIndex((obj: { source: any; }) => obj.source === seanceSuiv)

            if (index != -1){

                seanceSuiv = edges[index].target
                tmpSeances.push(seanceSuiv)
            }else{
                seancePred = edges[i].source
                seanceSuiv = edges[i].target
                tmpSeances.push(seancePred, seanceSuiv)
            }

            i ++
        }
        return [...new Set(tmpSeances)]
    }

    function createNodes(edges: any){

        let seances = getSeances(edges)
        let nodes = []
        let x = 0
        let y = 0

        for (let i = 0; i < seances.length; i++) {
            let color
            let seance = seances[i]
            let type = seance.slice(0,2)

            if (type === 'CM'){
                color = 'bg-cm-red'
            }else if(type === 'TD'){
                color = 'bg-td-green'
            }else if(type === 'TP'){
                color = 'bg-tp-yellow'
            }else if(type === 'Ex'){
                color = 'bg-exam-blue'
            }else{
                color = 'bg-other-pink'
            }

            let node = {
                id: seance,
                type: 'customNode',
                position : {x: x, y: y},
                data: {label: seance, color:color},
                sourcePosition: Position.Right, // Les liens sortent par la droite
                targetPosition: Position.Left,  // Les liens entrent par la gauche
            }

            nodes.push(node)

            if(x >= width){
                y += 200
                x = 0
            }else{
                x += 200
            }
        }
        setNodes(nodes)
    }
    
    function createEdges(maquette:any){
        let edges = []

        for (let i = 0; i < maquette.length; i++) {
            let pred = maquette[i]['séance précédente']
            let suiv = maquette[i]['séance suivante']

            let link = {
                id: pred + '-' + suiv,
                source: pred,
                target: suiv
            }
            edges.push(link)
        }
        setEdges(edges)
    }

    return (
        <div className={"h-screen w-full"}>
            {!isLoading ? (
                <ReactFlowProvider>
                    <MaquetteFlow initialNodes={nodes} initialEdges={edges} setWidth={setWidth}/>
                </ReactFlowProvider>
            ) : (
                <div className={"h-full w-full flex items-center justify-center"}>
                    <Loader/>
                </div>
            )}
        </div>
    )
}