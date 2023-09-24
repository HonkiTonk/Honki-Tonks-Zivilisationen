with Sf;
with Sf.Window.Window;
with Sf.System.Vector2;
with Sf.System.Vector3;
with Sf.Graphics.Color;
with Sf.Graphics.Text;

with TextDatentypen;
with SpeziesDatentypen;

package GrafikRecords is
   pragma Elaborate_Body;
   
   type SchriftgrößenArray is array (TextDatentypen.Schriftgröße_Enum'Range) of Sf.sfUint32;
   
   type SchriftfarbenArray is array (TextDatentypen.Schriftfarbe_Enum'Range) of Sf.Graphics.Color.sfColor;
      
   type SpeziesFarbenArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Sf.Graphics.Color.sfColor;
   
   
   
   -- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
   type GrafikeinstellungenRecord is record
      
      Fenstermodus : Sf.Window.Window.sfWindowStyle;
      
      Auflösung : Sf.System.Vector2.sfVector2u;
      Farbtiefe : Sf.sfUint32;
      Bildrate : Sf.sfUint32;
      VSync : Sf.sfBool;
   
      Schriftgrößen : SchriftgrößenArray;
      Schriftfarben : SchriftfarbenArray;
      Schriftstil : Sf.Graphics.Text.sfTextStyle;
      
      Speziesfarben : SpeziesFarbenArray;
      
      EbeneUnterhalbSichtbar : Boolean;
      BildrateAnzeigen : Boolean;
      
   end record;
   
   
   
   type TextpositionLeerzeilenRecord is record
      
      -- Textpositionsinformationen.x = XPosition, Textpositionsinformationen.y = YPosition, Textpositionsinformationen.z = Textbreite
      Textpositionsinformationen : Sf.System.Vector3.sfVector3f;
      
      Leerzeilen : Natural;
      
   end record;

end GrafikRecords;
