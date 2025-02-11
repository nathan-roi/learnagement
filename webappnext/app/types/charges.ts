export interface ChargeState {
    total: number;
    CM: number;
    TD: number;
    TP: number;
}

export type ChargeType = keyof Omit<ChargeState, 'total'>;