pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;
with Sf.Window;
with Sf.Window.Cursor;
with Sf.Graphics.Color;

package SystemRecords is

   type NutzerEinstellungenRecord is record
      
      Sprache : Unbounded_Wide_Wide_String;
      AnzahlAutosave : Natural;
      RundenBisAutosave : Positive;
      
   end record;
   
   
   
   type FensterRecord is record
      
      FensterBreite : Sf.sfUint32;
      FensterHöhe : Sf.sfUint32;
      Farbtiefe : Sf.sfUint32;
      Bildrate : Sf.sfUint32;
      MausZeiger : Sf.Window.Cursor.sfCursorType;
      
      Schriftgröße : Sf.sfUint32;
      Textfarbe : Sf.Graphics.Color.sfColor;
      Textstyle : Sf.sfUint32;
      
   end record;
   
   
   
   type ZahlenEingabeRecord is record
      
      EingegebeneZahl : Integer;
      EingabeAbbruch : Boolean;
      
   end record;

end SystemRecords;
