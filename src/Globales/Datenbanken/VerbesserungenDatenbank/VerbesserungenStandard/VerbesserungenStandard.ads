with KartenverbesserungDatentypen;
with KartendatenbankRecord;
with ProduktionKonstanten;

package VerbesserungenStandard is
   pragma Pure;
   
   type StadtlisteArray is array (KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range) of KartendatenbankRecord.VerbesserungenlisteRecord;
   Stadtliste : constant StadtlisteArray := (
                                             KartenverbesserungDatentypen.Hauptstadt_Enum =>
                                               (
                                                Wirtschaft => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                Kampf      => (others => (others => ProduktionKonstanten.LeerBonus))
                                               ),
                                                  
                                             KartenverbesserungDatentypen.Stadt_Enum =>
                                               (
                                                Wirtschaft => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                Kampf      => (others => (others => ProduktionKonstanten.LeerBonus))
                                               )
                                            );
   
   
   
   type GebildelisteArray is array (KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum'Range) of KartendatenbankRecord.VerbesserungenlisteRecord;
   Gebildeliste : constant GebildelisteArray := (
                                                 KartenverbesserungDatentypen.Farm_Enum =>
                                                   (
                                                    Wirtschaft => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                    Kampf      => (others => (others => ProduktionKonstanten.LeerBonus))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Mine_Enum =>
                                                   (
                                                    Wirtschaft => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                    Kampf      => (others => (others => ProduktionKonstanten.LeerBonus))
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Festung_Enum =>
                                                   (
                                                    Wirtschaft => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                    Kampf      => (others => (others => ProduktionKonstanten.LeerBonus))
                                                   )
                                                );

end VerbesserungenStandard;
