with RassenDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

with LeseWeltkarteneinstellungen;

with KIDatentypen;

package KIAufgabenVerteiltLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function AufgabenVerteilt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 ZielKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   function EinheitZiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 ZielKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
     
   GleicheAufgabe : Natural;
   
   Zielkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIAufgabenVerteiltLogik;
