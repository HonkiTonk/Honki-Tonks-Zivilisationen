pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;
with Sf.Window;
with Sf.Window.Cursor;
with Sf.Window.Window;
with Sf.Graphics.Color;

with GrafikDatentypen;

package SystemRecords is

   type NutzerEinstellungenRecord is record
      
      Sprache : Unbounded_Wide_Wide_String;
      
      AnzahlAutosave : Natural;
      RundenBisAutosave : Positive;
      
      Anzeigeart : GrafikDatentypen.Anzeige_Art_Enum;
      
   end record;
   
   
   
   type FensterRecord is record
      
      FensterVollbild : Sf.Window.Window.sfWindowStyle;
      -- Auflösung für Fenstermodus und eine für Vollbildmodus erstellen? Oder für beide nur eine benutzen?
      FensterBreite : Sf.sfUint32;
      FensterHöhe : Sf.sfUint32;
      Farbtiefe : Sf.sfUint32;
      Bildrate : Sf.sfUint32;
      MausZeiger : Sf.Window.Cursor.sfCursorType;
      
   end record;
   
   
   
   type SchriftgrößenRecord is record
      
      SchriftgrößeÜberschrift : Sf.sfUint32;
      SchriftgrößeStandard : Sf.sfUint32;
      SchriftgrößeKlein : Sf.sfUint32;
      
   end record;
   
   
   
   type SchriftfarbenRecord is record
      
      FarbeÜberschrift : Sf.Graphics.Color.sfColor;
      FarbeStandardText : Sf.Graphics.Color.sfColor;
      FarbeAusgewähltText : Sf.Graphics.Color.sfColor;
      FarbeMenschText : Sf.Graphics.Color.sfColor;
      FarbeKIText : Sf.Graphics.Color.sfColor;
      FarbeSonstigerText : Sf.Graphics.Color.sfColor;
      
   end record;
   
   
   
   type ZahlenEingabeRecord is record
      
      EingabeAbbruch : Boolean;
      EingegebeneZahl : Integer;
      
   end record;
   
   
   
   type TextEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebenerText : Unbounded_Wide_Wide_String;
      
   end record;
      
end SystemRecords;
