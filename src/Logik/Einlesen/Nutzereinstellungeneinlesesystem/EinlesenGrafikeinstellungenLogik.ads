with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with Sf.Window.Window;
private with Sf.System.Vector2;
private with Sf.Graphics.Text;

private with GrafikRecords;

package EinlesenGrafikeinstellungenLogik is
   pragma Elaborate_Body;

   procedure Grafikeinstellungen;
   
private
   
   Nullwert : Boolean;
   
   DateiGrafikeinstellungen : File_Type;
   
   Fenstermodus : Sf.Window.Window.sfWindowStyle;
   
   Auflösung : Sf.System.Vector2.sfVector2u;
   
   Farbtiefe : Sf.sfUint32;
   
   Bildrate : Sf.sfUint32;
   
   VSync : Sf.sfBool;
   
   Überschriftgröße : Sf.sfUint32;
   
   Standardschriftgröße : Sf.sfUint32;
   
   KleineSchriftgröße : Sf.sfUint32;
   
   Schriftgrößen : GrafikRecords.SchriftgrößenArray;
   
   Schriftfarben : GrafikRecords.SchriftfarbenArray;
   
   Schriftstil : Sf.Graphics.Text.sfTextStyle;
   
   Schriftrahmen : Float;
   
   SpeziesFarben : GrafikRecords.SpeziesFarbenArray;
   
   EbenenUnterhalbSichtbar : Boolean;
   
   BildrateAnzeigen : Boolean;
   
   
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenGrafikeinstellungenLogik;
