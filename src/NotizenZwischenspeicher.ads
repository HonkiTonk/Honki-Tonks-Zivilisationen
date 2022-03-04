

case
  Karten.Kartenform
is
   -- Normale Kartenformen
   when KartenEinstellungenKonstanten.KartenformXZylinderKonstante =>
      return KartePositionNormaleKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                       ÄnderungExtern    => ÄnderungExtern,
                                                                       LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformYZylinderKonstante =>
      return KartePositionNormaleKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                       ÄnderungExtern    => ÄnderungExtern,
                                                                       LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformTorusKonstante =>
      return KartePositionNormaleKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                   ÄnderungExtern    => ÄnderungExtern,
                                                                   LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformKugelKonstante =>
      return KartePositionNormaleKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                   ÄnderungExtern    => ÄnderungExtern,
                                                                   LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformViereckKonstante =>
      return KartePositionNormaleKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                     ÄnderungExtern    => ÄnderungExtern,
                                                                     LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformKugelGedrehtKonstante =>
      return KartePositionNormaleKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                          ÄnderungExtern    => ÄnderungExtern,
                                                                          LogikGrafikExtern => LogikGrafikExtern);
      -- Normale Kartenformen



      -- Abstrakte Kartenformen
   when KartenEinstellungenKonstanten.KartenformTugelKonstante =>
      return KartePositionAbstrakteKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                     ÄnderungExtern    => ÄnderungExtern,
                                                                     LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformTugelGedrehtKonstante =>
      return KartePositionAbstrakteKartenformen.KartenPositionTugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                            ÄnderungExtern    => ÄnderungExtern,
                                                                            LogikGrafikExtern => LogikGrafikExtern);

   when KartenEinstellungenKonstanten.KartenformTugelExtremKonstante =>
      return KartePositionAbstrakteKartenformen.KartenPositionTugelExtrem (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                           LogikGrafikExtern => LogikGrafikExtern);


      -- Abstrakte Kartenformen
end case;









procedure AnzeigeSpracheKonsole;
-- (AktuelleAuswahlExtern : in Positive;
--  LetzteZeileExtern : in Positive);

procedure AnzeigeSpracheKonsole
is begin

   Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

   --  LängsterText := 1;

   --  TextlängePrüfenSchleife:
   --  for ZeilenSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop

   --     if
   --      To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length > LängsterText
   --    then
   --       LängsterText := To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length;

   --    else
   --       null;
   --    end if;

   --  end loop TextlängePrüfenSchleife;

   -- AnzeigeSchleife:
   --  for ZeileSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop

   --     if
   --       AktuelleAuswahlExtern = ZeileSchleifenwert
   --     then
   --       RahmenTeilEinsSchleife:
   --       for TextlängeEins in 1 .. LängsterText loop

   --        if
   --          TextlängeEins = 1
   --       then
   Put (Item => "╔");
   Put (Item => "═");

   --       elsif
   --        TextlängeEins = LängsterText
   --      then
   Put (Item => "═");
   Put_Line (Item => "╗");
   Put (Item => "║");
   --         Put (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));

   --         LeererPlatzSchleife:
   --         for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))'Length loop

   Put (" ");

   --        end loop LeererPlatzSchleife;

   Put_Line (Item => "║");
   Put (Item => "╚");

   --      else
   Put (Item => "═");
   --     end if;

   --  end loop RahmenTeilEinsSchleife;

   --  RahmenTeilZweiSchleife:
   --  for TextlängeZweiSchleifenwert in 1 .. LängsterText loop

   --    if
   --      TextlängeZweiSchleifenwert = LängsterText
   --    then
   Put (Item => "═");
   Put_Line (Item => "╝");

   --    else
   Put (Item => "═");
   --    end if;

   --  end loop RahmenTeilZweiSchleife;

   -- else
   --     Put_Line (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
   --  end if;

   --  end loop AnzeigeSchleife;

end AnzeigeSpracheKonsole;
