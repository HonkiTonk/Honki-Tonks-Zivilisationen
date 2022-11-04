pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Texture;
with Sf.Graphics.RenderWindow;

with KartenartDatentypen; use KartenartDatentypen;

with KartengeneratorVariablenLogik;
with EingeleseneTexturenGrafik;
with EinstellungenGrafik;

package body ZusatztextKartenformGrafik is

   -- Das mal von Text in irgendwas anderes umbenennen? Oder später zum Bild noch einen Text hinzufügen? äöü
   -- Später noch einmal überarbeiten, gilt auch für die Texturen. äöü
   procedure ZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Texturfläche := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BilderAccess (1)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BilderAccess (1)).y));
            
      case
        AktuelleAuswahlExtern
      is
         when 1 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               Texturanfang.x := 0.00;
               
            else
               Texturanfang.x := Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 0.00;
            
         when 2 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 2.00;
               
            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 0.00;

         when 3 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               Texturanfang.x := 0.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 2.00;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := Texturfläche.y / 5.00;

         when 4 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               Texturanfang.x := 0.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 2.00;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 2.00 * Texturfläche.y / 5.00;

         when 5 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               Texturanfang.x := 0.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 2.00;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 3.00 * Texturfläche.y / 5.00;

         when 6 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               Texturanfang.x := 0.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 2.00;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 4.00 * Texturfläche.y / 5.00;
            
         when others =>
            return;
      end case;
      
      Sf.Graphics.Sprite.setTexture (sprite    => SpriteAccess,
                                     texture   => EingeleseneTexturenGrafik.BilderAccess (1),
                                     resetRect => Sf.sfTrue);
      
      Sf.Graphics.Sprite.setTextureRect (sprite    => SpriteAccess,
                                         rectangle => (Integer (Texturanfang.x), Integer (Texturanfang.y), Integer (Texturfläche.x / 4.00), Integer (Texturfläche.y / 5.00)));
            
      Sf.Graphics.Sprite.setScale (sprite => SpriteAccess,
                                   scale  => (ViewflächeExtern.x / (Texturfläche.x / 4.00), ViewflächeExtern.y / (Texturfläche.y / 5.00)));
      
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => EinstellungenGrafik.FensterAccess,
                                           object       => SpriteAccess);
      
   end ZusatztextKartenform;

end ZusatztextKartenformGrafik;
