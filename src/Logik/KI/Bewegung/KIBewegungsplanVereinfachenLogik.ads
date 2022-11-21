with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with EinheitenDatentypen;
private with KartenRecords;

with LeseGrenzen;

package KIBewegungsplanVereinfachenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Planvereinfachung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   procedure BewegungsplanVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   NächsterSchritt : constant EinheitenDatentypen.BewegungsplanVorhanden := 1;
   ÜbernächsterSchritt : constant EinheitenDatentypen.BewegungsplanVorhanden := 2;
   Planschritt : EinheitenDatentypen.BewegungsplanVorhanden;
      
   KartenwertVereinfachung : KartenRecords.AchsenKartenfeldNaturalRecord;
   AktuellerPlankoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure PlanvereinfachungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   
   
   function Verschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIBewegungsplanVereinfachenLogik;
