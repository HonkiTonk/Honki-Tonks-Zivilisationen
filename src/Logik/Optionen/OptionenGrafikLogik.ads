private with Sf.System.Vector2;

with RueckgabeDatentypen;

private with SystemRecords;

package OptionenGrafikLogik is
   pragma Elaborate_Body;

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   EingabeAuflösung : SystemRecords.ZahlenEingabeRecord;
   EingabeBildrate : SystemRecords.ZahlenEingabeRecord;

   NeueAuflösung : Sf.System.Vector2.sfVector2u;

   procedure AuflösungÄndern;
   procedure BildrateÄndern;
   procedure VollbildFenster;

end OptionenGrafikLogik;
