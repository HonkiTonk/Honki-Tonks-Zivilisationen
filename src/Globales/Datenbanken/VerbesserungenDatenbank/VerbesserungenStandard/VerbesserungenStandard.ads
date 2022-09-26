pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;
with EinheitenDatentypen;

with DatenbankRecords;

package VerbesserungenStandard is
   
   type StadtlisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Stadtliste : constant StadtlisteArray := (
                                             KartenverbesserungDatentypen.Hauptstadt_Enum =>
                                               (
                                                Passierbarkeit     => (others => True),
                                                Bewertung          => (others => 1),
                                                Wirtschaft         => (others => (others => 1)),
                                                Kampf              => (others => (others => 1))
                                               ),
                                                  
                                             KartenverbesserungDatentypen.Stadt_Enum =>
                                               (
                                                Passierbarkeit     => (others => True),
                                                Bewertung          => (others => 1),
                                                Wirtschaft         => (others => (others => 1)),
                                                Kampf              => (others => (others => 1))
                                               )
                                            );
   
   
   
   type GebildelisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Gebildeliste : constant GebildelisteArray := (
                                                 KartenverbesserungDatentypen.Farm_Enum =>
                                                   (
                                                    Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                           EinheitenDatentypen.Luft_Enum     => True,
                                                                           EinheitenDatentypen.Weltraum_Enum => True, 
                                                                           others                            => False),
                                                    Bewertung          => (others => 1),
                                                    Wirtschaft         => (others => (others => 1)),
                                                    Kampf              => (others => (others => 1))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Mine_Enum =>
                                                   (
                                                    Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                           EinheitenDatentypen.Luft_Enum     => True,
                                                                           EinheitenDatentypen.Weltraum_Enum => True,
                                                                           others                            => False),
                                                    Bewertung          => (others => 1),
                                                    Wirtschaft         => (others => (others => 1)),
                                                    Kampf              => (others => (others => 1))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Festung_Enum =>
                                                   (
                                                    Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                           EinheitenDatentypen.Luft_Enum     => True,
                                                                           EinheitenDatentypen.Weltraum_Enum => True,
                                                                           others                            => False),
                                                    Bewertung          => (others => 1),
                                                    Wirtschaft         => (others => (others => 1)),
                                                    Kampf              => (others => (others => 1))
                                                   )
                                                );

end VerbesserungenStandard;
