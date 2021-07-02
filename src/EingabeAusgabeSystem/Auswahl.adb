pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, GlobaleKonstanten;

with Anzeige, Eingabe;

package body Auswahl is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      EndeBestimmenSchleife:
      for LetztesEndeSchleifenwert in GlobaleVariablen.SprachenEinlesenArray'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleVariablen.SprachenEinlesen (LetztesEndeSchleifenwert)) = "|"
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := LetztesEndeSchleifenwert;
         end if;
         
      end loop EndeBestimmenSchleife;

      AktuelleAuswahl := 1;
      
      AuswahlSchleife:
      loop         

         Anzeige.AnzeigeSprache (AktuelleAuswahlExtern => AktuelleAuswahl,
                                 ErsteZeileExtern      => GlobaleVariablen.SprachenEinlesenArray'First,
                                 LetzteZeileExtern     => Ende);
         
         case
           Eingabe.Tastenwert
         is
            when 1 => 
               if
                 AktuelleAuswahl = GlobaleVariablen.SprachenEinlesenArray'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 3 =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := GlobaleVariablen.SprachenEinlesenArray'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 11 =>    
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return GlobaleVariablen.SprachenEinlesen (AktuelleAuswahl);
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop AuswahlSchleife;
      
   end AuswahlSprache;



   function Auswahl
     (FrageDateiExtern, TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      FrageZeileExtern, ErsteZeileExtern, LetzteZeileExtern : in Natural)
      return Integer
   is begin

      Anfang := ErsteZeileExtern;
      Ende := LetzteZeileExtern;
      AktuelleAuswahl := ErsteZeileExtern;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         Anzeige.AnzeigeMitAuswahlNeu (FrageDateiExtern      => FrageDateiExtern,
                                       TextDateiExtern       => TextDateiExtern,
                                       FrageZeileExtern      => FrageZeileExtern,
                                       ErsteZeileExtern      => ErsteZeileExtern,
                                       LetzteZeileExtern     => LetzteZeileExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahl);

         case
           Eingabe.Tastenwert
         is
            when 1 => 
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 3 =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 11 =>  
               -- Hauptmenü
               if
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 1)
               then
                  return GlobaleKonstanten.HauptmenüKonstante;
                  
                  -- Spiel beenden
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 2)
               then
                  return GlobaleKonstanten.SpielBeendenKonstante;
                  
                  -- Zurück
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 3)
               then
                  return GlobaleKonstanten.ZurückKonstante;
                  
                  -- Ja
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 4)
               then
                  return GlobaleKonstanten.JaKonstante;
                  
                  -- Nein
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 5)
               then
                  return GlobaleKonstanten.NeinKonstante;

                  -- Speichern
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 6)
               then
                  return GlobaleKonstanten.SpeichernKonstante;

                  -- Laden
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 7)
               then
                  return GlobaleKonstanten.LadenKonstante;

                  -- Optionen
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 8)
               then
                  return GlobaleKonstanten.OptionenKonstante;

                  -- Informationen
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 9)
               then
                  return GlobaleKonstanten.InformationenKonstante;

                  -- Wiederherstellen
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 10)
               then
                  return GlobaleKonstanten.WiederherstellenKonstante;

                  -- Würdigungen
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 11)
               then
                  return GlobaleKonstanten.WürdigungenKonstante;
                     
               else
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  return AktuelleAuswahl - ErsteZeileExtern + 1;
               end if;
                     
            when others =>
               null;
         end case;

      end loop AuswahlSchleife;
      
   end Auswahl;



   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return Integer
   is begin
      
      return Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                      TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                      FrageZeileExtern  => FrageZeileExtern,
                      ErsteZeileExtern  => GlobaleKonstanten.JaAnzeigeKonstante,
                      LetzteZeileExtern => GlobaleKonstanten.NeinAnzeigeKonstante);
      
   end AuswahlJaNein;

end Auswahl;
