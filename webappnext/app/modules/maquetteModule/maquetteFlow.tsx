import React, {useState, useCallback, useEffect, useRef} from "react";
import {
    ReactFlow,
    Background,
    Controls,
    applyEdgeChanges,
    applyNodeChanges,
    useReactFlow,
} from "@xyflow/react";
import '@xyflow/react/dist/style.css';

import CustomNode from "@/app/modules/maquetteModule/customNode";

export default function MaquetteFlow({initialNodes, initialEdges, setWidth}:{initialNodes:any, initialEdges:any, setWidth:any}){
    const componentRef = useRef<HTMLDivElement>(null)
    const { fitView } = useReactFlow();
    const [majWidth, setMajWidth] = useState(0)
    const [nodes, setNodes] = useState(initialNodes);
    const [edges, setEdges] = useState(initialEdges);

    useEffect(() => {
        setNodes(initialNodes)
        setEdges(initialEdges)
    }, [initialNodes,initialEdges]);

    useEffect(() => {
        const timeout = setTimeout(() => {
            fitView({padding:0.1, duration:800})
        },300)
        return() => clearTimeout(timeout)
    }, [majWidth,initialEdges,initialNodes]);

    useEffect(() => {
        /*Permet de connaitre la largeur du flow pour afficher à la ligne les cours*/
        const element = componentRef.current; // Accéder à l'élément référencé
        if (!element) return;
        // Créer une instance de ResizeObserver
        const resizeObserver = new ResizeObserver((entries) => {
            if (entries.length > 0) {
                const newWidth = entries[0].contentRect.width; // Largeur actuelle
                setWidth(newWidth);
                setMajWidth(newWidth);
            }
        });

        // Observer l'élément
        resizeObserver.observe(element);

        // Nettoyer l'observation lorsque le composant est démonté
        return () => resizeObserver.disconnect();


    }, []);

    const onNodesChange = useCallback(
        (changes:any) => setNodes((nds:any) => applyNodeChanges(changes, nds)),
        [],
    );
    const onEdgesChange = useCallback(
        (changes:any) => setEdges((eds:any) => applyEdgeChanges(changes, eds)),
        [],
    );

    const nodeTypes = {
        customNode: CustomNode
    }

    return (

        <div ref={componentRef} style={{ height: '100%', width: '100%' }}>
            {(initialNodes.length == 0 && initialEdges == 0) ?
                <div className={"h-full w-full flex items-center justify-center"}>
                    <p className={"font-bold text-2xl text-usmb-red"}>Pas de maquette à afficher</p>
                </div>
                :
                <ReactFlow
                    nodes={nodes}
                    onNodesChange={onNodesChange}
                    edges={edges}
                    onEdgesChange={onEdgesChange}
                    nodeTypes={nodeTypes}
                >
                    <Background/>
                    <Controls/>
                </ReactFlow>
            }

        </div>
    )
}