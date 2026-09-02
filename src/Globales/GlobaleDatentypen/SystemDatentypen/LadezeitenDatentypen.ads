package LadezeitenDatentypen is
   pragma Pure;

   type Kartengenerator_Enum is (
                                 Generiere_Allgemeines_Enum, Generiere_Küstenwasser_Enum, Generiere_Landschaft_Enum, Generiere_Unterfläche_Enum, Generiere_Flüsse_Enum, Generiere_Ressourcen_Enum,
                                 Platziere_Spezies_Enum
                                );
   
   
   
   type KI_Enum is (
                    Berechne_Einheiten_Enum, Berechne_Städte_Enum, Berechne_Forschung_Enum, Berechne_Diplomatie_Enum
                   );
   
   
   
   type Rundenende_Enum is (
                            Meldungen_Setzen_Enum
                           );
   
   
   
   type Spielstand_Enum is (
                            Allgemeines_Enum, Karte_Enum, Sichtbarkeit_Enum, Spezies_Enum
                           );

end LadezeitenDatentypen;
