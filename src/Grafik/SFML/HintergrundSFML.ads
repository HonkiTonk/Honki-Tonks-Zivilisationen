pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Sprite;

with SystemDatentypen;

package HintergrundSFML is

   procedure HintergrundMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum);
     
private
   
   WelchesBild : Positive;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
      
   procedure HintergrundbildLaden
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum);

end HintergrundSFML;
