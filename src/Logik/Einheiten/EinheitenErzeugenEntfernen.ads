pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with KartenRecords;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SpielVariablen;

with Karten;

package EinheitenErzeugenEntfernen is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;

   procedure EinheitEntfernenLadung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

   procedure Entfernen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

end EinheitenErzeugenEntfernen;
