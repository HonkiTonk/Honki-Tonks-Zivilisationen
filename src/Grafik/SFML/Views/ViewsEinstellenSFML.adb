pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.View;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body ViewsEinstellenSFML is
   
   procedure ViewEinstellen
     (ViewExtern : in Sf.Graphics.sfView_Ptr;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.View.setSize (view => ViewExtern,
                                size => GrößeExtern);
      Sf.Graphics.View.setCenter (view   => ViewExtern,
                                  center => (GrößeExtern.x / 2.00, GrößeExtern.y / 2.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewExtern);
      
   end ViewEinstellen;
   
   
   
   function Anzeigeverhätlnis
     return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      return (0.00, 0.00, 0.00, 0.00);
      
   end Anzeigeverhätlnis;

end ViewsEinstellenSFML;
