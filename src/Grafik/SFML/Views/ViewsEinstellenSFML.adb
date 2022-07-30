pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.View;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;
with ViewsSFML;

package body ViewsEinstellenSFML is

   -- Mal drinnen lassen, weil der ja immer diese Werte hat und niemals geändert wird? Wenn ich alles in verschiedene Views aufteile ist das dann aber sinnfrei.
   procedure StandardviewGeändert
   is begin
      
      Sf.Graphics.View.setSize (view => ViewsSFML.StandardviewAccess,
                                size => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)));
      Sf.Graphics.View.setCenter (view   => ViewsSFML.StandardviewAccess,
                                  center => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewsSFML.StandardviewAccess);
      
   end StandardviewGeändert;
   
   
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      ZentrumExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.View.setSize (view => ViewExtern,
                                size => GrößeExtern);
      Sf.Graphics.View.setCenter (view   => ViewExtern,
                                  center => ZentrumExtern);
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewExtern);
      
   end ViewEinstellen;

end ViewsEinstellenSFML;
