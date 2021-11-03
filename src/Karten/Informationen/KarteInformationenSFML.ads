pragma SPARK_Mode (On);

with Sf.System.Vector2;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

private

   FensterInformationen : Sf.System.Vector2.sfVector2f;

end KarteInformationenSFML;
