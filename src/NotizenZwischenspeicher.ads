AnzahlGleicherGrund : KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder;

KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

type KartengrundWahrscheinlichkeitenArray is array (KartengrundDatentypen.Karten_Unterwasser_Generator_Enum'Range, KartenGeneratorBerechnungenAllgemein.AnzahlGleicherFelder'Range) of Float;
KartengrundWahrscheinlichkeiten : constant KartengrundWahrscheinlichkeitenArray := (
                                                                                    KartengrundDatentypen.Korallen_Enum =>
                                                                                      (
                                                                                       0 => 0.20,
                                                                                       1 => 0.25,
                                                                                       2 => 0.25,
                                                                                       3 => 0.25,
                                                                                       4 => 0.30,
                                                                                       5 => 0.30,
                                                                                       6 => 0.30,
                                                                                       7 => 0.40,
                                                                                       8 => 0.55
                                                                                      ),

                                                                                    KartengrundDatentypen.Unterwald_Enum =>
                                                                                      (
                                                                                       0 => 0.20,
                                                                                       1 => 0.25,
                                                                                       2 => 0.25,
                                                                                       3 => 0.25,
                                                                                       4 => 0.30,
                                                                                       5 => 0.30,
                                                                                       6 => 0.30,
                                                                                       7 => 0.40,
                                                                                       8 => 0.55
                                                                                      )
                                                                                   );


procedure WasserweltErzeugen
  (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
   XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
is begin

   GrundSchleife:
   for GrundSchleifenwert in KartengrundDatentypen.Karten_Unterwasser_Generator_Enum'Range loop

      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern),
                                                                                                GrundExtern       => GrundSchleifenwert,
                                                                                                EbeneExtern       => -1);

      if
        ZufallsgeneratorenKarten.ZufälligerWert <= KartengrundWahrscheinlichkeiten (GrundSchleifenwert, AnzahlGleicherGrund)
      then
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern),
                               GrundExtern       => GrundSchleifenwert);

      else
         null;
      end if;

   end loop GrundSchleife;

   case
     LeseKarten.Grund (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern))
   is
      when KartengrundDatentypen.Leer_Grund_Enum =>
         SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern),
                               GrundExtern       => KartengrundDatentypen.Unterwasser_Enum);

      when others =>
         null;
   end case;

end WasserweltErzeugen;


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
