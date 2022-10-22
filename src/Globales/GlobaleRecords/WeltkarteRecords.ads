pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;

package WeltkarteRecords is

   type WeltkarteRecord is record

      Grund : KartenRecords.KartengrundRecord;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Fluss : KartengrundDatentypen.Kartenfluss_Enum;
      Ressource : KartengrundDatentypen.Kartenressourcen_Enum;
      
      Weg : KartenverbesserungDatentypen.Karten_Weg_Enum;
      Verbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      
      Einheit : EinheitenRecords.RasseEinheitnummerRecord;
      
      DurchStadtBelegterGrund : StadtRecords.RasseStadtnummerRecord;

   end record;
   
   
   
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Grund                   => (KartengrundDatentypen.Leer_Grund_Enum, KartengrundDatentypen.Leer_Grund_Enum),
                                                Sichtbar                => (others => KartenKonstanten.LeerSichtbar),
                                                Fluss                   => KartengrundDatentypen.Leer_Fluss_Enum,
                                                Ressource               => KartengrundDatentypen.Leer_Ressource_Enum,
                                                Weg                     => KartenverbesserungDatentypen.Leer_Weg_Enum,
                                                Verbesserung            => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit                 => EinheitenKonstanten.LeerRasseNummer,
                                                DurchStadtBelegterGrund => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
