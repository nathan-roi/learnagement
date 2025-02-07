import {memo, useState} from "react";
import { Handle, Position } from '@xyflow/react';



function CustomNode({data}:{data:any}){

    return (
        <div className={`px-10 py-2.5 shadow-md rounded-md border-2 border-stone-400 ${data.color}`}>
            <div className={"text-lg font-bold"}>{data.label}</div>

            <Handle
                type="target"
                position={Position.Left}
                className={"opacity-0"}
            />
            <Handle
                type="source"
                position={Position.Right}
                className={"opacity-0"} // les petits ronds qui permettent l'existence des liens ne se voient pas

            />
        </div>
    )
}

export default memo(CustomNode)