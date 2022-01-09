pragma SPARK_Mode (On);

with Sf.System.Vector2;

with SystemDatentypen;
with SystemRecords;

package OptionenGrafik is

   function OptionenGrafik
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;

   EingabeAuflösung : SystemRecords.ZahlenEingabeRecord;
   EingabeBildrate : SystemRecords.ZahlenEingabeRecord;

   NeueAuflösung : Sf.System.Vector2.sfVector2u;

   procedure AuflösungÄndern;
   procedure BildrateÄndern;
   procedure EinstellungenSpeichern;

end OptionenGrafik;
