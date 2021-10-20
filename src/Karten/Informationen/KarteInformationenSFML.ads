pragma SPARK_Mode (On);

with Sf.System.Vector2;

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   FensterInformationen : Sf.System.Vector2.sfVector2f;

end KarteInformationenSFML;
