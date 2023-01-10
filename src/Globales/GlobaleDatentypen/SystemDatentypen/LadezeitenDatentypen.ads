package LadezeitenDatentypen is
   pragma Pure;

   type Spielwelt_Erstellen_Enum is (
                                     Generiere_Allgemeines_Enum, Generiere_Küstenwasser_Enum, Generiere_Landschaft_Enum, Generiere_Unterfläche_Enum, Generiere_Flüsse_Enum, Generiere_Ressourcen_Enum,
                                     Platziere_Spezies_Enum
                                    );
   
   type KI_Rechnet_Enum is (
                            Berechne_Einheiten_Enum, Berechne_Städte_Enum, Berechne_Forschung_Enum, Berechne_Diplomatie_Enum
                           );
   
   type Rundenende_Enum is (
                            Meldungen_Setzen_Enum
                           );
   
   type Speichern_Laden_Enum is (
                                 Speichern_Enum, Laden_Enum
                                );

end LadezeitenDatentypen;
