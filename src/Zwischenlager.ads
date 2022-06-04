-- Später wieder für Standardwerte für die Kartenartwerte einbauen. Ist schon wieder eiongebaut, aber für Notfälle noch hier.
type LandflächenArray is array (KartenDatentypen.Kartenart_Enum'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   GrößeLandfläche : LandflächenArray := (
                                              KartenDatentypen.Kartenart_Inseln_Enum     => (3, 3),
                                              KartenDatentypen.Kartenart_Kontinente_Enum => (7, 7),
                                              KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                              others                                     => (1, 1)
                                             );
   AbstandLandflächen : LandflächenArray := (
                                               KartenDatentypen.Kartenart_Inseln_Enum     => (15, 15),
                                               KartenDatentypen.Kartenart_Kontinente_Enum => (22, 22),
                                               KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                               others                                     => (1, 1)
                                              );



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
