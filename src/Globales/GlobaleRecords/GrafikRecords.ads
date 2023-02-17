with Sf;
with Sf.Window.Window;
with Sf.System.Vector2;

package GrafikRecords is
   pragma Elaborate_Body;
   
   type FensterRecord is record
      
      Fenstermodus : Sf.Window.Window.sfWindowStyle;
      
      Auflösung : Sf.System.Vector2.sfVector2u;
      Farbtiefe : Sf.sfUint32;
      Bildrate : Sf.sfUint32;
      
   end record;
   
   
   
   type GrafikeinstellungenRecord is record
      
      EbeneUnterhalbSichtbar : Boolean;
      
   end record;

end GrafikRecords;
