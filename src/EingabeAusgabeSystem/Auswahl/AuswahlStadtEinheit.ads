pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;
with KartenDatentypen;
with EinheitStadtDatentypen;
with EinheitStadtRecords;

package AuswahlStadtEinheit is
   
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   AktuelleAuswahl : Integer;
   
   type MöglicheAuswahlenArray is array (0 .. EinheitStadtRecords.TransporterArray'Last) of EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   type AuswahlRecord is record
      
      StadtEinheit : Boolean;
      MöglicheAuswahlen : MöglicheAuswahlenArray;
      
   end record;
   
   WelcheAuswahl : AuswahlRecord;

   function AuswahlStadtEinheit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert)
      return KartenDatentypen.LoopRangeMinusEinsZuEins;
   
private
   
   Auswahl : KartenDatentypen.LoopRangeMinusEinsZuEins;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;
   
   TextPositionMaus : Sf.System.Vector2.sfVector2f;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   procedure MausAuswahl;

end AuswahlStadtEinheit;
