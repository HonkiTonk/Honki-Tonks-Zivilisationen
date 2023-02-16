with Sf;
with Sf.Window.Window;

package GrafikRecords is
   pragma Elaborate_Body;
   
   type FensterRecord is record
      
      FensterVollbild : Sf.Window.Window.sfWindowStyle;
      
      -- Fensterauflösung direkt in einem Float speichern? Sollte überall gehen auser bei der Festlegen der aktuellen Fenstergröße und beim Eingeben einer neuen Auflösung. äöü
      FensterBreite : Sf.sfUint32;
      FensterHöhe : Sf.sfUint32;
      Farbtiefe : Sf.sfUint32;
      Bildrate : Sf.sfUint32;
      
   end record;
   
   
   
   type GrafikeinstellungenRecord is record
      
      EbeneUnterhalbSichtbar : Boolean;
      
   end record;

end GrafikRecords;
