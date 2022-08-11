procedure AnzeigeGanzeZahl
  (FrageExtern : in ZahlenDatentypen.EigenesNatural)
is begin

   -- Viewfläche := ViewsEinstellenSFML.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
   ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.ZusatztextviewAccess,
                                       GrößeExtern          => Viewfläche,
                                       AnzeigebereichExtern => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 4.00, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 10.00,
                                                                3.00 * GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 4.00, 2.00 * GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 10.00));
   HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Standard_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);

   Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                      str  => To_Wide_Wide_String (Source => GlobaleTexte.Frage (FrageExtern)));

   Textbreite := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First)).width;

   Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'First),
                                 position => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 2.00 - Textbreite / 2.00, 100.00));

   case
     EingabeSFML.WelchesVorzeichen
   is
      when False =>
         AktuellerText := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);

      when True =>
         AktuellerText := ZahlAlsStringNatural (ZahlExtern => EingabeSFML.AktuellerWert);
   end case;

   Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                      str  => To_Wide_Wide_String (Source => AktuellerText));

   Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last),
                                 position => ((GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 2.00
                                              - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Last)).width / 2.00),
                                              150.00));

   ZahlenanzeigeSchleife:
   for ZahlenanzeigeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop

      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahlenanzeigeSchleifenwert));

   end loop ZahlenanzeigeSchleife;

   ViewsEinstellenSFML.Standardview;

end AnzeigeGanzeZahl;



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
