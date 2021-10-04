pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, KartenRecords, EinheitStadtRecords, SonstigeDatentypen, EinheitStadtDatentypen, KartenDatentypen;
use GlobaleDatentypen, KartenDatentypen, SonstigeDatentypen;

with Karten;

package BewegungPassierbarkeitPruefen is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function PassierbarkeitPrüfenID
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   function InStadtEntladbar
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (TransporterExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= SonstigeDatentypen.Leer);
      
   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

private
   
   Passierbar : Boolean;
   
   IDEinheit : EinheitStadtDatentypen.EinheitenIDMitNullWert;
   
   StadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   TransporterNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   Transportplatz : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;

   BenötigteFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   TransportplatzEntladen : EinheitStadtRecords.TransporterArray;
   
   function PassierbarTesten
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   function IstNichtPassierbar
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
     
   function IstPassierbar
     (UmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end BewegungPassierbarkeitPruefen;
