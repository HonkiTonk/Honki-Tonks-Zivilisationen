with Sf.Graphics.Texture;

with KartenartDatentypen;
with GrafikKonstanten;

with KartengeneratorVariablenLogik;
with EingeleseneTexturenGrafik;
with SpritesverwaltungssystemGrafik;

package body ZusatztextKartenformGrafik is

   -- Das mal von Text in irgendwas anderes umbenennen? Oder später zum Bild noch einen Text hinzufügen? äöü
   -- Später noch einmal überarbeiten, gilt auch für die Texturen. äöü
   procedure ZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      Texturfläche := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BilderAccess (1)).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BilderAccess (1)).y));
            
      case
        AktuelleAuswahlExtern
      is
         when 1 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               Texturanfang.x := GrafikKonstanten.Nullwert;
               
            else
               Texturanfang.x := Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := GrafikKonstanten.Nullwert;
            
         when 2 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / GrafikKonstanten.Halbierung;
               
            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := GrafikKonstanten.Nullwert;

         when 3 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               Texturanfang.x := GrafikKonstanten.Nullwert;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / GrafikKonstanten.Halbierung;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := Texturfläche.y / 5.00;

         when 4 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               Texturanfang.x := GrafikKonstanten.Nullwert;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / GrafikKonstanten.Halbierung;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 2.00 * Texturfläche.y / 5.00;

         when 5 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               Texturanfang.x := GrafikKonstanten.Nullwert;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / GrafikKonstanten.Halbierung;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 3.00 * Texturfläche.y / 5.00;

         when 6 =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               Texturanfang.x := GrafikKonstanten.Nullwert;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / 4.00;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               Texturanfang.x := Texturfläche.x / GrafikKonstanten.Halbierung;

            else
               Texturanfang.x := 3.00 * Texturfläche.x / 4.00;
            end if;
            
            Texturanfang.y := 4.00 * Texturfläche.y / 5.00;
            
         when others =>
            return;
      end case;
      
      -- Für solche Skalierungen auch mal ein eigenes System bauen. äöü
      SpritesverwaltungssystemGrafik.SetzenBereichSkalierenZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                     TexturExtern       => EingeleseneTexturenGrafik.BilderAccess (1),
                                                                     BereichExtern      => (Integer (Texturanfang.x), Integer (Texturanfang.y), Integer (Texturfläche.x / 4.00), Integer (Texturfläche.y / 5.00)),
                                                                     SkalierungExtern   => (ViewflächeExtern.x / (Texturfläche.x / 4.00), ViewflächeExtern.y / (Texturfläche.y / 5.00)));
      
   end ZusatztextKartenform;

end ZusatztextKartenformGrafik;
