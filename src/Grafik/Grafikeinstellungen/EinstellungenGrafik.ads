with GrafikRecords;

package EinstellungenGrafik is
   pragma Elaborate_Body;
   
   FensterEinstellungen : GrafikRecords.FensterRecord;
   
   Grafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   procedure StandardeinstellungenLaden;
   
private
   
   FensterStandardEinstellungen : constant GrafikRecords.FensterRecord := (
                                                                           -- No border / title bar = 0
                                                                           -- Title bar + fixed border = 1
                                                                           -- Titlebar + resizable border + maximize button = 2
                                                                           -- Titlebar + close button = 4
                                                                           -- Fullscreen mode = 8
                                                                           -- Default window style = 7
                                                                           Fenstermodus => 7,
                                                                           
                                                                           Auflösung    => (640, 480),
                                                                           Farbtiefe    => 32,
                                                                           Bildrate     => 30
                                                                          );
   
   -- Der Mauszeiger wird aktuell in FensterGrafik festgelegt/verwendet. So lassen oder später hier mit einbauen um in Änderbar zu machen? äöü
   GrafikeinstellungenStandard : constant GrafikRecords.GrafikeinstellungenRecord := (
                                                                                      EbeneUnterhalbSichtbar => True
                                                                                     );
   
end EinstellungenGrafik;
