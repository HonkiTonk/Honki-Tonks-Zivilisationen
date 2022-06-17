pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package LadezeitenDatentypen is
   
   -- Statt Integer 0 .. 100, eine Float von 0.00 bis 1.00 oder 0.00 bis 100.00?
   type Ladefortschritt is range 0 .. 100;

   type Spielwelt_Erstellen_Enum is (
                                     Generiere_Allgemeines_Enum, Generiere_Küstenwasser_Enum, Generiere_Landschaft_Enum, Generiere_Unterfläche_Enum, Generiere_Flüsse_Enum, Generiere_Ressourcen_Enum,
                                     Bewerte_Kartenfelder_Enum, Platziere_Rassen_Enum
                                    );
   
   type KI_Rechnet_Enum is (
                            Berechne_Einheiten_Enum, Berechne_Städte_Enum, Berechne_Forschung_Enum, Berechne_Diplomatie_Enum
                           );
   
   type Rundenende_Enum is (
                            Setze_Meldungen_Enum
                           );
   
   type Speichern_Laden_Enum is (
                                 Speichern_Enum, Laden_Enum
                                );

end LadezeitenDatentypen;
