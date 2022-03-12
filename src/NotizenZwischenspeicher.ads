


function PositionBestimmen_X_Y_Wechsel
  (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
   ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
   LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
is begin

   if
     KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
   then
      if
        KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

      else
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), 1);

      else
         return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse));
      end if;

   elsif
     KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
   then
      if
        KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

      else
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
      end if;

      if
        KoordinatenExtern.XAchse = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
        and
          ÄnderungExtern.XAchse = 1
      then
         return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

      else
         return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse - ÄnderungExtern.XAchse));
      end if;

   else
      null;
   end if;

   if
     KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
   then
      return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, 1);

   else
      return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
   end if;







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
