pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;
with KartendatenbankRecord;

package VerbesserungenStandard is
   
   type StadtlisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Stadtliste : constant StadtlisteArray := (
                                             KartenverbesserungDatentypen.Hauptstadt_Enum =>
                                               (
                                                Bewertung          => (others => 1),
                                                Wirtschaft         => (others => (others => 1)),
                                                Kampf              => (others => (others => 1))
                                               ),
                                                  
                                             KartenverbesserungDatentypen.Stadt_Enum =>
                                               (
                                                Bewertung          => (others => 1),
                                                Wirtschaft         => (others => (others => 1)),
                                                Kampf              => (others => (others => 1))
                                               )
                                            );
   
   
   
   type GebildelisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Gebildeliste : constant GebildelisteArray := (
                                                 KartenverbesserungDatentypen.Farm_Enum =>
                                                   (
                                                    Bewertung          => (others => 1),
                                                    Wirtschaft         => (others => (others => 1)),
                                                    Kampf              => (others => (others => 1))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Mine_Enum =>
                                                   (
                                                    Bewertung          => (others => 1),
                                                    Wirtschaft         => (others => (others => 1)),
                                                    Kampf              => (others => (others => 1))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Festung_Enum =>
                                                   (
                                                    Bewertung          => (others => 1),
                                                    Wirtschaft         => (others => (others => 1)),
                                                    Kampf              => (others => (others => 1))
                                                   )
                                                );

end VerbesserungenStandard;