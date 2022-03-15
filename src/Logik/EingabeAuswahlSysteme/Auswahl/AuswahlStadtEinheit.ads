pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;
with EinheitStadtDatentypen;
with EinheitStadtRecords;

package AuswahlStadtEinheit is
      
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
      return Integer;
   
private
      
   Zeilenabstand : Float;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;
   
   TextPositionMaus : Sf.System.Vector2.sfVector2f;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   procedure MausAuswahl
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end AuswahlStadtEinheit;
