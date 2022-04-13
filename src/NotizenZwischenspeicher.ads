


function Auswahl
  (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
   TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
   FrageZeileExtern : in Natural;
   ErsteZeileExtern : in Natural;
   LetzteZeileExtern : in Natural)
      return Integer
  with
    Pre =>
      (ErsteZeileExtern <= LetzteZeileExtern
       and
         (if FrageDateiExtern = GlobaleTexte.Leer then FrageZeileExtern = 0)
       and
         (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleTexte.Leer)
       and
         TextDateiExtern /= GlobaleTexte.Leer);

-- Das ist noch für die Konsole, wird aktuell gar nicht verwendet? Aber wenn, dann funktioniert das eh nicht mehr.
-- Alter Kommentar, zu besseren? Orientierung was das mal war da.
function Auswahl
  (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
   TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
   FrageZeileExtern : in Natural;
   ErsteZeileExtern : in Natural;
   LetzteZeileExtern : in Natural)
      return Integer
is begin

   Anfang := ErsteZeileExtern;
   Ende := LetzteZeileExtern;
   AktuelleAuswahl := ErsteZeileExtern;

   AuswahlSchleife:
   loop

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      TextAnzeigeKonsole.AnzeigeMitAuswahlNeu (FrageDateiExtern      => FrageDateiExtern,
                                               TextDateiExtern       => TextDateiExtern,
                                               FrageZeileExtern      => FrageZeileExtern,
                                               ErsteZeileExtern      => ErsteZeileExtern,
                                               LetzteZeileExtern     => LetzteZeileExtern,
                                               AktuelleAuswahlExtern => AktuelleAuswahl);

      case
        Eingabe.Tastenwert
      is
         when TastenbelegungDatentypen.Oben_Enum =>
            if
              AktuelleAuswahl = Anfang
            then
               AktuelleAuswahl := Ende;

            else
               AktuelleAuswahl := AktuelleAuswahl - 1;
            end if;

         when TastenbelegungDatentypen.Unten_Enum =>
            if
              AktuelleAuswahl = Ende
            then
               AktuelleAuswahl := Anfang;

            else
               AktuelleAuswahl := AktuelleAuswahl + 1;
            end if;

         when TastenbelegungDatentypen.Auswählen_Enum =>
            -- Hauptmenü
            if
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 1)
            then
               return 1;

               -- Spiel beenden
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 2)
            then
               return 2;

               -- Zurück
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 3)
            then
               return 3;

               -- Ja
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 4)
            then
               return 4;

               -- Nein
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 5)
            then
               return 5;

               -- Speichern
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 6)
            then
               return 6;

               -- Laden
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 7)
            then
               return 7;

               -- Optionen
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 8)
            then
               return 8;

               -- Informationen
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 9)
            then
               return 9;

               -- Wiederherstellen
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 10)
            then
               return 10;

               -- Würdigungen
            elsif
              GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesen (2, 11)
            then
               return 11;

            else
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return AktuelleAuswahl - ErsteZeileExtern + 1;
            end if;

         when others =>
            null;
      end case;

   end loop AuswahlSchleife;

end Auswahl;

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
