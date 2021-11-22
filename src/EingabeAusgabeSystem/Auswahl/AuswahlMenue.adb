pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with SystemDatentypen; use SystemDatentypen;
with GlobaleTexte;
with GlobaleVariablen;

with GrafikEinstellungen;
with Eingabe;
with AllgemeineTextBerechnungenSFML;
with RueckgabeMenues;
with GrafikHintergrund;
with SFMLDarstellungEinstellungen;

package body AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AllgemeinesFestlegen (WelchesMenüExtern => WelchesMenüExtern);
      SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Menüs;
      
      Auswahl;
   
      RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                        EndeExtern            => Ende,
                                                        AktuelleAuswahlExtern => AktuelleAuswahl,
                                                        WelchesMenüExtern     => WelchesMenü);
      
      SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Pause;
      
      return RückgabeWert;
      
   end AuswahlMenü;

   

   procedure AllgemeinesFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin

      WelchesMenü := WelchesMenüExtern;
      TextZugriffPosition := GrafikEinstellungen.TextStandard;
      Anfang := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
      Ende := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      if
        LetztesMenü = WelchesMenüExtern
      then
         if
           AktuelleAuswahl < AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert)
         then
            AktuelleAuswahl := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);

         elsif
           AktuelleAuswahl > AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert)
         then
            AktuelleAuswahl := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);

         else
            null;
         end if;
         
      else
         AktuelleAuswahl := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
         LetztesMenü := WelchesMenüExtern;
      end if;
      
      case
        AnfangEndeMenü (WelchesMenü, SystemDatentypen.Anfangswert) mod 2
      is
         when 0 =>
            AnzeigeStartwert := 0;
            
         when others =>
            AnzeigeStartwert := 1;
      end case;

   end AllgemeinesFestlegen;
   
   
   
   procedure Überschrift
   is begin
      
      StringSetzen (WelcheZeileExtern     => 1,
                    TextZugriffExtern     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                    AnzeigePositionExtern => Anzeige_Text);
      Sf.Graphics.Text.setCharacterSize (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße)));
      
      AktuellePosition := (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextZugriffExtern => SFMLDarstellungEinstellungen.TextZugriffAnzeige), StartPositionYAchse);
      
      Sf.Graphics.Text.setPosition (text     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                    position => AktuellePosition);
      Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                 color => Sf.Graphics.Color.sfRed);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => SFMLDarstellungEinstellungen.TextZugriffAnzeige);
      
   end Überschrift;
   
         
   
   procedure MausAuswahl
   is begin
      
      MausZeigerPosition := Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster);
      
      StringSetzen (WelcheZeileExtern     => 1,
                    TextZugriffExtern     => TextZugriffPosition,
                    AnzeigePositionExtern => Position_Text);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriffPosition,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße)));
      TextPositionMaus.y := StartPositionYAchse + Sf.Graphics.Text.getLocalBounds (text => TextZugriffPosition).height + ZeilenAbstand;
      Sf.Graphics.Text.setCharacterSize (text => TextZugriffPosition,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in Anfang .. Ende loop
         
         StringSetzen (WelcheZeileExtern     => ZeileSchleifenwert,
                       TextZugriffExtern     => TextZugriffPosition,
                       AnzeigePositionExtern => Position_Text);
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriffPosition,
                                                                                                  LinksRechtsExtern => False);
               
            when others =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriffPosition,
                                                                                                  LinksRechtsExtern => True);
         end case;
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriffPosition).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextZugriffPosition).width)
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            null;
         end if;
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriffPosition).height + ZeilenAbstand;
         end case;   
                  
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
   
   
   procedure AnzeigeSFMLAnfang
   is begin
      
         WelchesMenüSFMLAnzeige := WelchesMenü;
         AnfangSFMLAnzeige := Anfang;
         EndeSFMLAnzeige := Ende;
         AktuelleAuswahlSFMLAnzeige := AktuelleAuswahl;
         
         AnzeigeMenüSFML;
      
   end AnzeigeSFMLAnfang;
   
   
   
   procedure AnzeigeMenüSFML
   is begin
      
      AktuellePosition := (0.00, 0.00);
            
      GrafikHintergrund.HintergrundMenü (WelchesMenüExtern => WelchesMenüSFMLAnzeige);
      
      Überschrift;
      AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige).height + ZeilenAbstand;
      
      AnzeigeSchleife:
      for TextSchleifenwert in AnfangSFMLAnzeige .. EndeSFMLAnzeige loop
      
         Sf.Graphics.Text.setCharacterSize (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                            size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
         StringSetzen (WelcheZeileExtern     => TextSchleifenwert,
                       TextZugriffExtern     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                       AnzeigePositionExtern => Anzeige_Text);
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                                                                                  LinksRechtsExtern => False);
               
            when others =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                                                                                  LinksRechtsExtern => True);
         end case;
         
         Sf.Graphics.Text.setPosition (text     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                       position => AktuellePosition);
         
         AnzeigeFarbeBestimmen (TextZeileExtern => TextSchleifenwert);
            
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => SFMLDarstellungEinstellungen.TextZugriffAnzeige);
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige).height + ZeilenAbstand;
         end case;
         
      end loop AnzeigeSchleife;
      
      WeiterenTextAnzeigen;
      
   end AnzeigeMenüSFML;
   
   
   
   procedure AnzeigeFarbeBestimmen
     (TextZeileExtern : in Positive)
   is begin
      
      if
        AktuelleAuswahlSFMLAnzeige = TextZeileExtern
      then
         Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                    color => Sf.Graphics.Color.sfGreen);
         
      elsif
        WelchesMenüSFMLAnzeige = SystemDatentypen.Rassen_Menü
      then
         RassenBelegt := TextZeileExtern;
         RassenBelegtZähler := AnfangSFMLAnzeige;
         
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              RassenBelegtZähler = RassenBelegt
              and
                GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Spieler_Mensch
            then
               Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                          color => Sf.Graphics.Color.sfBlue);
               return;
               
            elsif
              RassenBelegtZähler = RassenBelegt
              and
                GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Spieler_KI
            then
               Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                          color => Sf.Graphics.Color.sfYellow);
               return;
               
            elsif
              RassenBelegtZähler = RassenBelegt
            then
               Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                          color => Sf.Graphics.Color.sfWhite);
               return;
               
            else
               RassenBelegtZähler := RassenBelegtZähler + 1;
            end if;
               
         end loop RassenSchleife;
         
         Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                    color => Sf.Graphics.Color.sfWhite);
         
      else
         Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                    color => Sf.Graphics.Color.sfWhite);
      end if;
      
   end AnzeigeFarbeBestimmen;
   
   
   
   procedure WeiterenTextAnzeigen
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      StringSetzen (WelcheZeileExtern     => AktuelleAuswahlSFMLAnzeige + 1 + (EndeSFMLAnzeige - AnfangSFMLAnzeige),
                    TextZugriffExtern     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                    AnzeigePositionExtern => Anzeige_Text);
      Sf.Graphics.Text.setColor (text  => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                 color => Sf.Graphics.Color.sfWhite);
      ErstesZeichen := 1;
      XPosition := Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe - GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe / 6);
      
      TextSchleife:
      loop
         ZeichenSchleife:
         for TextSchleifenwert in ErstesZeichen .. To_Wide_Wide_String (Source => AktuellerText (Anzeige_Text))'Last loop
            
            Sf.Graphics.Text.setUnicodeString (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                               str  => To_Wide_Wide_String (Source => AktuellerText (Anzeige_Text)) (ErstesZeichen .. TextSchleifenwert));
            
            if
              Sf.Graphics.Text.getLocalBounds (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige).width < Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite) - 2.00 * StartPositionYAchse
              and
                TextSchleifenwert < To_Wide_Wide_String (Source => AktuellerText (Anzeige_Text))'Last
            then
               null;
               
            elsif
              TextSchleifenwert = To_Wide_Wide_String (Source => AktuellerText (Anzeige_Text))'Last
            then
               exit TextSchleife;
               
            else
               Sf.Graphics.Text.setPosition (text     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                             position => (StartPositionYAchse, XPosition));
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                                  text         => SFMLDarstellungEinstellungen.TextZugriffAnzeige);
               XPosition := XPosition + ZeilenAbstand + Sf.Graphics.Text.getLocalBounds (text => SFMLDarstellungEinstellungen.TextZugriffAnzeige).height;
               ErstesZeichen := TextSchleifenwert + 1;
               exit ZeichenSchleife;
            end if;
            
         end loop ZeichenSchleife;
      end loop TextSchleife;
      
      Sf.Graphics.Text.setPosition (text     => SFMLDarstellungEinstellungen.TextZugriffAnzeige,
                                    position => (StartPositionYAchse, XPosition));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => SFMLDarstellungEinstellungen.TextZugriffAnzeige);
      
   end WeiterenTextAnzeigen;
   
   
   
   procedure StringSetzen
     (WelcheZeileExtern : in Positive;
      TextZugriffExtern : in Sf.Graphics.sfText_Ptr;
      AnzeigePositionExtern : in Anzeige_Position_Text_Enum)
   is begin
      
      case
        WelchesMenü
      is
         when SystemDatentypen.Haupt_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Hauptmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Spiel_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Spielmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Optionen_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Optionsmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Kartengröße_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Kartengröße (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenart_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Kartenart (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenform_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Kartenform (WelcheZeileExtern);
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Kartentemperatur (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Ressourcenmenge (WelcheZeileExtern);
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern);
                        
         when SystemDatentypen.Rassen_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Rassenauswahl (WelcheZeileExtern);
            
         when SystemDatentypen.Grafik_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Grafikmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Sound_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Soundmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Sonstiges_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Sonstigesmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Steuerung_Menü =>
            AktuellerText (AnzeigePositionExtern) := GlobaleTexte.Steuerungmenü (WelcheZeileExtern);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextZugriffExtern,
                                         str  => To_Wide_Wide_String (Source => AktuellerText (AnzeigePositionExtern)));
      
   end StringSetzen;

      
   
   procedure Auswahl
   is begin
      
      AuswahlSchleife:
      loop
      
         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben | SystemDatentypen.Ebene_Hoch =>
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten | SystemDatentypen.Ebene_Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
               -- Später noch erweitern?
            when SystemDatentypen.Links =>
               null;
               
            when SystemDatentypen.Rechts =>
               null;
                              
            when SystemDatentypen.Auswählen =>
               return;
            
            when others =>
               null;
         end case;
      
         MausAuswahl;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
end AuswahlMenue;
