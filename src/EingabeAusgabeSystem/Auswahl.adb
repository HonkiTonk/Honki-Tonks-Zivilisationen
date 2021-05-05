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
         
         Taste := Eingabe.TastenEingabe;
         
         case
           Taste
         is
            when 'w' | '8' => 
               if
                 AktuelleAuswahl = GlobaleVariablen.SprachenEinlesenArray'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := GlobaleVariablen.SprachenEinlesenArray'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>    
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

         Taste := Eingabe.TastenEingabe;
         
         case
           Taste
         is
            when 'w' | '8' => 
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>                  
               if
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 1)
               then -- Hauptmenü
                  return GlobaleKonstanten.HauptmenüKonstante;
                  
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 2)
               then -- Spiel beenden
                  return GlobaleKonstanten.SpielBeendenKonstante;
                  
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 3)
               then -- Zurück
                  return GlobaleKonstanten.ZurückKonstante;
                  
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 4)
               then -- Ja
                  return GlobaleKonstanten.JaKonstante;
                  
               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 5)
               then -- Nein
                  return GlobaleKonstanten.NeinKonstante;

               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 6)
               then -- Speichern
                  return GlobaleKonstanten.SpeichernKonstante;

               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 7)
               then -- Laden
                  return GlobaleKonstanten.LadenKonstante;

               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 8)
               then -- Optionen
                  return GlobaleKonstanten.OptionenKonstante;

               elsif
                 GlobaleVariablen.TexteEinlesenNeu (GlobaleDatentypen.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleVariablen.TexteEinlesenNeu (2, 9)
               then -- Informationen
                  return GlobaleKonstanten.InformationenKonstante;
                     
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

      JaNein := Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                         TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                         FrageZeileExtern  => FrageZeileExtern,
                         ErsteZeileExtern  => GlobaleKonstanten.JaAnzeigeKonstante,
                         LetzteZeileExtern => GlobaleKonstanten.NeinAnzeigeKonstante);
      
      return JaNein;
      
   end AuswahlJaNein;

end Auswahl;
