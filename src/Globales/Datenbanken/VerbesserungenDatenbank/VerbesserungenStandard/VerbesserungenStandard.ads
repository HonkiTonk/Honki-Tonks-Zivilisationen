with KartenverbesserungDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;

package VerbesserungenStandard is
   pragma Pure;
   
   type StadtlisteArray is array (KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Stadtliste : constant StadtlisteArray := (
                                             KartenverbesserungDatentypen.Hauptstadt_Enum =>
                                               (
                                                Bewertung  => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                Wirtschaft => (others => (others => 1)),
                                                Kampf      => (others => (others => 1))
                                               ),
                                                  
                                             KartenverbesserungDatentypen.Stadt_Enum =>
                                               (
                                                Bewertung  => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                Wirtschaft => (others => (others => 1)),
                                                Kampf      => (others => (others => 1))
                                               )
                                            );
   
   
   
   type GebildelisteArray is array (KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Gebildeliste : constant GebildelisteArray := (
                                                 KartenverbesserungDatentypen.Farm_Enum =>
                                                   (
                                                    Bewertung  => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                    Wirtschaft => (others => (others => 1)),
                                                    Kampf      => (others => (others => 1))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Mine_Enum =>
                                                   (
                                                    Bewertung  => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                    Wirtschaft => (others => (others => 1)),
                                                    Kampf      => (others => (others => 1))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Festung_Enum =>
                                                   (
                                                    Bewertung  => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                    Wirtschaft => (others => (others => 1)),
                                                    Kampf      => (others => (others => 1))
                                                   )
                                                );

end VerbesserungenStandard;
