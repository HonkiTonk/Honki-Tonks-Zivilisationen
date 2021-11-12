pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with SystemDatentypen; use SystemDatentypen;
with GlobaleTexte;
with GlobaleVariablen;

with GrafikAllgemein;
with GrafikEinstellungen;
with Eingabe;
with AllgemeineTextBerechnungenSFML;
with RueckgabeMenues;

package body AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AllgemeinesFestlegen (WelchesMenüExtern => WelchesMenüExtern);
      
      Auswahl;
   
      return RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                              EndeExtern            => Ende,
                                              AktuelleAuswahlExtern => AktuelleAuswahl,
                                              WelchesMenüExtern     => WelchesMenü);
      
   end AuswahlMenü;



   procedure AllgemeinesFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
   is begin

      WelchesMenü := WelchesMenüExtern;
      TextZugriff := GrafikEinstellungen.TextStandard;
      Anfang := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Anfangswert);
      Ende := AnfangEndeMenü (WelchesMenüExtern, SystemDatentypen.Endwert);
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungen.Schriftgröße);
      
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
            
      StringSetzen (WelcheZeileExtern => 1);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.Schriftgröße)));
      
      AktuellePosition := (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextZugriffExtern => TextZugriff), StartPositionYAchse);
      
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => AktuellePosition);
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => Sf.Graphics.Color.sfRed);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end Überschrift;
   
         
   
   procedure MausAuswahl
   is begin
      
      MausZeigerPosition := Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster);
      
      StringSetzen (WelcheZeileExtern => 1);
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungen.Schriftgröße)));
      TextPositionMaus.y := StartPositionYAchse + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => GrafikEinstellungen.Schriftgröße);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in Anfang .. Ende loop
                  
         StringSetzen (WelcheZeileExtern => ZeileSchleifenwert);
         
         case
           (ZeileSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                                                  LinksRechtsExtern => False);
               
            when others =>
               TextPositionMaus.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextZugriffExtern => TextZugriff,
                                                                                                  LinksRechtsExtern => True);
         end case;
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus.y)
           .. Sf.sfInt32 (TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height)
           and
             MausZeigerPosition.x in Sf.sfInt32 (TextPositionMaus.x) .. Sf.sfInt32 (TextPositionMaus.x + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).width)
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
               TextPositionMaus.y := TextPositionMaus.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
         end case;   
                  
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
   
   
   procedure AnzeigeMenüSFML
   is begin
      
      AktuellePosition := (0.00, 0.00);
            
      GrafikAllgemein.FensterLeeren;
      
      Überschrift;
      AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
      
      AnzeigeSchleife:
      for TextSchleifenwert in Anfang .. Ende loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                            size => GrafikEinstellungen.Schriftgröße);
         StringSetzen (WelcheZeileExtern => TextSchleifenwert);
         
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
      
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMenüSFML;
   
   
   
   procedure AnzeigeFarbeBestimmen
     (TextZeileExtern : in Positive)
   is begin
      
      if
        AktuelleAuswahl = TextZeileExtern
      then
         Sf.Graphics.Text.setColor (text  => TextZugriff,
                                    color => Sf.Graphics.Color.sfGreen);
         
      elsif
        WelchesMenü = SystemDatentypen.Rassen_Menü
      then
         RassenBelegt := TextZeileExtern;
         RassenBelegtZähler := Anfang;
         
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              RassenBelegtZähler = RassenBelegt
              and
                GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Spieler_Mensch
            then
               Sf.Graphics.Text.setColor (text  => TextZugriff,
                                          color => Sf.Graphics.Color.sfBlue);
               return;
               
            elsif
              RassenBelegtZähler = RassenBelegt
              and
                GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Spieler_KI
            then
               Sf.Graphics.Text.setColor (text  => TextZugriff,
                                          color => Sf.Graphics.Color.sfYellow);
               return;
               
            elsif
              RassenBelegtZähler = RassenBelegt
            then
               Sf.Graphics.Text.setColor (text  => TextZugriff,
                                          color => Sf.Graphics.Color.sfWhite);
               return;
               
            else
               RassenBelegtZähler := RassenBelegtZähler + 1;
            end if;
               
         end loop RassenSchleife;
         
         Sf.Graphics.Text.setColor (text  => TextZugriff,
                                    color => Sf.Graphics.Color.sfWhite);
         
      else
         Sf.Graphics.Text.setColor (text  => TextZugriff,
                                    color => Sf.Graphics.Color.sfWhite);
      end if;
      
   end AnzeigeFarbeBestimmen;
   
   
   
   procedure WeiterenTextAnzeigen
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextZugriff,
                                         size => GrafikEinstellungen.Schriftgröße);
      StringSetzen (WelcheZeileExtern => AktuelleAuswahl + 1 + (Ende - Anfang));
      Sf.Graphics.Text.setColor (text  => TextZugriff,
                                 color => Sf.Graphics.Color.sfWhite);
      ErstesZeichen := 1;
      LetztesZeichen := 1;
      XPosition := 400.00;
      
      A:
      loop
         B:
         for TextSchleifenwert in ErstesZeichen .. LetztesZeichen loop
            
            Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                               str  => To_Wide_Wide_String (Source => AktuellerText) (ErstesZeichen .. TextSchleifenwert));
            
            if
              Sf.Graphics.Text.getLocalBounds (text => TextZugriff).width < Float (GrafikEinstellungen.FensterBreite - 2 * 5)
              and
                TextSchleifenwert = To_Wide_Wide_String (Source => AktuellerText)'Last
            then
               exit A;
               
            elsif
              Sf.Graphics.Text.getLocalBounds (text => TextZugriff).width >= Float (GrafikEinstellungen.FensterBreite - 2 * 5)
              and
                TextSchleifenwert < To_Wide_Wide_String (Source => AktuellerText)'Last
            then
               Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                             position => (5.00, XPosition));
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                                  text         => TextZugriff);
               XPosition := XPosition + ZeilenAbstand + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height;
               ErstesZeichen := TextSchleifenwert;
               LetztesZeichen := TextSchleifenwert;
               exit B;
               
            else
               LetztesZeichen := LetztesZeichen + 1;
            end if;
            
         end loop B;
      end loop A;
      
      Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                    position => (5.00, XPosition));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextZugriff);
      
   end WeiterenTextAnzeigen;
   
   
   
   procedure StringSetzen
     (WelcheZeileExtern : in Positive)
   is begin
      
      case
        WelchesMenü
      is
         when SystemDatentypen.Haupt_Menü =>
            AktuellerText := GlobaleTexte.Hauptmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Spiel_Menü =>
            AktuellerText := GlobaleTexte.Hauptmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Optionen_Menü =>
            AktuellerText := GlobaleTexte.Optionsmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Kartengröße_Menü =>
            AktuellerText := GlobaleTexte.Kartengröße (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenart_Menü =>
            AktuellerText := GlobaleTexte.Kartenart (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenform_Menü =>
            AktuellerText := GlobaleTexte.Kartenform (WelcheZeileExtern);
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            AktuellerText := GlobaleTexte.Kartentemperatur (WelcheZeileExtern);
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            AktuellerText := GlobaleTexte.Ressourcenmenge (WelcheZeileExtern);
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            AktuellerText := GlobaleTexte.Schwierigkeitsgrad (WelcheZeileExtern);
                        
         when SystemDatentypen.Rassen_Menü =>
            AktuellerText := GlobaleTexte.Rassenauswahl (WelcheZeileExtern);
            
         when SystemDatentypen.Grafik_Menü =>
            AktuellerText := GlobaleTexte.Grafikmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Sound_Menü =>
            AktuellerText := GlobaleTexte.Soundmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Sonstiges_Menü =>
            AktuellerText := GlobaleTexte.Sonstigesmenü (WelcheZeileExtern);
            
         when SystemDatentypen.Steuerung_Menü =>
            AktuellerText := GlobaleTexte.Steuerungmenü (WelcheZeileExtern);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      
   end StringSetzen;

      
   
   procedure Auswahl
   is begin
      
      AuswahlSchleife:
      loop
      
         AnzeigeMenüSFML;
      
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
