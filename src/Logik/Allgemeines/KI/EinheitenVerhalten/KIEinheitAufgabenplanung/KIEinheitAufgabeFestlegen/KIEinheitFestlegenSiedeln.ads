pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with EinheitenRecords;
with KartenRecords;

with Karten;

package KIEinheitFestlegenSiedeln is

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

private

   FeldGutUndFrei : Boolean;

   YAchseKoordinatePrüfen : KartenDatentypen.KartenfeldNatural;
   XAchseKoordinatePrüfen : KartenDatentypen.KartenfeldNatural;
   YAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldNatural;
   XAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldNatural;

   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;

   NeueStadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   MöglichesFeld : KartenRecords.AchsenKartenfeldNaturalRecord;
   MöglichesStadtfeld : KartenRecords.AchsenKartenfeldNaturalRecord;



   function StadtfeldSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  StadtfeldSuchen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  StadtfeldSuchen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

   function NeuesStadtfeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      UmgebungExtern : in KartenRecords.YXAchsenKartenfeldNaturalRecord;
      GeprüftExtern : in KartenRecords.YXAchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 UmgebungExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 UmgebungExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 GeprüftExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 GeprüftExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
              ),

       Post => (
                  NeuesStadtfeld'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  NeuesStadtfeld'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenSiedeln;
