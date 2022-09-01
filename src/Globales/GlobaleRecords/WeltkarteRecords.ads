pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;
with EinheitenRecords;
with EinheitenKonstanten;

package WeltkarteRecords is

   type WeltkarteRecord is record

      Grund : KartenRecords.KartengrundRecord;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Fluss : KartengrundDatentypen.Kartenfluss_Enum;
      Ressource : KartengrundDatentypen.Kartenressourcen_Enum;
      
      Weg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
      Verbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      
      Einheit : EinheitenRecords.RasseEinheitnummerRecord;
      
      DurchStadtBelegterGrund : KartenRecords.BelegterGrundRecord;
      Felderwertung : KartenRecords.FelderwertungArray;

   end record;
   
   
   
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Grund                   => (KartengrundDatentypen.Leer_Grund_Enum, KartengrundDatentypen.Leer_Grund_Enum),
                                                Sichtbar                => (others => KartenKonstanten.LeerSichtbar),
                                                Fluss                   => KartengrundDatentypen.Leer_Fluss_Enum,
                                                Ressource               => KartengrundDatentypen.Leer_Ressource_Enum,
                                                Weg                     => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                                Verbesserung            => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit                 => EinheitenKonstanten.LeerRasseNummer,
                                                DurchStadtBelegterGrund => KartenRecordKonstanten.LeerDurchStadtBelegterGrund,
                                                Felderwertung           => (others => KartenKonstanten.LeerFeldwertung)
                                               );

end WeltkarteRecords;
