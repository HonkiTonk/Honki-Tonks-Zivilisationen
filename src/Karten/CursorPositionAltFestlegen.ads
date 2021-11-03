pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

with Sichtweiten;

package CursorPositionAltFestlegen is

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch
          and
            BewegungsfeldFestlegenExtern <= Sichtweiten.Bewegungsfeld'Last);
   
private

   procedure AlteEAchseFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

   procedure AlteXAchseFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive);

end CursorPositionAltFestlegen;
