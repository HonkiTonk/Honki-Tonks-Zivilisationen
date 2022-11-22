with RassenDatentypen;
with KartenDatentypen; 
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;
with BefehleDatentypen;

private with EinheitenDatentypen;
private with KartenverbesserungDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseRassenbelegung;

package AufgabenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function AufgabeTesten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Aufgabe
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   VerbesserungErforscht : Boolean;
   
   
      
   function AufgabeFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Anfangstest
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitartExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end AufgabenLogik;
