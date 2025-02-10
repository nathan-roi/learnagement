import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Doughnut } from "react-chartjs-2";

ChartJS.register(ArcElement, Tooltip, Legend);

export default function DonutCharge({chargeTotal, chargePartielle, label}:{chargeTotal:number, chargePartielle:number, label:string}){
    return(
        <div className={"h-36 w-36"}>
            <Doughnut className={"h-full w-full"} data={{
                labels: [label, ''],
                datasets: [{
                    data: [chargePartielle, chargeTotal - chargePartielle], // CM et le reste
                    backgroundColor: ['#FF4D58', 'rgba(0, 0, 0, 0)'], // CM en rouge, le reste invisible
                    borderColor: ['#FF4D58', 'rgba(0, 0, 0, 0)'], // Bordure visible seulement pour CM
                    hoverOffset: [4, 0] // Effet de hover uniquement sur CM
                }]
            }}

                      options={{
                          cutout: '75%',
                          plugins: {
                              legend: {
                                  display: false // Cache la légende
                              },
                              tooltip: {
                                  enabled: true, // Garde les tooltips activés
                                  filter: function (tooltipItem) {
                                      return tooltipItem.dataIndex === 0; // Affiche le tooltip SEULEMENT pour CM
                                  },
                                  callbacks: {
                                      label: function (tooltipItem) {
                                          return label + `: ${chargePartielle}h`; // Texte du tooltip pour CM
                                      }
                                  }
                              }
                          }
                      }
                      }/>
        </div>
    )
}