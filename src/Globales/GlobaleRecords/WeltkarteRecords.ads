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

      -- Den Grundrecord hier eventuell aufteilen? äöü
      Grund : KartenRecords.KartengrundRecord;
      Sichtbar : KartenRecords.SichtbarkeitArray;
      
      Effekte : KartenRecords.FeldeffektArray;
      
      Fluss : KartenextraDatentypen.Fluss_Enum;
      Ressource : KartenextraDatentypen.Ressourcen_Enum;
      
      Weg : KartenverbesserungDatentypen.Weg_Enum;
      Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
      
      Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      Stadtbelegung : StadtRecords.SpeziesStadtnummerRecord;

   end record;
   
   type ImmerVorhanden is record
      
      Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      
      -- Theoretisch muss die Sichtbarkeit nur für belegte Spezien gespeichert werden.
      -- Allerdings ist es hier vermutlich am Sinnvollsten, wenn ich immer das ganze Array speichere da es nur Booleans sind und ich ansonsten noch einen Hinweis mitspeichern müsste, welche Spezies nun gemeint ist.
      Sichtbarkeit : KartenRecords.SichtbarkeitArray;
      
   end record;
   
   -- Das hier mal nach KartenRecordKonstanten schieben, wenn das denn geht. äöü
   LeerWeltkarte : constant WeltkarteRecord := (
                                                Grund         => (KartengrundDatentypen.Leer_Basisgrund_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum),
                                                Sichtbar      => (others => KartenKonstanten.LeerSichtbar),
                                                Effekte       => (others => False),
                                                Fluss         => KartenextraDatentypen.Leer_Fluss_Enum,
                                                Ressource     => KartenextraDatentypen.Leer_Ressource_Enum,
                                                Weg           => KartenverbesserungDatentypen.Leer_Weg_Enum,
                                                Verbesserung  => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                                Einheit       => EinheitenKonstanten.LeerEinheit,
                                                Stadtbelegung => KartenRecordKonstanten.LeerDurchStadtBelegterGrund
                                               );

end WeltkarteRecords;
