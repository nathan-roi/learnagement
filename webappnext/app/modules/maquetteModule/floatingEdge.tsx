import {getBezierPath, getSmoothStepPath, Position, useInternalNode} from '@xyflow/react';

import {getEdgeParams} from './calcEdgePosition.js';

function FloatingEdge({ id, source, target, markerEnd, style }:{id:any, source:any, target:any, markerEnd:any, style:any}) {
    const sourceNode = useInternalNode(source);
    const targetNode = useInternalNode(target);

    if (!sourceNode || !targetNode) {
        return null;
    }

    const { sx, sy, tx, ty, sourcePos, targetPos } = getEdgeParams(
        sourceNode,
        targetNode,
    );

    /* TODO : mettre le lien smoothstep quand retour à la ligne */
    // if (screenWidth){
    //     const [edgePath] = getBezierPath({
    //         sourceX: sx,
    //         sourceY: sy,
    //         sourcePosition: sourcePos,
    //         targetPosition: targetPos,
    //         targetX: tx,
    //         targetY: ty,
    //     });
    // }else{
    //     const [edgePath] = getSmoothStepPath({
    //         sourceX: sx,
    //         sourceY: sy,
    //         sourcePosition: Position.Bottom,
    //         targetPosition: Position.Top,
    //         targetX: tx-20,
    //         targetY: ty,
    //         borderRadius: 10
    //     });
    // }

    const [edgePath] = getBezierPath({
        sourceX: sx,
        sourceY: sy,
        sourcePosition: sourcePos,
        targetPosition: targetPos,
        targetX: tx,
        targetY: ty,
    })
    return (
        <path
            id={id}
            className="react-flow__edge-path"
            d={edgePath}
            markerEnd={markerEnd}
            style={style}
        />
    );
}

export default FloatingEdge;