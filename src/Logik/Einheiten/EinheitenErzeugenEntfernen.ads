pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

with Karten;

package EinheitenErzeugenEntfernen is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);

private

   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;

   procedure EinheitEntfernenLadung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure Entfernen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end EinheitenErzeugenEntfernen;
