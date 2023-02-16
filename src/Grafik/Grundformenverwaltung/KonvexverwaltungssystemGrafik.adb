with Sf.Graphics.ConvexShape;
with Sf.Graphics.RenderWindow;

with FensterGrafik;

package body KonvexverwaltungssystemGrafik is

   procedure PositionFarbeZeichnen
     (KonvexaccessExtern : in Sf.Graphics.sfConvexShape_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.ConvexShape.setFillColor (shape => KonvexaccessExtern,
                                            color => FarbeExtern);
            
      Sf.Graphics.ConvexShape.setPosition (shape    => KonvexaccessExtern,
                                           position => PositionExtern);
            
      Sf.Graphics.RenderWindow.drawConvexShape (renderWindow => FensterGrafik.FensterLesen,
                                                object       => KonvexaccessExtern);
      
   end PositionFarbeZeichnen;
   
   
   
   procedure PfeilErstellen
     (PfeilaccessExtern : in Sf.Graphics.sfConvexShape_Ptr)
   is begin
      
      Sf.Graphics.ConvexShape.setPointCount (shape => PfeilaccessExtern,
                                             count => 7);
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 0,
                                        point => (0.00, 0.00));
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 1,
                                        point => (40.00, 0.00));
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 2,
                                        point => (40.00, -15.00));
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 3,
                                        point => (70.00, 10.00));
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 4,
                                        point => (40.00, 35.00));
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 5,
                                        point => (40.00, 20.00));
      Sf.Graphics.ConvexShape.setPoint (shape => PfeilaccessExtern,
                                        index => 6,
                                        point => (0.00, 20.00));
      
   end PfeilErstellen;

end KonvexverwaltungssystemGrafik;
