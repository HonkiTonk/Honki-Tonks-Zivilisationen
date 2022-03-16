pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

with AuswahlMenue;
with GrafikEinstellungenSFML;
with HintergrundSFML;
with AllgemeineTextBerechnungenSFML;
with InteraktionGrafiktask;

package body AnzeigeAuswahlMenueSFML is

   procedure AnzeigeAnfang
   is begin
      
      case
        InteraktionGrafiktask.AktuelleDarstellungAbrufen
      is
         when SystemDatentypen.Grafik_Menüs_Enum =>
            ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
            WelchesMenü := AuswahlMenue.WelchesMenü;
            Anfang := AuswahlMenue.Anfang;
            Ende := AuswahlMenue.Ende;
            AktuelleAuswahl := AuswahlMenue.AktuelleAuswahl;
            AnzeigeStartwert := AuswahlMenue.AnzeigeStartwert;
            
            Sf.Graphics.Text.setFont (text => TextAccess,
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            
            AnzeigeMenü;
            
         when others =>
            return;
      end case;
      
   end AnzeigeAnfang;
   
   
   
   procedure AnzeigeMenü
   is begin
      
      AktuellePosition := (0.00, 0.00);
      
      HintergrundSFML.HintergrundMenü (WelchesMenüExtern => WelchesMenü);
      Überschrift;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + ZeilenAbstand;
      
      AnzeigeSchleife:
      for TextSchleifenwert in Anfang .. Ende loop
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => AuswahlMenue.StringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                               WelchesMenüExtern => WelchesMenü));
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess,
                                                                                                  LinksRechtsExtern => False);
               
            when others =>
               AktuellePosition.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess,
                                                                                                  LinksRechtsExtern => True);
         end case;
         
         Sf.Graphics.Text.setPosition (text     => TextAccess,
                                       position => AktuellePosition);
         
         AnzeigeFarbeBestimmen (TextZeileExtern => TextSchleifenwert);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess);
         
         case
           (TextSchleifenwert + AnzeigeStartwert) mod 2
         is
            when 0 =>
               null;
               
            when others =>
               AktuellePosition.y := AktuellePosition.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + ZeilenAbstand;
         end case;
         
      end loop AnzeigeSchleife;
      
      WeiterenTextAnzeigen;
      
   end AnzeigeMenü;
   
   
   
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
        WelchesMenü = SystemDatentypen.Rassen_Menü_Enum
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
                  when SystemDatentypen.Spieler_Mensch_Enum =>
                     AktuelleFarbe := Sf.Graphics.Color.sfBlue;
                     
                  when SystemDatentypen.Spieler_KI_Enum =>
                     AktuelleFarbe := Sf.Graphics.Color.sfYellow;
                     
                  when SystemDatentypen.Leer_Spieler_Enum =>
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
      
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => AktuelleFarbe);
      
   end AnzeigeFarbeBestimmen;
   
   
   
   procedure Überschrift
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => AuswahlMenue.StringSetzen (WelcheZeileExtern => 1,
                                                                            WelchesMenüExtern => WelchesMenü));
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      AktuellePosition := (AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess), StartPositionYAchse);
      
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => AktuellePosition);
      AnzeigeFarbeBestimmen (TextZeileExtern => 1);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end Überschrift;
   
   
   
   procedure WeiterenTextAnzeigen
   is begin
            
      AktuellerText := To_Unbounded_Wide_Wide_String (Source => AuswahlMenue.StringSetzen (WelcheZeileExtern => AktuelleAuswahl + 1 + (Ende - Anfang),
                                                                                           WelchesMenüExtern => WelchesMenü));
      
      if
        AktuellerText = SystemKonstanten.LeerString
      then
         return;
         
      else
         null;
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => AktuellerText));
      Sf.Graphics.Text.setColor (text  => TextAccess,
                                 color => Sf.Graphics.Color.sfWhite);
      ErstesZeichen := 1;
      YPosition := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y - GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 5);
      
      TextSchleife:
      loop
         ZeichenSchleife:
         for TextSchleifenwert in ErstesZeichen .. To_Wide_Wide_String (Source => AktuellerText)'Last loop
            
            Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                               str  => To_Wide_Wide_String (Source => AktuellerText) (ErstesZeichen .. TextSchleifenwert));
            
            if
              Sf.Graphics.Text.getLocalBounds (text => TextAccess).width < Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) - 2.00 * StartPositionYAchse
              and
                TextSchleifenwert < To_Wide_Wide_String (Source => AktuellerText)'Last
            then
               null;
               
            elsif
              TextSchleifenwert = To_Wide_Wide_String (Source => AktuellerText)'Last
            then
               exit TextSchleife;
               
            else
               Sf.Graphics.Text.setPosition (text     => TextAccess,
                                             position => (StartPositionXAchse, YPosition));
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess);
               YPosition := YPosition + ZeilenAbstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
               ErstesZeichen := TextSchleifenwert + 1;
               exit ZeichenSchleife;
            end if;
            
         end loop ZeichenSchleife;
      end loop TextSchleife;
      
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => (StartPositionXAchse, YPosition));
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end WeiterenTextAnzeigen;

end AnzeigeAuswahlMenueSFML;
