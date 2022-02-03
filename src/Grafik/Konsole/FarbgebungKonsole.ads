pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenDatentypen;
with EinheitenKonstanten;
with SystemKonstanten;

package FarbgebungKonsole is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum)
     with
       Pre =>
         ((if EigeneRasseExtern /= EinheitenKonstanten.LeerRasse then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemKonstanten.SpielerMenschKonstante)
          and
            (if RasseExtern /= EinheitenKonstanten.LeerRasse then GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante));
   
private
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum);
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum);
   
   procedure FarbenFeld
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum);

end FarbgebungKonsole;
