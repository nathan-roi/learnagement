import { memo } from "react";
import { Handle, Position } from "@xyflow/react";
import axios from "axios";

function CustomNode({
  data,
  setDisplayCardCourse,
}: {
  data: any;
  setDisplayCardCourse: (course: any) => void;
}) {
  const handleClick = (e: any) => {
    e.stopPropagation();
    console.log("Custom Node Clicked:", data);

    const formData = new FormData();
    formData.append("input", data.label);

    axios
      .post("http://localhost:8080/select/selectSeance.php", formData)
      .then((response) => {
        console.log("API Response:", response);
        setDisplayCardCourse({
          label: response.data.moduleName,
          moduleCode: response.data.moduleCode,
          session: data.session,
          duration: response.data.duree_h,
          color: data.color,
          typeCourse: response.data.typeCourse,
          currentNumber: response.data.currentNumber,
          totalNumber: response.data.totalNumber

        });
      })
      .catch((error) => {
        console.error("API Error:", error);
      });
  };

  return (
    <div
      className={`px-10 py-2.5 shadow-md rounded-md border-2 border-stone-400 ${data.color}`}
      onClick={handleClick}
    >
      <div className={"text-lg font-bold"}>{data.label}</div>

      <Handle type="target" position={Position.Left} className={"opacity-0"} />
      <Handle type="source" position={Position.Right} className={"opacity-0"} />
    </div>
  );
}

export default memo(CustomNode);
