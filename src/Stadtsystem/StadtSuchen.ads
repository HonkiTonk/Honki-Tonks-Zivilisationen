pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, KartenRecords, EinheitStadtRecords, EinheitStadtDatentypen, SonstigeDatentypen, KartenDatentypen;
use KartenRecords, KartenDatentypen, SonstigeDatentypen;

with Karten;

package StadtSuchen is
   
   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
     with
       Pre  =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
     with
       Pre  =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   function StadtNachNamenSuchen
     return EinheitStadtRecords.RassePlatznummerRecord;

private
   
   StadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   StadtName : Unbounded_Wide_Wide_String;

end StadtSuchen;
