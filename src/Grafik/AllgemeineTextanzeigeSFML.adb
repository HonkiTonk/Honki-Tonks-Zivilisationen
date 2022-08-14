pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with TextaccessVariablen;

with GrafikEinstellungenSFML;

package body AllgemeineTextanzeigeSFML is

   procedure Überschrift
   is begin
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);
      
   end Überschrift;
   
   
   
   procedure Versionsnummer
   is begin
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.VersionsnummerAccess);
      
   end Versionsnummer;

end AllgemeineTextanzeigeSFML;
