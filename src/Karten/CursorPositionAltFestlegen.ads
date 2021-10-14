pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;

with Sichtweiten;

package CursorPositionAltFestlegen is

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch
          and
            BewegungsfeldFestlegenExtern <= Sichtweiten.Bewegungsfeld'Last);
   
private

   procedure AlteEAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

   procedure AlteXAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

end CursorPositionAltFestlegen;
