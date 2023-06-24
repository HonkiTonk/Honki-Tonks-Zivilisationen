type FlussZuFlussartArray is array (KartenextraDatentypen.Fluss_Vorhanden_Enum'Range) of KartenextraDatentypen.Flussarten_Enum;
FlussZuFlussart : constant FlussZuFlussartArray := (
                                                    KartenextraDatentypen.Fluss_Oberfläche_Enum'Range  => KartenextraDatentypen.Oberfläche_Fluss_Enum,
                                                    KartenextraDatentypen.Fluss_Unterfläche_Enum'Range => KartenextraDatentypen.Unterfläche_Fluss_Enum,
                                                    KartenextraDatentypen.Fluss_Kernfläche_Enum'Range  => KartenextraDatentypen.Kernfläche_Fluss_Enum
                                                   );
