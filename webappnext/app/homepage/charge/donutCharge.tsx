// import { Chart as ChartJS, ArcElement, Tooltip, Legend, Chart } from "chart.js";
// import { Doughnut } from "react-chartjs-2";
// import { useEffect } from "react";
// import {TArray} from "ts-interface-checker";
//
//
//
// // Plugin personnalisé pour afficher du texte au centre du donut
// const centerTextPlugin = {
//     id: "centerText",
//     beforeDraw: (chart: Chart) => {
//         const { width } = chart;
//         const { top, bottom } = chart.chartArea;
//         const ctx = chart.ctx;
//
//         ctx.save();
//         ctx.font = "bold 18px Arial";
//         ctx.fillStyle = "#000";
//         ctx.textAlign = "center";
//         ctx.textBaseline = "middle";
//
//         const centerX = width / 2;
//         const centerY = (top + bottom) / 2;
//
//         // Texte affiché au centre du donut
//         ctx.fillText(`${chart.config.options?.plugins?.centerText?.text} H`, centerX, centerY);
//         ctx.restore();
//     },
// };
//
// ChartJS.register(ArcElement, Tooltip, Legend);
// ChartJS.register(centerTextPlugin); // On enregistre le plugin
//
//
//
// export default function DonutCharge({label, dataDonut}:{label: string, dataDonut: number[]}) {
//     const color = {
//         cmColor: '#ff6666',
//         tdColor: '#80ff00',
//         tpColor: '#ffff00',
//         defaultColor: 'rgba(159,159,159,0.1)'
//     }
//
//     let  bckgdColor : string[] = []
//     let charge : number = dataDonut[0]
//
//     if (label == 'CM'){
//         bckgdColor.push(color.cmColor)
//
//     }else if(label == 'TD'){
//         bckgdColor.push(color.tdColor)
//     }else if(label == 'TP'){
//         bckgdColor.push(color.tpColor)
//     }else if(label == 'TOTAL'){
//         bckgdColor.push(color.cmColor)
//         bckgdColor.push(color.tdColor)
//         bckgdColor.push(color.tpColor)
//
//         charge = dataDonut[0] + dataDonut[1] + dataDonut[2]
//     }
//     bckgdColor.push(color.defaultColor)
//
//     useEffect(() => {
//         ChartJS.register(centerTextPlugin); // Enregistrement du plugin au montage du composant
//     }, []);
//
//     return (
//         <>
//             { label == 'TOTAL' ?
//                 <div className="h-36 w-36">
//                     <Doughnut
//                         className="h-full w-full"
//                         data={{
//                             labels: [label],
//                             datasets: [
//                                 {
//                                     data: dataDonut,
//                                     backgroundColor: bckgdColor, // CM en rouge, le reste invisible
//                                     hoverOffset: 4,
//                                 },
//                             ],
//                         }}
//                         options={{
//                             cutout: "75%",
//                             plugins: {
//                                 legend: { display: false }, // Cacher la légende
//                                 centerText: {
//                                     text: charge, // Texte à afficher
//                                 },
//                             },
//                         }}
//                     />
//                 </div>
//
//                 :
//
//                 <div className="h-36 w-36">
//                     <Doughnut
//                         className="h-full w-full"
//                         data={{
//                             labels: [label],
//                             datasets: [
//                                 {
//                                     data: dataDonut,
//                                     backgroundColor: bckgdColor, // CM en rouge, le reste invisible
//                                     hoverOffset: [4, 0],
//                                 },
//                             ],
//                         }}
//                         options={{
//                             cutout: "75%",
//                             plugins: {
//                                 legend: { display: false }, // Cacher la légende
//                                 tooltip: {
//                                     enabled: true,
//                                     filter: (tooltipItem) => tooltipItem.dataIndex === 0, // Tooltip uniquement pour CM
//                                     callbacks: {
//                                         label: () => `${label}: ${charge}h`,
//                                     },
//                                 },
//                                 centerText: {
//                                     text: charge // Texte à afficher
//                                 },
//                             },
//                         }}
//                     />
//                 </div>
//
//             }
//         </>
//     );
// }


import { Chart as ChartJS, ArcElement, Tooltip, Legend, Chart, Plugin } from "chart.js";
import { Doughnut } from "react-chartjs-2";
import { useEffect } from "react";

const centerTextPlugin: Plugin<"doughnut"> = {
    id: "centerText",
    beforeDraw: (chart: Chart<"doughnut">) => {
        const { width } = chart;
        const { top, bottom } = chart.chartArea;
        const ctx = chart.ctx;

        ctx.save();
        ctx.font = "bold 18px Arial";
        ctx.fillStyle = "#000";
        ctx.textAlign = "center";
        ctx.textBaseline = "middle";

        const centerX = width / 2;
        const centerY = (top + bottom) / 2;

        // Récupération sécurisée du texte
        const text = chart.config.options?.plugins?.centerText?.text ?? "";
        ctx.fillText(`${text} H`, centerX, centerY);
        ctx.restore();
    },
};

ChartJS.register(ArcElement, Tooltip, Legend);
ChartJS.register(centerTextPlugin);

interface DonutChargeProps {
    label: string;
    dataDonut: number[];
}

export default function DonutCharge({ label, dataDonut }: DonutChargeProps) {
    const color = {
        cmColor: "#ff6666",
        tdColor: "#80ff00",
        tpColor: "#ffff00",
        defaultColor: "rgba(159,159,159,0.1)",
    };

    let bckgdColor: string[] = [];
    let charge: number = dataDonut[0];

    // On choisit la couleur ou on cumule les charges selon le label
    if (label === "CM") {
        bckgdColor.push(color.cmColor);
    } else if (label === "TD") {
        bckgdColor.push(color.tdColor);
    } else if (label === "TP") {
        bckgdColor.push(color.tpColor);
    } else if (label === "TOTAL") {
        bckgdColor.push(color.cmColor, color.tdColor, color.tpColor);
        charge = dataDonut.reduce((acc, val) => acc + val, 0);
    }
    bckgdColor.push(color.defaultColor);

    // Réenregistrement du plugin (optionnel si déjà fait en amont)
    useEffect(() => {
        ChartJS.register(centerTextPlugin);
    }, []);

    const dataBase = {
        datasets: [{
            data: dataDonut,
            backgroundColor: bckgdColor, // CM en rouge, le reste invisible
            borderColor: 'rgba(0,0,0,0.0)',
            hoverBackgroundColor: bckgdColor,
            hoverOffset: 0,
        }],

        options:{
            cutout: "75%",
            plugins: {
                legend: { display: false }, // Cacher la légende
                tooltip: {
                    enabled: false
                },
                centerText: {
                    text: charge, // Texte à afficher
                }
            }
        }
    }

    return (
        <>
            { label == 'TOTAL' ?
                 <div className="h-36 w-36">
                     <Doughnut
                         className="h-full w-full"
                         data={{
                             labels: ["CM","TD","TP"],
                             datasets:dataBase.datasets
                         }}
                         options={dataBase.options}
                     />
                 </div>

                 :

                 <div className="h-36 w-36">
                     <Doughnut
                         className="h-full w-full"
                         data={{
                             labels: [label],
                             datasets:dataBase.datasets
                         }}
                         options={dataBase.options}
                     />
                 </div>
            }
        </>
    );
}