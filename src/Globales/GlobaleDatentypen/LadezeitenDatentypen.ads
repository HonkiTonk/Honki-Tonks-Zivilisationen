pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package LadezeitenDatentypen is
   
   type Ladefortschritt is range 0 .. 100;

   type Spielwelt_Erstellen_Enum is (
                                     Generiere_Allgemeines_Enum, Generiere_Küstenwasser_Enum, Generiere_Landschaft_Enum, Generiere_Unterfläche_Enum, Generiere_Flüsse_Enum, Generiere_Ressourcen_Enum,
                                     Bewerte_Kartenfelder_Enum, Platziere_Rassen_Enum
                                    );
   
   type Speichern_Laden_Enum is (
                                 Test_Enum
                                );

end LadezeitenDatentypen;
