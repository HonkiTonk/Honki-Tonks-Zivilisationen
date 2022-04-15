pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RueckgabeDatentypen;
with SystemRecords;

package OptionenGrafik is

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
   procedure EinstellungenSpeichern;

end OptionenGrafik;
