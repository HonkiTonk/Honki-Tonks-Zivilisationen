with KartenRecords;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenRecordKonstanten;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;
with KartenextraDatentypen;

package WeltkarteRecords is
   pragma Elaborate_Body;

   type WeltkarteRecord is record

      Basisgrund : KartengrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Effekte : KartenRecords.FeldeffektArray;
      
      Fluss : KartenextraDatentypen.Fluss_Enum;
      Ressource : KartenextraDatentypen.Ressourcen_Enum;
      
      Weg : KartenverbesserungDatentypen.Weg_Enum;
      Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
      
      Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      Stadtbelegung : StadtRecords.SpeziesStadtnummerRecord;

   end record;
   
   -- Das hier mal nach KartenRecordKonstanten schieben, wenn das denn geht. äöü
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Basisgrund    => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                                Zusatzgrund   => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                                Sichtbar      => KartenRecordKonstanten.LeerSichtbarkeit,
                                                Effekte       => KartenRecordKonstanten.LeerEffekte,
                                                Fluss         => KartenextraDatentypen.Leer_Fluss_Enum,
                                                Ressource     => KartenextraDatentypen.Leer_Ressource_Enum,
                                                Weg           => KartenverbesserungDatentypen.Leer_Weg_Enum,
                                                Verbesserung  => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit       => EinheitenKonstanten.LeerEinheit,
                                                Stadtbelegung => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
