pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;

with MenueDatentypen;

package MenueHintergrundSFML is

   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr);

end MenueHintergrundSFML;
