with GrafikRecords;

-- Die Records hier in Arrays mit Enum'Range umwandeln wäre vermutlich unsinnig, da die zu setzenden Werte verschiedene Datentypen haben.
package EinstellungenGrafik is
   pragma Elaborate_Body;
   
   -- Alle Zugriffe hier in Prozeduren/Funktionen verschieben? äöü
   Grafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   FensterEinstellungen : GrafikRecords.FensterRecord;
   
   procedure StandardeinstellungenLaden;
   
   procedure FenstereinstellungenSchreiben
     (EintragExtern : in GrafikRecords.FensterRecord);
   
   procedure GrafikeinstellungenSchreiben
     (EintragExtern : in GrafikRecords.GrafikeinstellungenRecord);
   
   
   
   function FenstereinstellungenLesen
     return GrafikRecords.FensterRecord;
   
   function GrafikeinstellungenLesen
     return GrafikRecords.GrafikeinstellungenRecord;
   
private
   
   
   
   FensterStandardEinstellungen : constant GrafikRecords.FensterRecord := (
                                                                           -- No border / title bar = 0
                                                                           -- Title bar + fixed border = 1
                                                                           -- Titlebar + resizable border + maximize button = 2
                                                                           -- Titlebar + close button = 4
                                                                           -- Fullscreen mode = 8
                                                                           -- Default window style = 7
                                                                           FensterVollbild => 7,
                                                                           
                                                                           FensterBreite   => 640,
                                                                           FensterHöhe     => 480,
                                                                           Farbtiefe       => 32,
                                                                           Bildrate        => 30
                                                                          );
   
   -- Der Mauszeiger wird aktuell in FensterGrafik festgelegt/verwendet. So lassen oder später hier mit einbauen um in Änderbar zu machen? äöü
   GrafikeinstellungenStandard : constant GrafikRecords.GrafikeinstellungenRecord := (
                                                                                      EbeneUnterhalbSichtbar => True
                                                                                     );
   
end EinstellungenGrafik;
