NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse
:= KartenkoordinateYAchseBerechnen.KartenkoordinateYAchseBerechnen (KoordinatenExtern   => (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                    ÄnderungExtern      => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                    ArrayPositionExtern => KoordinatenExtern.EAchse,
                                                                    LogikGrafikExtern   => LogikGrafikExtern);

if
  NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).YAchse = KartenKonstanten.LeerYAchse
then
   return KartenRecordKonstanten.LeerKartenKoordinaten;
else
   null;
end if;


NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse
:= KartenkoordinateXAchseBerechnen.KartenkoordinateXAchseBerechnen (KoordinatenExtern   => (KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                    ÄnderungExtern      => (ÄnderungExtern.YAchse, ÄnderungExtern.XAchse),
                                                                    ArrayPositionExtern => KoordinatenExtern.EAchse,
                                                                    LogikGrafikExtern   => LogikGrafikExtern);

if
  NeueKoordinate (LogikGrafikExtern, KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
then
   return KartenRecordKonstanten.LeerKartenKoordinaten;
else
   null;
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

end AnzeigeSpracheKonsole;
