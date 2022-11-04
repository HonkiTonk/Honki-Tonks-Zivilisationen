pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Window.Cursor;

with GrafikRecords;

-- Teile davon nach GrafikVariablen auslagern? äöü
package EinstellungenGrafik is
   pragma Elaborate_Body;
   
   Grafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   FensterAccess : Sf.Graphics.sfRenderWindow_Ptr;
   
   MausAccess : Sf.Window.sfCursor_Ptr;
   
   FensterEinstellungen : GrafikRecords.FensterRecord;
      
   AktuelleFensterAuflösung : Sf.System.Vector2.sfVector2f;
   
   procedure StandardeinstellungenLaden;
   
private
   
   -- FensterVollbild:
   -- No border / title bar = 0
   -- Title bar + fixed border = 1
   -- Titlebar + resizable border + maximize button = 2
   -- Titlebar + close button = 4
   -- Fullscreen mode = 8
   -- Default window style = 7
      
   FensterStandardEinstellungen : constant GrafikRecords.FensterRecord := (
                                                                           FensterVollbild => 7,
                                                                           
                                                                           FensterBreite   => 640,
                                                                           FensterHöhe     => 480,
                                                                           Farbtiefe       => 32,
                                                                           Bildrate        => 30,
                                                                           
                                                                           MausZeiger      => Sf.Window.Cursor.sfCursorCross
                                                                          );
   
   GrafikeinstellungenStandard : constant GrafikRecords.GrafikeinstellungenRecord := (
                                                                                      EbeneUnterhalbSichtbar => True
                                                                                     );
   
end EinstellungenGrafik;
