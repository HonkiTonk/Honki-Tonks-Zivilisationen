with KartenRecords;
with KartenzusatzgrundDatentypen;
with KartenverbesserungDatentypen;
with KartenRecordKonstanten;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;
with KartenfluesseDatentypen;
with KartenArrays;
with KartenressourcenDatentypen;
with KartenbasisgrundDatentypen;
with KartenwegeDatentypen;

package WeltkarteRecords is
   pragma Elaborate_Body;

   type WeltkarteRecord is record

      Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Effekte : KartenArrays.FeldeffektArray;
      
      Fluss : KartenfluesseDatentypen.Fluss_Enum;
      Ressource : KartenressourcenDatentypen.Ressourcen_Enum;
      
      Weg : KartenwegeDatentypen.Weg_Enum;
      Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
      
      Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      Stadtbelegung : StadtRecords.SpeziesStadtnummerRecord;

   end record;
   
   -- Das hier mal nach KartenRecordKonstanten schieben, wenn das denn geht. äöü
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Basisgrund    => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                                Zusatzgrund   => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                                Sichtbar      => KartenRecordKonstanten.LeerSichtbarkeit,
                                                Effekte       => KartenRecordKonstanten.LeerEffekte,
                                                Fluss         => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                                Ressource     => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                                Weg           => KartenwegeDatentypen.Leer_Weg_Enum,
                                                Verbesserung  => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit       => EinheitenKonstanten.LeerEinheit,
                                                Stadtbelegung => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
