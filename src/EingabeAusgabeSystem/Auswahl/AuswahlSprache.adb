pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with Sf.Graphics.RenderWindow;

with GlobaleVariablen;
with GlobaleTexte;
with SystemKonstanten;

with Eingabe;
with GrafikAllgemein;
with GrafikEinstellungen;

package body AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      ZeilenAbstand := 1.25 * Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      
      SprachenListeFestlegen;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return AuswahlSpracheKonsole;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return AuswahlSpracheSFML (AnzeigeArtExtern => GlobaleVariablen.AnzeigeArt);
      end case;
      
   end AuswahlSprache;
   
   
   
   procedure SprachenListeFestlegen
   is begin
      
      AktuelleAuswahl := AktuelleSprachenArray'First;
      
      if
        ZehnerReihe * 10 < GlobaleTexte.SprachenEinlesenArray'Last
      then
         ZehnerReihe := ZehnerReihe + 1;
         
      else
         ZehnerReihe := 1;
      end if;
         
      if
        GlobaleTexte.SprachenEinlesen (ZehnerReihe * 10 - 9) = SystemKonstanten.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      AktuelleSprachen := (others => SystemKonstanten.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = GlobaleTexte.SprachenEinlesenArray'First
           and
             GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = SystemKonstanten.LeerUnboundedString
         then
            raise Program_Error;
            
         elsif
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = SystemKonstanten.LeerUnboundedString
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := EndeSchleifenwert - ((ZehnerReihe - 1) * 10);
         end if;
         
         AktuelleSprachen (EndeSchleifenwert - ((ZehnerReihe - 1) * 10)) := GlobaleTexte.SprachenEinlesen (EndeSchleifenwert);
         
      end loop EndeBestimmenSchleife;
      
      MehrSprachenVorhandenSchleife:
      for SprachenSchleifenwert in GlobaleTexte.SprachenEinlesenArray'Range loop
         
         if
           SprachenSchleifenwert <= AktuelleSprachenArray'Last
           and
             GlobaleTexte.SprachenEinlesen (SprachenSchleifenwert) = SystemKonstanten.LeerUnboundedString
         then
            return;
            
         elsif
           SprachenSchleifenwert >= AktuelleSprachenArray'Last
         then
            exit MehrSprachenVorhandenSchleife;
            
         else
            null;
         end if;
            
      end loop MehrSprachenVorhandenSchleife;
      
      Ende := Ende + 1;
      AktuelleSprachen (Ende) := MehrSprachen;
      
   end SprachenListeFestlegen;
   
   
   
   function AuswahlSpracheKonsole
     return Unbounded_Wide_Wide_String
   is begin
      
      AuswahlKonsoleSchleife:
      loop

         AnzeigeSpracheKonsole (AktuelleAuswahlExtern => AktuelleAuswahl,
                                LetzteZeileExtern     => Ende);
         
         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben | SystemDatentypen.Ebene_Hoch =>
               if
                 AktuelleAuswahl = AktuelleSprachen'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten | SystemDatentypen.Ebene_Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := AktuelleSprachen'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when SystemDatentypen.Auswählen =>
               if
                 AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
               then
                  SprachenListeFestlegen;
                  
               else
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
                     
            when others =>
               null;
         end case;
               
      end loop AuswahlKonsoleSchleife;
      
   end AuswahlSpracheKonsole;
   
   
   
   function AuswahlSpracheSFML
     (AnzeigeArtExtern : in SystemDatentypen.Anzeige_Art_Grafik_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      TextZugriff := GrafikEinstellungen.TextStandard;
      
      AuswahlSFMLSchleife:
      loop
         
         AnzeigeSpracheSFML (AktuelleAuswahlExtern => AktuelleAuswahl,
                             LetzteZeileExtern     => Ende);
         
         case
           AnzeigeArtExtern
         is
            when SystemDatentypen.SFML =>
               null;
            
            when SystemDatentypen.Beides =>
               AnzeigeSpracheKonsole (AktuelleAuswahlExtern => AktuelleAuswahl,
                                      LetzteZeileExtern     => Ende);
         end case;
         
         if
           AuswahlMausTastatur = SystemKonstanten.LeerUnboundedString
         then
            null;
            
         else
            return AktuelleSprachen (AktuelleAuswahl);
         end if;
         
      end loop AuswahlSFMLSchleife;
      
   end AuswahlSpracheSFML;
   
   
   
   function AuswahlMausTastatur
     return Unbounded_Wide_Wide_String
   is begin
            
      case
        Eingabe.Tastenwert
      is
         when SystemDatentypen.Oben | SystemDatentypen.Ebene_Hoch =>
            if
              AktuelleAuswahl = AktuelleSprachen'First
            then
               AktuelleAuswahl := Ende;
                  
            else
               AktuelleAuswahl := AktuelleAuswahl - 1;
            end if;

         when SystemDatentypen.Unten | SystemDatentypen.Ebene_Runter =>
            if
              AktuelleAuswahl = Ende
            then
               AktuelleAuswahl := AktuelleSprachen'First;
                  
            else
               AktuelleAuswahl := AktuelleAuswahl + 1;
            end if;
                              
         when SystemDatentypen.Auswählen =>
            if
              AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
            then
               SprachenListeFestlegen;
                  
            else
               return AktuelleSprachen (AktuelleAuswahl);
            end if;
            
         when SystemDatentypen.Mausbewegung =>
            MausAuswahl;
                     
         when others =>
            null;
      end case;
            
      return SystemKonstanten.LeerUnboundedString;
      
   end AuswahlMausTastatur;
   
   
   
   procedure MausAuswahl
   is begin
      
      TextPositionMaus := StartPositionYAchse;
      MausZeigerPosition := Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster);
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                            str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus)
             .. Sf.sfInt32 (TextPositionMaus + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height)
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            TextPositionMaus := TextPositionMaus + Sf.Graphics.Text.getLocalBounds (text => TextZugriff).height + ZeilenAbstand;
         end if;
         
      end loop MausZeigerSchleife;
      
   end MausAuswahl;

   

   procedure AnzeigeSpracheKonsole
     (AktuelleAuswahlExtern : in Positive;
      LetzteZeileExtern : in Positive)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => AktuelleSprachen (ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachenArray'First .. LetzteZeileExtern loop

         if
           AktuelleAuswahlExtern = ZeileSchleifenwert
         then
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if
                 TextlängeEins = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 TextlängeEins = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenTeilEinsSchleife;

            RahmenTeilZweiSchleife:
            for TextlängeZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 TextlängeZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenTeilZweiSchleife;
         
         else
            Put_Line (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSpracheKonsole;
   
   
   
   procedure AnzeigeSpracheSFML
     (AktuelleAuswahlExtern : in Positive;
      LetzteZeileExtern : in Positive)
   is begin
      
      GrafikAllgemein.FensterLeeren;
      Zeile := 0.00;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. LetzteZeileExtern loop
         
         if
           AktuelleAuswahlExtern = ZeileSchleifenwert
         then
            AktuelleTextFarbe := Sf.Graphics.Color.sfGreen;
            
         else
            AktuelleTextFarbe := Sf.Graphics.Color.sfWhite;
         end if;
         
         Sf.Graphics.Text.setUnicodeString (text => TextZugriff,
                                            str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
         Sf.Graphics.Text.setPosition (text     => TextZugriff,
                                       position => ((Float (GrafikEinstellungen.FensterEinstellungen.FensterBreite) / 2.00 - Sf.Graphics.Text.getLocalBounds (text => TextZugriff).width / 2.00),
                                                    StartPositionYAchse + ZeilenAbstand * Zeile));
         Sf.Graphics.Text.setColor (text  => TextZugriff,
                                    color => AktuelleTextFarbe);
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => TextZugriff);
         
         Zeile := Zeile + 1.00;
         
      end loop AnzeigeSchleife;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeSpracheSFML;

end AuswahlSprache;
