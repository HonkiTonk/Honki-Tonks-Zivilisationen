pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

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

   TextAccess : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

end KarteInformationenSFML;
