with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with StadtRecords;
private with EinheitenDatentypen;
private with KartengrundDatentypen;
private with KartenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenVerbesserungenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

private
   use type KartenDatentypen.Kartenfeld;

   VerbesserungTesten : Boolean;
   WelcheVerbesserung : Boolean;

   Stadtumgebung : KartenDatentypen.UmgebungsbereichDrei;

   Basisgrund : KartengrundDatentypen.Basisgrund_Enum;

   Ressourcen : KartengrundDatentypen.Kartenressourcen_Enum;

   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;

   ZielVerbesserungKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   VerbesserungAnlegen : KartenRecords.AchsenKartenfeldNaturalRecord;
   VerbesserungKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   StadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;



   function StädteDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  StädteDurchgehen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  StädteDurchgehen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function DirekteUmgebung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  DirekteUmgebung'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  DirekteUmgebung'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              ),

       Post => (
                  StadtumgebungErmitteln'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  StadtumgebungErmitteln'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function AllgemeineVerbesserungenPrüfungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

   function VerbesserungAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

   function VerbesserungErsetzen
     return Boolean;

   function WegAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenVerbesserungenLogik;
