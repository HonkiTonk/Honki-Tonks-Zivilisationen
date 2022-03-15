pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Sf.Graphics.RenderWindow;

-- with GrafikEinstellungen;
-- with EingeleseneTexturen;

package body HintergrundSFML is

   procedure HintergrundMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin
      
      null;
      
      -- HintergrundbildLaden (WelchesMenüExtern => WelchesMenüExtern);
      
      -- Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccess,
      --                               texture => EingeleseneTexturen.Hintergrund (WelchesBild));
      -- Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungen.FensterAccess,
      --                                     object       => SpriteAccess);
      
   end HintergrundMenü;
   
   
   
   procedure HintergrundbildLaden
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü =>
            WelchesBild := 1;
            
         when others =>
            WelchesBild := 2;
      end case;
      
   end HintergrundbildLaden;

end HintergrundSFML;
