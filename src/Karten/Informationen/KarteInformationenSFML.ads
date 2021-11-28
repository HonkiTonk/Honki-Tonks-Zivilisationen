pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

private

   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;

   FensterInformationen : Sf.System.Vector2.sfVector2f;
   ZeichenPosition : Sf.System.Vector2.sfVector2f;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   procedure StadtInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure CheatInformationen;

end KarteInformationenSFML;
