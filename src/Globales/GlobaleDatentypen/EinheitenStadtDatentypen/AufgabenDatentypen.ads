pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package AufgabenDatentypen is

   type Einheiten_Aufgaben_Enum is (Leer_Aufgabe_Enum,
                                    
                                    -- Einheitenbefehle Verbesserungen
                                    Straße_Bauen_Enum, Mine_Bauen_Enum, Farm_Bauen_Enum, Festung_Bauen_Enum, Wald_Aufforsten_Enum, Roden_Trockenlegen_Enum,
                                
                                    -- Einheitenbefehle allgemein
                                    Heilen_Enum, Verschanzen_Enum);

end AufgabenDatentypen;
