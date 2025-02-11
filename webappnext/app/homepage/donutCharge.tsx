import { Chart as ChartJS, ArcElement, Tooltip, Legend, Chart } from "chart.js";
import { Doughnut } from "react-chartjs-2";
import { useEffect } from "react";



// Plugin personnalisé pour afficher du texte au centre du donut
const centerTextPlugin = {
    id: "centerText",
    beforeDraw: (chart: Chart) => {
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

        // Texte affiché au centre du donut
        ctx.fillText(`${chart.config.options.plugins.centerText.text} H`, centerX, centerY);
        ctx.restore();
    },
};

ChartJS.register(ArcElement, Tooltip, Legend);
ChartJS.register(centerTextPlugin); // On enregistre le plugin

export default function DonutCharge({label, chargeTotal, chargePartielle}: {label: string, chargeTotal: number, chargePartielle: number }) {

    useEffect(() => {
        ChartJS.register(centerTextPlugin); // Enregistrement du plugin au montage du composant
    }, []);

    return (
        <div className="h-36 w-36">
            <Doughnut
                className="h-full w-full"
                data={{
                    labels: [label, ""],
                    datasets: [
                        {
                            data: [chargePartielle, chargeTotal - chargePartielle],
                            backgroundColor: ["#FF4D58", "rgba(159,159,159,0.1)"], // CM en rouge, le reste invisible
                            borderColor: ["rgba(0, 0, 0, 0)", "rgba(0, 0, 0, 0)"], // Bordure visible seulement pour CM
                            hoverOffset: [4, 0],
                        },
                    ],
                }}
                options={{
                    cutout: "75%",
                    plugins: {
                        legend: { display: false }, // Cacher la légende
                        tooltip: {
                            enabled: true,
                            filter: (tooltipItem) => tooltipItem.dataIndex === 0, // Tooltip uniquement pour CM
                            callbacks: {
                                label: () => `${label}: ${chargePartielle}h`,
                            },
                        },
                        centerText: {
                            text: chargePartielle, // Texte à afficher
                        },
                    },
                }}
            />
        </div>
    );
}

