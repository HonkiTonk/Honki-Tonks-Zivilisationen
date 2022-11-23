with KartenDatentypen;
with RassenDatentypen;
with EinheitenRecords;
with KartenRecords;

private with EinheitenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseRassenbelegung;

private with LeseGrenzen;

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
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
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
                 EigeneEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EigeneEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EigeneEinheitExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIBewegungAllgemeinLogik;
