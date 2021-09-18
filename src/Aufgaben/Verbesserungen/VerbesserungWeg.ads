pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package VerbesserungWeg is

   procedure WegBerechnen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   

   function VerbesserungWeg
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   Wegewert : GlobaleDatentypen.BelegterGrund;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure WegPlatzieren
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);
   
   procedure BerechnungUnten;
   procedure BerechnungOben;
   procedure BerechnungRechts;
   procedure BerechnungLinks;

end VerbesserungWeg;
