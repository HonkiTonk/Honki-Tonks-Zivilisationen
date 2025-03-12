private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

private with SystemRecordsHTSEB;

with RueckgabeDatentypen;

package OptionenGrafikLogik is
   pragma Elaborate_Body;

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use Ada.Strings.Wide_Wide_Unbounded;

   EinstellungenSchreiben : Boolean;
   EinstellungenGeändert : Boolean;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   GewählteTexturen : Unbounded_Wide_Wide_String;

   EingabeAuflösung : SystemRecordsHTSEB.ZahlenEingabeRecord;
   EingabeBildrate : SystemRecordsHTSEB.ZahlenEingabeRecord;

   NeueAuflösung : Sf.System.Vector2.sfVector2u;

   procedure VollbildFenster;



   function AuflösungÄndern
     return Boolean;

   function BildrateÄndern
     return Boolean;

   function TexturenWechseln
     return Boolean;

end OptionenGrafikLogik;
