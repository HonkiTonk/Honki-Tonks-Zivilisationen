case
  GrundExtern
is
   -------------------------- Den Kartengrund mal in entsprechende subtypen aufteilen, ein Array erstellen und die Zeit darin für die lokalen Bereiche festlegen.
   -------------------------- Das für alle Arbeiten vornehmen.
   when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Hügel_Enum
      | KartengrundDatentypen.Wald_Enum =>
      if
        LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenVerbesserungDatentypen.Karten_Straße_Enum'Range
      then
         SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BeschäftigungExtern     => AufgabenDatentypen.Schiene_Bauen_Enum);

      else
         SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BeschäftigungExtern     => AufgabenDatentypen.Straße_Bauen_Enum);
      end if;

      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => 3,
                                                   RechnenSetzenExtern      => 0);

   when KartengrundDatentypen.Gebirge_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => AufgabenDatentypen.Straße_Bauen_Enum);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => 6,
                                                   RechnenSetzenExtern      => 0);

   when others =>
      return False;
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
