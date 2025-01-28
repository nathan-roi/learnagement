import React, {useState, useCallback, useEffect, useRef} from "react";
import {
    ReactFlow,
    Background,
    Controls,
    useReactFlow, useNodesState, useEdgesState, addEdge, MarkerType,
}
from "@xyflow/react";
import '@xyflow/react/dist/style.css';
import FloatingEdge from './floatingEdge';
import CustomNode from "@/app/modules/maquetteModule/customNode";
import floatingConnectionLine from "@/app/modules/maquetteModule/floatingConnectionLine";

export default function MaquetteFlow({initialNodes, initialEdges, setWidth}:{initialNodes:any, initialEdges:any, setWidth:any}){
    const componentRef = useRef<HTMLDivElement>(null)
    const { fitView } = useReactFlow();
    const [majWidth, setMajWidth] = useState(0)
    const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
    const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);


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

    const onConnect = useCallback(
        (params:any) =>
            setEdges((eds) =>
                addEdge(
                    {
                        ...params,
                        type: 'floating',
                        markerEnd: { type: MarkerType.ArrowClosed },
                    },
                    eds,
                ),
            ),
        [setEdges],
    );


    const nodeTypes = {
        customNode: CustomNode
    }

    const edgeTypes = {
        floating: FloatingEdge
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
                    edges={edges}
                    onNodesChange={onNodesChange}
                    onEdgesChange={onEdgesChange}
                    nodeTypes={nodeTypes}
                    // @ts-ignore j'ai suivis la doc de react flow
                    edgeTypes={edgeTypes}
                    onConnect={onConnect}
                    connectionLineComponent={floatingConnectionLine}
                >
                    <Background/>
                    <Controls/>
                </ReactFlow>
            }
        </div>
    )
}