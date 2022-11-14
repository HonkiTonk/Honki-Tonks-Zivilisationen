with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with EinheitenDatentypen;
private with KartenRecords;

package KIBewegungsplanVereinfachenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Planvereinfachung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   KartenWertVereinfachung : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure PlanvereinfachungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErsterZugExtern : in EinheitenDatentypen.Bewegungsplan;
      ÜberNächsterZugExtern : in EinheitenDatentypen.Bewegungsplan)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIBewegungsplanVereinfachenLogik;
