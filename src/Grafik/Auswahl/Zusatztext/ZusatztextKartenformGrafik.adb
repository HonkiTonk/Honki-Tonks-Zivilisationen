with Sf.Graphics.Texture;

with KartenartDatentypen;
with SpeziesDatentypen;

with KartengeneratorVariablenLogik;
with EingeleseneTexturenGrafik;
with SpritesverwaltungssystemGrafik;
with TexturenfelderVariablenGrafik;

package body ZusatztextKartenformGrafik is

   -- Später mal die Zahlen mit KartenformmenueGrafik Konstanten zusammenführen? äöü
   procedure ZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      Texturfläche := (Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenformenAccess).x),
                        Float (Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenformenAccess).y));
            
      case
        AktuelleAuswahlExtern
      is
         when ÜbergangOben =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Eins_Enum;
               
            else
               Kartenform := GrafikDatentypen.Kartenformen_Zwei_Enum;
            end if;
            
         when ÜbergangUnten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Drei_Enum;
               
            else
               Kartenform := GrafikDatentypen.Kartenformen_Vier_Enum;
            end if;

         when ÜbergangNorden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Fünf_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Sechs_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Sieben_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Acht_Enum;
            end if;

         when ÜbergangSüden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Neun_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Zehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Elf_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Zwölf_Enum;
            end if;

         when ÜbergangWesten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Dreizehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Vierzehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Fünfzehn_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Sechzehn_Enum;
            end if;

         when ÜbergangOsten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Siebzehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Achtzehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Neunzehn_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Zwanzig_Enum;
            end if;
            
         when others =>
            return;
      end case;
      
      SpritesverwaltungssystemGrafik.SetzenBereichSkalierenZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                     TexturExtern       => EingeleseneTexturenGrafik.KartenformenAccess,
                                                                     BereichExtern      => TexturenfelderVariablenGrafik.AllgemeinesRechteck (HintergrundExtern => Kartenform,
                                                                                                                                              SpeziesExtern     => SpeziesDatentypen.Leer_Spezies_Enum),
                                                                     SkalierungExtern   => Skalierungsberechnung (ViewflächeExtern   => ViewflächeExtern,
                                                                                                                  TexturflächeExtern => Texturfläche,
                                                                                                                  FelderanzahlExtern  => (4.00, 5.00)));
      
   end ZusatztextKartenform;
   
   
   
   -- Ist das hier sinnvoll oder unnötig/doppelt? äöü
   function Skalierungsberechnung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      TexturflächeExtern : in Sf.System.Vector2.sfVector2f;
      FelderanzahlExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (ViewflächeExtern.x / (TexturflächeExtern.x / FelderanzahlExtern.x), ViewflächeExtern.y / (TexturflächeExtern.y / FelderanzahlExtern.y));
      
   end Skalierungsberechnung;

end ZusatztextKartenformGrafik;
