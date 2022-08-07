function TextpositionFestlegen
  (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
   TextbereichExtern : in Positive)
      return Sf.System.Vector2.sfVector2f
is begin

   Rechenwert.y := StartpositionText.y;
   -- Den View später mit übergeben, wenn es denn so funktioniert wie ich mir das vorstelle.
   Rechenwert.x := StartpositionText.x + Sf.Graphics.View.getSize (view => ViewsSFML.MenüviewAccess).x / 2.00
     - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift));
   -- Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift));

   Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift),
                                 position => Rechenwert);

   AktuelleTextbreite := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).left
     + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift)).width + StartpositionText.x;
   Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Überschriftabstand;

   PositionenSchleife:
   for PositionSchleifenwert in Überschrift .. SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug loop

      case
        PositionSchleifenwert mod 2
      is
         when 0 =>
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                          position => Rechenwert);
            -- Rechenwert.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
            --                                                                      LinksRechtsExtern => False);
            NeueTextbreite := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).left
              + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width + StartpositionText.x;

         when others =>
            -- if
            --   PositionSchleifenwert = SystemKonstanten.EndeMenü (WelchesMenüExtern) - SchleifenAbzug
            -- then
            -- Hier eine Prüfung bauen um den Text in der Mitte zu platzieren?
            Rechenwert.x := StartpositionText.x;

            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
                                          position => Rechenwert);

            Rechenwert.x := Rechenwert.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width + 20.00;
            -- Rechenwert.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert),
            --                                                                      LinksRechtsExtern => True);
            NeueTextbreite := StartpositionText.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert)).width;
      end case;

      case
        PositionSchleifenwert mod 2
      is
         when 0 =>
            Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.Zeilenabstand;

         when others =>
            null;
      end case;

      InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert)
        := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, Überschrift + PositionSchleifenwert));

      if
        NeueTextbreite > AktuelleTextbreite
      then
         AktuelleTextbreite := NeueTextbreite;

      else
         null;
      end if;

   end loop PositionenSchleife;

   case
     WelchesMenüExtern
   is
      when MenueDatentypen.Kartengröße_Menü_Enum =>
         InteraktionAuswahl.LetzteTextpositionKartengröße := Rechenwert.y;

      when others =>
         null;
   end case;

   Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.ÜberschriftabstandGroß;
   Rechenwert.x := StartpositionText.x + Sf.Graphics.View.getSize (view => ViewsSFML.MenüviewAccess).x / 2.00
     - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern));
   -- Rechenwert.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern));

   Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.MenüsEinfachSFMLAccess (WelchesMenüExtern, TextbereichExtern),
                                 position => Rechenwert);
   Rechenwert.y := Rechenwert.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;

   return (AktuelleTextbreite, Rechenwert.y);

end TextpositionFestlegen;



procedure AnzeigeSpracheTerminal;
-- (AktuelleAuswahlExtern : in Positive;
--  LetzteZeileExtern : in Positive);

procedure AnzeigeSpracheTerminal
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

   Put (Item => " ");

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

end AnzeigeSpracheTerminal;
