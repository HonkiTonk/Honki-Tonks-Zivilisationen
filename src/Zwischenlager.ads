procedure Einheitenbefehlsknöpfe
  (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
is begin

   -- Später nicht nur auf Kampfeinheit abfragen sondern direkt auf die Einheitenart und dementsprechend die Knöpfe festlegen. äöü
   -- Ist wichtig für die speziellen Einheiten. äöü
   Kampfeinheit := EinheitenAllgemeinesLogik.Kampfeinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
   Aktuelleposition := 1;

   PositionenSchleife:
   for PositionSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop

      if
        Kampfeinheit
        and
          PositionSchleifenwert in BefehleDatentypen.Siedler_Aufgaben_Enum'Range
      then
         InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;

      elsif
        (Kampfeinheit = False)
        and
          PositionSchleifenwert in BefehleDatentypen.Kampf_Aufgaben_Enum'Range
      then
         InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := GrafikRecordKonstanten.Leerbereich;

      else
         Spritegröße := TexturenSetzenSkalierenGrafik.Textursetzung (SpriteAccessExtern  => SpriteAccess,
                                                                       TextureAccessExtern => EingeleseneTexturenGrafik.SystemAccess (PositionSchleifenwert));

         case
           Aktuelleposition mod 2
         is
            when 0 =>
               Knopfposition.x := Spritegröße.x;
               Knopfposition.y := Spritegröße.y * Float'Floor (Float (Aktuelleposition - 1) / 2.00);

            when others =>
               Knopfposition.x := 0.00;
               Knopfposition.y := Spritegröße.y * Float'Floor (Float (Aktuelleposition) / 2.00);
         end case;

         KartenspritesZeichnenGrafik.BefehlsknöpfespriteZeichnen (SpriteAccesExtern => SpriteAccess,
                                                                   PositionExtern    => Knopfposition);

         Textbox := Sf.Graphics.Sprite.getGlobalBounds (sprite => SpriteAccess);
         InteraktionAuswahl.PositionenEinheitenbefehle (PositionSchleifenwert) := Textbox;
      end if;

      Aktuelleposition := Aktuelleposition + 1;

   end loop PositionenSchleife;

   GesamteSpritegröße.x := 2.00 * Spritegröße.x;
   GesamteSpritegröße.y := Float'Floor (Float (Aktuelleposition) / 2.00) * Spritegröße.y;

   EinheitenViewfläche := GesamteSpritegröße;

end Einheitenbefehlsknöpfe;
