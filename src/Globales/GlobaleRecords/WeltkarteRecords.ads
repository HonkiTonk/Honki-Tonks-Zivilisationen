with KartenRecords;
with KartenzusatzgrundDatentypen;
with KartenverbesserungDatentypen;
with KartenRecordKonstanten;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;
with KartenfluesseDatentypen;
with KartenArrays;
with KartenbasisgrundDatentypen;
with KartenwegeDatentypen;
with KartenrohstoffeDatentypen;

package WeltkarteRecords is
   pragma Elaborate_Body;

   type WeltkarteRecord is record

      Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Effekte : KartenArrays.FeldeffektArray;
      
      Fluss : KartenfluesseDatentypen.Fluss_Enum;
      Rohstoffe : KartenArrays.RohstoffeArray;
      
      Weg : KartenwegeDatentypen.Weg_Enum;
      Verbesserungen : KartenArrays.VerbesserungenArray;
      
      Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      Stadtbelegung : StadtRecords.SpeziesStadtnummerRecord;

   end record;
   
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Basisgrund     => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                                Zusatzgrund    => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                                Sichtbar       => KartenRecordKonstanten.LeerSichtbarkeit,
                                                Effekte        => KartenRecordKonstanten.LeerEffekte,
                                                Fluss          => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                                Rohstoffe      => (others => KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum),
                                                Weg            => KartenwegeDatentypen.Leer_Weg_Enum,
                                                Verbesserungen => (others => KartenverbesserungDatentypen.Leer_Verbesserungen_Enum),
                                                Einheit        => EinheitenKonstanten.LeerEinheit,
                                                Stadtbelegung  => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
