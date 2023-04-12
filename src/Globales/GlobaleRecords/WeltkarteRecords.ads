with KartenRecords;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;
with KartenextraDatentypen;

package WeltkarteRecords is
   pragma Elaborate_Body;

   type WeltkarteRecord is record

      Grund : KartenRecords.KartengrundRecord;
      Effekte : KartenRecords.FeldeffektArray;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Fluss : KartenextraDatentypen.Fluss_Enum;
      Ressource : KartenextraDatentypen.Ressourcen_Enum;
      
      Weg : KartenverbesserungDatentypen.Weg_Enum;
      Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
      
      Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      Stadtbelegung : StadtRecords.SpeziesStadtnummerRecord;

   end record;
   
   
   
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Grund         => (KartengrundDatentypen.Leer_Basisgrund_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum),
                                                Effekte       => (others => False),
                                                Sichtbar      => (others => KartenKonstanten.LeerSichtbar),
                                                Fluss         => KartenextraDatentypen.Leer_Fluss_Enum,
                                                Ressource     => KartenextraDatentypen.Leer_Ressource_Enum,
                                                Weg           => KartenverbesserungDatentypen.Leer_Weg_Enum,
                                                Verbesserung  => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit       => EinheitenKonstanten.LeerEinheit,
                                                Stadtbelegung => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
