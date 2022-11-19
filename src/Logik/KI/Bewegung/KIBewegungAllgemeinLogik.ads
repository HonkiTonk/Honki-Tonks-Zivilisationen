with KartenDatentypen;
with RassenDatentypen;
with EinheitenRecords;
with KartenRecords;
with SpielVariablen;

with LeseWeltkarteneinstellungen;

with KIDatentypen;

package KIBewegungAllgemeinLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
     with
       Pre => (
                 FeldKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 FeldKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private

   BlockierendeStadt : RassenDatentypen.Rassen_Enum;
   
   Aufgabe : KIDatentypen.Einheit_Aufgabe_Enum;
   
   BlockierendeEinheit : EinheitenRecords.RasseEinheitnummerRecord;
   
   
   
   function FeldAngreifen
     (EigeneEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheRasseEinheitExtern : in RassenDatentypen.Rassen_Enum;
      FeindlicheRasseStadtExtern : in RassenDatentypen.Rassen_Enum)
      return KIDatentypen.Bewegung_Enum
     with
       Pre => (
                 EigeneEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EigeneEinheitExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EigeneEinheitExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIBewegungAllgemeinLogik;
