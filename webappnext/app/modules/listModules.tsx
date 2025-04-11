import axios from "axios";
import { useEffect, useState } from "react";
import { useInfosModuleStore } from "@/app/store/useInfosModuleStore";

export default function ListModule({
  homepageShown,
}: {
  homepageShown: boolean;
}) {
  const { setModule } = useInfosModuleStore();
  const [listeModules, setListeModules] = useState<Module["module"][]>([]);
  const [moduleClicked, setModuleClicked] = useState(-1);

  useEffect(() => {
    axios
      .get("http://localhost:8080/list/listResponsableModule.php")
      .then((response) => {
        setListeModules(response.data);
      });
  }, []);

  useEffect(() => {
    if (homepageShown) {
      setModuleClicked(-1);
    }
  }, [homepageShown]);

  const modulesAvecLien = listeModules.filter((m) => m.has_learning_unit);
  const modulesSansLien = listeModules.filter((m) => !m.has_learning_unit);

  function renderModule(module: Module["module"], isWithoutLink = false) {
    return (
      <div
        key={module.id_module}
        id={String(module.id_module)}
        className={`w-full h-20 mb-2.5 pl-2.5 rounded-lg cursor-pointer 
          ${
            isWithoutLink
              ? "border border-red-500 bg-red-500/60 text-gray-300 hover:bg-red-500/80"
              : `hover:bg-usmb-blue ${
                  moduleClicked === module.id_module
                    ? "bg-usmb-blue"
                    : "bg-usmb-cyan"
                }`
          }`}
        onClick={getModuleInfos}
      >
        <p className={"font-medium"}>{module.nom}</p>
        <p>{module.code_module}</p>
      </div>
    );
  }

  async function getModuleInfos(event: any) {
    const id_module = event.currentTarget.id;

    let form_data = new FormData();
    form_data.append("id_module", id_module);
    axios
      .post("http://localhost:8080/select/selectInfosModule.php", form_data)
      .then((response) => {
        let data = response.data;
        setModule(data);
        setModuleClicked(data.id_module);
      });
  }

  return (
    <div className={"h-3/4 overflow-y-auto"}>
      {modulesAvecLien.map((m) => renderModule(m))}
      <div className={"border-t border-gray-400 my-4"} />
      {modulesSansLien.map((m) => renderModule(m, true))}
    </div>
  );
}