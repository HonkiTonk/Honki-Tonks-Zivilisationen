pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with KartenRecords;
with SpielVariablen;
with Weltkarte;

with KIDatentypen;

package KIBewegungAllgemeinLogik is
   pragma Elaborate_Body;
   
   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
     with
       Pre => (
                 FeldKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 FeldKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private

   BlockierendeStadt : RassenDatentypen.Rassen_Enum;
   
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
