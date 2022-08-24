pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenRecords;
with KartenRecords;
with SpielVariablen;

with Karten;

package KISonstigesSuchen is

   function EigenesFeldSuchen
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 AktuelleKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   Bereich : KartenDatentypen.Sichtweite;
   BereichGeprüft : KartenDatentypen.SichtweiteNatural;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Ziel : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function ZielSuchen
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BereichExtern : in KartenDatentypen.Sichtweite)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 AktuelleKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

end KISonstigesSuchen;
