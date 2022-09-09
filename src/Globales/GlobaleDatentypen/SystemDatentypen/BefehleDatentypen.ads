pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package BefehleDatentypen is

   type Stadtbefehle_Enum is (
                              Leer_Enum,
                              
                              Bauen_Enum, Verkaufen_Enum, Umbenennen_Enum, Auflösen_Enum, Verlassen_Enum
                             );
   
   subtype Stadtbefehle_Vorhanden_Enum is Stadtbefehle_Enum range Bauen_Enum .. Stadtbefehle_Enum'Last;
   
   
   
   -- Das hier mit den Einheitenbefehlen zusammenlegen? äöü
   type Weltkartenbefehle_Enum is (
                                   Leer_Enum,
                                   
                                   Bewegen_Enum,
                                   
                                   A_Enum
                                  );
   
   subtype Weltkartenbefehle_Bewegung_Enum is Weltkartenbefehle_Enum range Bewegen_Enum .. Bewegen_Enum;
   subtype Weltkartenbefehle_Vorhanden_Enum is Weltkartenbefehle_Enum range A_Enum .. Weltkartenbefehle_Enum'Last;

end BefehleDatentypen;
