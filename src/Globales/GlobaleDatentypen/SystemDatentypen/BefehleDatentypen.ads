pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package BefehleDatentypen is

   type Stadtbefehle_Enum is (
                              Leer_Enum,
                              
                              Bauen_Enum, Verkaufen_Enum, Umbenennen_Enum, Auflösen_Enum, Verlassen_Enum
                             );
   
   subtype Stadtbefehle_Vorhanden_Enum is Stadtbefehle_Enum range Bauen_Enum .. Stadtbefehle_Enum'Last;
   
   
   
   -- Das hier mit den Einheitenbefehlen zusammenlegen? äöü
   -- Wäre vermutlich sinnvoll, dann könnte ich auch gleich die allgemeinen Weltkartenbefehle reinpacken. äöü
   type Weltkartenbefehle_Enum is (
                                   Leer_Enum,
                                   
                                   Bewegen_Enum,
                                   
                                   A_Enum
                                  );
   
   subtype Kartenbefehle_Enum is Weltkartenbefehle_Enum range Weltkartenbefehle_Enum'Range;
   
   subtype Einheitenbefehle_Enum is Weltkartenbefehle_Enum range Weltkartenbefehle_Enum'Range;
   subtype Weltkartenbefehle_Bewegung_Enum is Einheitenbefehle_Enum range Bewegen_Enum .. Bewegen_Enum;
   subtype Weltkartenbefehle_Vorhanden_Enum is Einheitenbefehle_Enum range A_Enum .. Weltkartenbefehle_Enum'Last;

end BefehleDatentypen;
