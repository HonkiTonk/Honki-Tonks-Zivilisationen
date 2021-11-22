pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

with SFMLDarstellungEinstellungen;
with AuswahlMenue;
with GrafikEinstellungen;
with GrafikHintergrund;
with AllgemeineTextBerechnungenSFML;

package body AuswahlMenueAnzeige is

   procedure AnzeigeSFMLAnfang
   is begin
      
      case
        SFMLDarstellungEinstellungen.AktuelleDarstellung
      is
         when SystemDatentypen.SFML_Menüs =>
            ZeilenAbstand := 0.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
            WelchesMenü := AuswahlMenue.WelchesMenü;
            Anfang := AuswahlMenue.Anfang;
            Ende := AuswahlMenue.Ende;
            AktuelleAuswahl := AuswahlMenue.AktuelleAuswahl;
            AnzeigeStartwert := AuswahlMenue.AnzeigeStartwert;
            Sf.Graphics.Text.setFont (text => TextZugriff,
                                      font => GrafikEinstellungen.Schriftart);
            
            AnzeigeMenüSFML;
            
         when others =>
            return;
      end case;
      
   end AnzeigeSFMLAnfang;
   
   
   
   procedure AnzeigeMenüSFML
   is begin
      
      AktuellePosition := (0.00, 0.00);
      
      GrafikHintergrund.HintergrundMenü (WelchesMenüExtern => WelchesMenü);
      Überschrift;
      
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
      
      AnzeigeSchleife:
      for TextSchleifenwert in Anfang .. Ende loop
      
         Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                            str  => AuswahlMenue.StringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                               WelchesMenüExtern => WelchesMenü));
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                                                  LinksRechtsExtern => False);
               
            when others =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                                                  LinksRechtsExtern => True);
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                       position => AktuellePosition);
         
         AnzeigeFarbeBestimmen (TextZeileExtern => TextSchleifenwert);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => TextZugriff);
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
         end case;
         
      end loop AnzeigeSchleife;
      
      WeiterenTextAnzeigen;
      
   end AnzeigeMenüSFML;
   
   
   
   procedure AnzeigeFarbeBestimmen
     (TextZeileExtern : in Positive)
   is begin
      
      if
        TextZeileExtern = 1
      then
         AktuelleFarbe := Sf.Graphics.Color.sfRed;
           
      elsif
        AktuelleAuswahl = TextZeileExtern
      then
         AktuelleFarbe := Sf.Graphics.Color.sfGreen;
         
      elsif
        WelchesMenü = SystemDatentypen.Rassen_Menü
      then
         RassenBelegt := TextZeileExtern;
         RassenBelegtZähler := Anfang;
         AktuelleFarbe := Sf.Graphics.Color.sfWhite;
         
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              RassenBelegtZähler = RassenBelegt
            then
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is
                  when SystemDatentypen.Spieler_Mensch =>
                     AktuelleFarbe := Sf.Graphics.Color.sfBlue;
                     
                  when SystemDatentypen.Spieler_KI =>
                     AktuelleFarbe := Sf.Graphics.Color.sfYellow;
                     
                  when SystemDatentypen.Leer =>
                     null;
               end case;
               
               exit RassenSchleife;
               
            else
               RassenBelegtZähler := RassenBelegtZähler + 1;
            end if;
               
         end loop RassenSchleife;
         
      else
         AktuelleFarbe := Sf.Graphics.Color.sfWhite;
      end if;
      
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => AktuelleFarbe);
      
   end AnzeigeFarbeBestimmen;
   
   
   
   procedure Überschrift
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                         str  => AuswahlMenue.StringSetzen (WelcheZeileExtern => 1,
                                                                            WelchesMenüExtern => WelchesMenü));
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße)));
      
      AktuellePosition := (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff), StartPositionYAchse);
      
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => AktuellePosition);
      AnzeigeFarbeBestimmen (TextZeileExtern => 1);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end Überschrift;
   
   
   
   procedure WeiterenTextAnzeigen
   is begin
      
      AktuellerText := To_Unbounded_Wide_Wide_String (Source => AuswahlMenue.StringSetzen (WelcheZeileExtern => AktuelleAuswahl + 1 + (Ende - Anfang),
                                                                                           WelchesMenüExtern => WelchesMenü));
      
      Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => Sf.Graphics.Color.sfWhite);
      ErstesZeichen := 1;
      YPosition := Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe - GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe / 5);
      
      TextSchleife:
      loop
         ZeichenSchleife:
         for TextSchleifenwert in ErstesZeichen .. To_Wide_Wide_String (Source => AktuellerText)'Last loop
            
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => AktuellerText) (ErstesZeichen .. TextSchleifenwert));
            
            if
              Sf.Graphics.Text.getLocalBounds (text => TextZugriff).width < Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite) - 2.00 * StartPositionYAchse
              and
                TextSchleifenwert < To_Wide_Wide_String (Source => AktuellerText)'Last
            then
               null;
               
            elsif
              TextSchleifenwert = To_Wide_Wide_String (Source => AktuellerText)'Last
            then
               exit TextSchleife;
               
            else
               Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                             position => (StartPositionXAchse, YPosition));
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                                  text         => TextZugriff);
               YPosition := YPosition + ZeilenAbstand + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height;
               ErstesZeichen := TextSchleifenwert + 1;
               exit ZeichenSchleife;
            end if;
            
         end loop ZeichenSchleife;
      end loop TextSchleife;
      
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => (StartPositionXAchse, YPosition));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end WeiterenTextAnzeigen;

end AuswahlMenueAnzeige;
