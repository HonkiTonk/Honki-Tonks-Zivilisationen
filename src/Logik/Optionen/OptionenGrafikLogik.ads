private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RueckgabeDatentypen;

private with SystemRecords;

package OptionenGrafikLogik is
   pragma Elaborate_Body;

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use Ada.Strings.Wide_Wide_Unbounded;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   GewählteTexturen : Unbounded_Wide_Wide_String;

   EingabeAuflösung : SystemRecords.ZahlenEingabeRecord;
   EingabeBildrate : SystemRecords.ZahlenEingabeRecord;

   NeueAuflösung : Sf.System.Vector2.sfVector2u;

   procedure AuflösungÄndern;
   procedure BildrateÄndern;
   procedure VollbildFenster;
   procedure TexturenWechseln;

end OptionenGrafikLogik;
