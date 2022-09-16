pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

package BefehleDatentypen is

   type Stadtbefehle_Enum is (
                              Leer_Enum,
                              
                              Bauen_Enum, Verkaufen_Enum, Umbenennen_Enum, Auflösen_Enum, Verlassen_Enum
                             );
   
   subtype Stadtbefehle_Vorhanden_Enum is Stadtbefehle_Enum range Bauen_Enum .. Stadtbefehle_Enum'Last;
      
   
   
   subtype Weltkartenbefehle_Enum is TastenbelegungDatentypen.Tastenbelegung_Enum range TastenbelegungDatentypen.Tastenbelegung_Enum'First .. TastenbelegungDatentypen.Runde_Beenden_Enum;
   
   -- Später wieder Bewegungsknöpfe einbauen, aktuell nicht integriert wegen testen ob es überhaupt funktioniert. äöü
   subtype Einheiten_Bewegung_Enum is Weltkartenbefehle_Enum range TastenbelegungDatentypen.Oben_Enum .. TastenbelegungDatentypen.Ebene_Runter_Enum;
   subtype Einheiten_Aufgaben_Enum is Weltkartenbefehle_Enum range TastenbelegungDatentypen.Bauen_Enum .. TastenbelegungDatentypen.Heimatstadt_Ändern_Enum;
   subtype Siedler_Aufgaben_Enum is Einheiten_Aufgaben_Enum range TastenbelegungDatentypen.Bauen_Enum .. TastenbelegungDatentypen.Roden_Trockenlegen_Enum;
   subtype Kampf_Aufgaben_Enum is Einheiten_Aufgaben_Enum range TastenbelegungDatentypen.Plündern_Enum .. TastenbelegungDatentypen.Plündern_Enum;
   
   subtype Kartenbefehle_Enum is Weltkartenbefehle_Enum range TastenbelegungDatentypen.Forschung_Enum .. TastenbelegungDatentypen.Runde_Beenden_Enum;
   
   
   
   type Befehlsknöpfe_Enum is (
                                Einheitenknöpfe_Enum, Kartenknöpfe_Enum -- , Stadtknöpfe_Enum
                               );

end BefehleDatentypen;
