pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package StadtSuchen is
   
   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
     with
       Pre  =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if KoordinatenStadtOhneRasseSuchen'Result.Rasse /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (KoordinatenStadtOhneRasseSuchen'Result.Rasse) /= GlobaleDatentypen.Leer));

   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
     with
       Pre  =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer),
         Post =>
           ((if KoordinatenStadtOhneSpezielleRasseSuchen'Result.Rasse /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (KoordinatenStadtOhneSpezielleRasseSuchen'Result.Rasse) /= GlobaleDatentypen.Leer));
   
   function AnzahlStädteErmitteln
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function StadtNachNamenSuchen
     return GlobaleRecords.RassePlatznummerRecord;

private
   
   AnzahlStädte : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   StadtName : Unbounded_Wide_Wide_String;
   
   type AktuelleStadtArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);

end StadtSuchen;
