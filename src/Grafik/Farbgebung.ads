pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenDatentypen;

package Farbgebung is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SonstigeDatentypen.Rassen_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Enum)
     with
       Pre =>
         ((if EigeneRasseExtern /= SonstigeDatentypen.Leer then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_Mensch)
          and
            (if RasseExtern /= SonstigeDatentypen.Leer then GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer));
   
private
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SonstigeDatentypen.Rassen_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Enum);
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum);
   
   procedure FarbenFeld
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum);

end Farbgebung;
