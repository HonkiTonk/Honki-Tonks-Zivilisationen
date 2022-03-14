pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemKonstanten;
with TastenbelegungKonstanten;

with TextAnzeigeKonsole;
with Eingabe;

package body Auswahl is
   
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
            when TastenbelegungKonstanten.ObenKonstante =>
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungKonstanten.UntenKonstante =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungKonstanten.AuswählenKonstante =>
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



   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        FrageZeileExtern
      is
         when 1 =>
            null;
            
         when others =>
            null;
      end case;
      
      return SystemKonstanten.JaKonstante;
      
   end AuswahlJaNein;

end Auswahl;
