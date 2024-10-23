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
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneOben = KartenartDatentypen.Ebene_Übergangslos_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Eins_Enum;
               
            else
               Kartenform := GrafikDatentypen.Kartenformen_Zwei_Enum;
            end if;
            
         when ÜbergangUnten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EbeneUnten = KartenartDatentypen.Ebene_Übergangslos_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Drei_Enum;
               
            else
               Kartenform := GrafikDatentypen.Kartenformen_Vier_Enum;
            end if;

         when ÜbergangNorden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Fünf_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Sechs_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteNorden = KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Sieben_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Acht_Enum;
            end if;

         when ÜbergangSüden =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Neun_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Zehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.SenkrechteSüden = KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Elf_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Zwölf_Enum;
            end if;

         when ÜbergangWesten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Dreizehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Vierzehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteWesten = KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Fünfzehn_Enum;

            else
               Kartenform := GrafikDatentypen.Kartenformen_Sechzehn_Enum;
            end if;

         when ÜbergangOsten =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Siebzehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergang_Enum
            then
               Kartenform := GrafikDatentypen.Kartenformen_Achtzehn_Enum;

            elsif
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.WaagerechteOsten = KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum
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
