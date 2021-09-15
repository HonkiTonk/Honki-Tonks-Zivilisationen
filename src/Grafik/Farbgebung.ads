pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Farbgebung is

   procedure Farben
     (EinheitIDExtern : in GlobaleDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in GlobaleDatentypen.Rassen_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Enum)
     with
       Pre =>
         ((if EigeneRasseExtern /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch)
          and
            (if RasseExtern /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer));
   
private
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in GlobaleDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in GlobaleDatentypen.Rassen_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Enum);
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      RessourceExtern : in GlobaleDatentypen.Karten_Grund_Enum);
   
   procedure FarbenFeld
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum);

end Farbgebung;
