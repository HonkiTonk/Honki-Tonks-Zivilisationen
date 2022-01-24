if
  PositionNeu.YAchse < PositionAlt.YAchse
  and
    PositionNeu.XAchse < PositionAlt.XAchse
then
   return 10;

elsif
  (PositionNeu.YAchse < PositionAlt.YAchse
   and
     PositionNeu.XAchse = PositionAlt.XAchse)
  or
    (PositionNeu.YAchse = PositionAlt.YAchse
     and
       PositionNeu.XAchse < PositionAlt.XAchse)
then
   return 5;

elsif
  (PositionNeu.YAchse < PositionAlt.YAchse
   and
     PositionNeu.XAchse > PositionAlt.XAchse)
  or
    (PositionNeu.YAchse > PositionAlt.YAchse
     and
       PositionNeu.XAchse < PositionAlt.XAchse)
then
   return 3;

elsif
  (PositionNeu.YAchse = PositionAlt.YAchse
   and
     PositionNeu.XAchse > PositionAlt.XAchse)
  or
    (PositionNeu.YAchse > PositionAlt.YAchse
     and
       PositionNeu.XAchse = PositionAlt.XAchse)
then
   return 2;

else
   return 1;
end if;



with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package FOSDEM is

   RecordInputOutputAttempt : constant Positive := 3;
   -- RecordStartAttempt : constant Positive := 4;

   -- Put_Line (FOSDEM.RecordInputOutputAttempt'Wide_Wide_Image);
   -- Put_Line (RecordStartAttempt'Wide_Wide_Image);

private

   -- Text_IO
   -- Stream_IO

   IntegerNumber : Integer := 3;
   FloatNumber : Float := 0.20;

   IntegerNumberToText : Unbounded_Wide_Wide_String
     := To_Unbounded_Wide_Wide_String (Source => IntegerNumber'Wide_Wide_Image);
   FloatNumberToText : Unbounded_Wide_Wide_String
     := To_Unbounded_Wide_Wide_String (Source => FloatNumber'Wide_Wide_Image);

   -- 1.00 -- 1.00E0001

   -- Stringtype, Wide_Stringtype, Wide_Wide_Stringtype.

   MostImportantString : Unbounded_Wide_Wide_String
     := To_Unbounded_Wide_Wide_String ("Put Wide_Wide_String here");

   SometimesNeededString : Wide_Wide_String (1 .. 10)
     := To_Wide_Wide_String (MostImportantString) (1 .. 10);

   SingleTestCharacter : constant Wide_Wide_Character := '@';

   RecordImageAttempt : constant Positive := 4;
   RecordStringsAttempt : constant Positive := 7;

end FOSDEM;



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
