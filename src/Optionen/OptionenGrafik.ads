pragma SPARK_Mode (On);

with Sf.System.Vector2;

with SystemDatentypen;

package OptionenGrafik is

   function OptionenGrafik
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;

   EingabeWert : Integer;

   NeueAuflösung : Sf.System.Vector2.sfVector2u;

   procedure AuflösungÄndern;

end OptionenGrafik;
