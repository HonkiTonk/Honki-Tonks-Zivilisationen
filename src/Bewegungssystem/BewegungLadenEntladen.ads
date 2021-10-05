pragma SPARK_Mode (On);

with EinheitStadtRecords, EinheitStadtDatentypen, GlobaleVariablen, KartenRecords, SonstigeDatentypen, KartenDatentypen;
use SonstigeDatentypen, KartenDatentypen;

with Karten;

package BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
   
   TransporterNummer : EinheitStadtDatentypen.MaximaleEinheiten;
   
   EinheitAusladen : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   FreierPlatzNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function FreienPlatzErmitteln
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= SonstigeDatentypen.Leer);

end BewegungLadenEntladen;
