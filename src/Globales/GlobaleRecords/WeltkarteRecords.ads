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

   type WeltkarteRecord is record

      Grund : KartenRecords.KartengrundRecord;
      Effekt : KartengrundDatentypen.Effekt_Kartenfeld_Enum;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Fluss : KartenextraDatentypen.Fluss_Enum;
      Ressource : KartenextraDatentypen.Ressourcen_Enum;
      
      Weg : KartenverbesserungDatentypen.Karten_Weg_Enum;
      Verbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      
      Einheit : EinheitenRecords.RasseEinheitnummerRecord;
      
      DurchStadtBelegterGrund : StadtRecords.RasseStadtnummerRecord;

   end record;
   
   
   
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Grund                   => (KartengrundDatentypen.Leer_Basisgrund_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum),
                                                Effekt                  => KartengrundDatentypen.Leer_Effekt_Enum,
                                                Sichtbar                => (others => KartenKonstanten.LeerSichtbar),
                                                Fluss                   => KartenextraDatentypen.Leer_Fluss_Enum,
                                                Ressource               => KartenextraDatentypen.Leer_Ressource_Enum,
                                                Weg                     => KartenverbesserungDatentypen.Leer_Weg_Enum,
                                                Verbesserung            => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit                 => EinheitenKonstanten.LeerRasseNummer,
                                                DurchStadtBelegterGrund => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
