pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;
with Ada.Integer_Wide_Wide_Text_IO;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf;
with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with SystemKonstanten;
with GlobaleVariablen;

with Anzeige;
with EingabeSFML;
with GrafikAllgemein;
with GrafikEinstellungen;

package body Eingabe is

   function GanzeZahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return Integer
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole | SystemDatentypen.Beides =>
            null;
            
         when SystemDatentypen.SFML =>
            null;
      end case;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            null;
            
         when SystemDatentypen.Konsole =>
            null;
      end case;
      
      MaximalerWert := MaximumErmitteln (ZahlenMaximumExtern => ZahlenMaximumExtern);
      MinimalerWert := MinimumErmitteln (ZahlenMinimumExtern => ZahlenMinimumExtern);
      
      if
        ZahlenMinimumExtern >= ZahlenMaximumExtern
      then
         return SystemKonstanten.GanzeZahlAbbruchKonstante;
         
      else
         ZahlenString := ("000000000");
         WelchesVorzeichen := True;
      end if;

      ZahlenAußenSchleife:
      loop
                  
         case
           ZahlSchleife (TextDateiExtern     => TextDateiExtern,
                         ZeileExtern         => ZeileExtern,
                         ZahlenMinimumExtern => MinimalerWert,
                         ZahlenMaximumExtern => MaximalerWert)
         is
            when 2 =>
               exit ZahlenAußenSchleife;
               
            when -1 =>
               return SystemKonstanten.GanzeZahlAbbruchKonstante;
                        
            when others =>
               null;
         end case;
               
      end loop ZahlenAußenSchleife;

      case
        WelchesVorzeichen
      is
         when True =>
            return Integer'Wide_Wide_Value (ZahlenString);
                  
         when False =>
            return -Integer'Wide_Wide_Value (ZahlenString);
      end case;
      
      
   end GanzeZahl;
   
   
   
   function MaximumErmitteln
     (ZahlenMaximumExtern : in Integer)
      return Integer
   is begin
      
      if
        ZahlenMaximumExtern > ZahlenMaximum
      then
         return ZahlenMaximum;
         
      elsif
        ZahlenMaximumExtern < ZahlenMinimum
      then
         return SystemKonstanten.GanzeZahlAbbruchKonstante;
         
      else
         return ZahlenMaximumExtern;
      end if;
      
   end MaximumErmitteln;
   
   
   
   function MinimumErmitteln
     (ZahlenMinimumExtern : in Integer)
      return Integer
   is begin
      
      if
        ZahlenMinimumExtern < ZahlenMinimum
      then
         return ZahlenMinimum;
           
      elsif
        ZahlenMinimumExtern > ZahlenMaximum
      then
         return SystemKonstanten.GanzeZahlAbbruchKonstante;
           
      else
         return ZahlenMinimumExtern;
      end if;
      
   end MinimumErmitteln;



   function ZahlSchleife
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return KartenDatentypen.LoopRangeMinusZweiZuZwei
   is begin
      
      ZahlenSchleife:
      loop

         ZahlenAnzeige (TextDateiExtern     => TextDateiExtern,
                        ZeileExtern         => ZeileExtern,
                        ZahlenMinimumExtern => ZahlenMinimumExtern);
         
         Zahlen := EingabeSFML.TastenEingabe;
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         -- 1 = 0 bis 9 als Zahl, -1 = q (Eingabe verlassen), -2 = DEL (Letzte Ziffer löschen), 2 = e/Enter (Eingabe bestätigen), sonst 0.
         case
           GanzeZahlPrüfung (ZeichenExtern => Zahlen)
         is
            when 1 =>
               ZahlHinzufügen (ZahlenMaximumExtern   => ZahlenMaximumExtern,
                                EingegebeneZahlExtern => Zahlen);

            when -1 =>
               return -1;

            when 2 =>
               if
                 -Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimumExtern
                 and
                   WelchesVorzeichen = False
               then
                  return 2;
                  
               elsif
                 Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimumExtern
               then
                  return 2;
                     
               else
                  if
                    ZahlenMinimumExtern <= -100_000_000
                  then
                     ZahlenMinimumPlusmacher := -ZahlenMinimumExtern;
                     ZahlenString := ZahlenMinimumPlusmacher'Wide_Wide_Image;
                     WelchesVorzeichen := False;
                     
                  else
                     MinimumMaximumSetzen (ZahlenMinimumMaximumExtern => -ZahlenMinimumExtern);
                  end if;
               end if;

            when -2 =>
               ZahlEntfernen;
                  
            when others =>
               null;
         end case;

      end loop ZahlenSchleife;
      
   end ZahlSchleife;
   
   
   
   procedure ZahlHinzufügen
     (ZahlenMaximumExtern : in Integer;
      EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      ZahlenNachLinksVerschiebenSchleife:
      for ZahlEinsSchleifenwert in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (ZahlEinsSchleifenwert - 1) := ZahlenString (ZahlEinsSchleifenwert);

      end loop ZahlenNachLinksVerschiebenSchleife;
      ZahlenString (ZahlenString'Last) := EingabeZahlenUmwandeln (EingegebeneZahlExtern);

      if
        Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximumExtern
      then
         null;
                  
      elsif
        ZahlenMaximumExtern >= 100_000_000
      then
         ZahlenString := ZahlenMaximumExtern'Wide_Wide_Image;
                       
      else
         MinimumMaximumSetzen (ZahlenMinimumMaximumExtern => ZahlenMaximumExtern);
      end if;
      
   end ZahlHinzufügen;
   
   
   
   procedure ZahlEntfernen
   is begin
      
      ZahlenNachRechtsVerschiebenSchleifeZwei:
      for ZahlDreiSchleifenwert in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (ZahlDreiSchleifenwert) := ZahlenString (ZahlDreiSchleifenwert - 1);

      end loop ZahlenNachRechtsVerschiebenSchleifeZwei;
      ZahlenString (1) := '0';
      
   end ZahlEntfernen;
   
   
   
   procedure ZahlenAnzeige
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer)
   is begin
      
      -- Das Leeren und Befüllen des Fenster hier funktioniert so nicht richtig, weil damit z. B. keine Überschrift möglich ist.
      GrafikAllgemein.FensterLeeren;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => TextDateiExtern,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => ZeileExtern,
                                     LetzteZeileExtern      => ZeileExtern,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);

      if
        ZahlenMinimumExtern > 0
        and
          Integer'Wide_Wide_Value (ZahlenString) = 0
      then
         null;
            
      elsif
        ZahlenMinimumExtern >= 0
        and
          WelchesVorzeichen = False
      then
         WelchesVorzeichen := True;
         Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer'Wide_Wide_Value (ZahlenString),
                                            Width => 1,
                                            Base  => 10);
         
         Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                            str  => ZahlenString);
         Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
                                       position => (10.00, 10.00));
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => GrafikEinstellungen.TextStandard);
            
      else
         if
           WelchesVorzeichen
         then
            null;

         elsif
           WelchesVorzeichen = False
           and
             Integer'Wide_Wide_Value (ZahlenString) = 0
         then
            null;
                  
         else
            Put (Item => "-");
            Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                               str  => "-");
            Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
                                          position => (10.00, 10.00));
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                               text         => GrafikEinstellungen.TextStandard);
         end if;
         Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer'Wide_Wide_Value (ZahlenString),
                                            Width => 1,
                                            Base  => 10);
         
         Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                            str  => ZahlenString);
         Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
                                       position => (10.00, 10.00));
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                            text         => GrafikEinstellungen.TextStandard);
      end if;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end ZahlenAnzeige;



   -- 1 = 0 bis 9 als Zahl, -1 = q (Eingabe verlassen), -2 = DEL (Letzte Ziffer löschen), 2 = e/Enter (Eingabe bestätigen), sonst 0.
   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return KartenDatentypen.LoopRangeMinusDreiZuDrei
   is begin
      
      case
        ZeichenExtern
      is
         when Sf.Window.Keyboard.sfKeyNum0 | Sf.Window.Keyboard.sfKeyNum1 | Sf.Window.Keyboard.sfKeyNum2 | Sf.Window.Keyboard.sfKeyNum3 | Sf.Window.Keyboard.sfKeyNum4 | Sf.Window.Keyboard.sfKeyNum5
            | Sf.Window.Keyboard.sfKeyNum6 | Sf.Window.Keyboard.sfKeyNum7 | Sf.Window.Keyboard.sfKeyNum8 | Sf.Window.Keyboard.sfKeyNum9 =>
            return 1;
            
         when Sf.Window.Keyboard.sfKeyQ | Sf.Window.Keyboard.sfKeyEscape =>
            return -1;

         when Sf.Window.Keyboard.sfKeyDelete | Sf.Window.Keyboard.sfKeyBack =>
            return -2;

         when Sf.Window.Keyboard.sfKeyE | Sf.Window.Keyboard.sfKeyEnter =>
            return 2;

         when Sf.Window.Keyboard.sfKeySubtract =>
            WelchesVorzeichen := False;
            return 3;
            
         when Sf.Window.Keyboard.sfKeyAdd =>
            WelchesVorzeichen := True;
            return 3;
            
         when others =>
            return 0;
      end case;
      
   end GanzeZahlPrüfung;
   
   
   
   procedure MinimumMaximumSetzen
     (ZahlenMinimumMaximumExtern : in Integer)
   is begin
      
      MaximumMinimum := To_Unbounded_Wide_Wide_String (Source => ZahlenMinimumMaximumExtern'Wide_Wide_Image);
      MaximumMinimumAktuelleStelle := To_Wide_Wide_String (Source => MaximumMinimum)'Length;
      
      MaximumSchleife:
      for MaximumSchleifenwert in reverse ZahlenString'Range loop
         
         if
           MaximumSchleifenwert > ZahlenString'Length - To_Wide_Wide_String (Source => MaximumMinimum)'Length + 1
         then
            ZahlenString (MaximumSchleifenwert) := To_Wide_Wide_String (Source => MaximumMinimum) (MaximumMinimumAktuelleStelle);
            MaximumMinimumAktuelleStelle := MaximumMinimumAktuelleStelle - 1;
            
         else
            ZahlenString (MaximumSchleifenwert) := '0';
         end if;
         
      end loop MaximumSchleife;
      
   end MinimumMaximumSetzen;
   
   
   
   function NameEingeben
     return Unbounded_Wide_Wide_String
   is begin
      
      return To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
   end NameEingeben;

   

   function StadtName
     return Unbounded_Wide_Wide_String
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                            TextZeileExtern => 32);
      
      return NameEingeben;
      
   end StadtName;



   function SpielstandName
     return Unbounded_Wide_Wide_String
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                            TextZeileExtern => 22);

      Name := NameEingeben;

      case
        To_Wide_Wide_String (Source => Name)'Length
      is
         when 0 =>
            -- Später noch durch eine Prüfung ersetzen ob das ein nicht leerer Name ist?
            return To_Unbounded_Wide_Wide_String (Source => "Kein Name");
              
         when others =>
            return Name;
      end case;
      
   end SpielstandName;



   procedure WartenEingabe
   is begin
      
      New_Line;
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                            TextZeileExtern => 47);
      Taste := EingabeSFML.TastenEingabe;
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole | SystemDatentypen.Beides =>
            null;
            
         when SystemDatentypen.SFML =>
            null;
      end case;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            Taste := EingabeSFML.TastenEingabe;
      
            BelegungFeldSchleife:
            for BelegungFeldSchleifenwert in TastenbelegungArray'Range (1) loop
               BelegungPositionSchleife:
               for BelegungPositionSchleifenwert in TastenbelegungArray'Range (2) loop
            
                  if
                    Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = Taste
                  then
                     return BelegungPositionSchleifenwert;
               
                  else
                     null;
                  end if;
            
               end loop BelegungPositionSchleife;
            end loop BelegungFeldSchleife;
            
         when SystemDatentypen.Konsole =>
            null;
      end case;
      
      return SystemDatentypen.Leer;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      Tastenbelegung := TastenbelegungStandard;
      
   end StandardTastenbelegungLaden;

end Eingabe;
