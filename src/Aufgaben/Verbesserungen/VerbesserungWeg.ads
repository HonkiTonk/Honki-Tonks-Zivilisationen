pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, KartenRecords, SonstigeDatentypen, KartenDatentypen;
use KartenDatentypen, SonstigeDatentypen;

with Karten;

package VerbesserungWeg is

   procedure WegBerechnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   

   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
private
   
   Wegewert : KartenDatentypen.BelegterGrund;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure WegPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure BerechnungUnten;
   procedure BerechnungOben;
   procedure BerechnungRechts;
   procedure BerechnungLinks;

end VerbesserungWeg;
