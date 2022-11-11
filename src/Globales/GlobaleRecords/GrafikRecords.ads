with Sf;
with Sf.Window.Window;
with Sf.Graphics.Color;
with Sf.Window.Cursor;

package GrafikRecords is
   
   type FensterRecord is record
      
      FensterVollbild : Sf.Window.Window.sfWindowStyle;
      
      -- Fensterauflösung direkt in einem Float speichern. Sollte überall gehen auser bei der Festlegen der aktuellen Fenstergröße und beim Eingeben einer neuen Auflösung. äöü
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
   
   
   
   type GrafikeinstellungenRecord is record
      
      EbeneUnterhalbSichtbar : Boolean;
      
   end record;

end GrafikRecords;
