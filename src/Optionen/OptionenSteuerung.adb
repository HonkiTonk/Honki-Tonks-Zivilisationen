pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with Eingabe, Auswahl, Anzeige, SchreibenTastatur;

package body OptionenSteuerung is

   function SteuerungBelegen
     return Integer
   is begin
      
      BelegungSchleife:
      loop
         
         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                         TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeileExtern  => 28,
                                         ErsteZeileExtern  => 22,
                                         LetzteZeileExtern => 64);
         
         case
           AuswahlWert
         is
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante | GlobaleKonstanten.ZurückKonstante =>
               return AuswahlWert;
               
            when GlobaleKonstanten.SpeichernKonstante =>
               SchreibenTastatur.TastenbelegungSchreiben;
               
            when GlobaleKonstanten.WiederherstellenKonstante =>
               Eingabe.StandardTastenbelegungWiederherstellen;
               SchreibenTastatur.TastenbelegungSchreiben;
                     
            when others =>
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 46,
                                              LetzteZeileExtern      => 46,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);
               
               NeueAuswahl := GlobaleDatentypen.Tastenbelegung_Enum'Val (AuswahlWert);
               
               Put_Line (Eingabe.Tastenbelegung (1, NeueAuswahl) & "    " & Eingabe.Tastenbelegung (2, NeueAuswahl));
               
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Fragen,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 29,
                                              LetzteZeileExtern      => 29,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);
               
               NeueTaste := Eingabe.TastenEingabe;
               
               BelegungFeldSchleife:
               for BelegungFeldSchleifenwert in Eingabe.TastenbelegungArray'Range (1) loop
                  BelegungPositionSchleife:
                  for BelegungPositionSchleifenwert in Eingabe.TastenbelegungArray'Range (2) loop
            
                     if
                       Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = NeueTaste
                       and
                         BelegungPositionSchleifenwert /= NeueAuswahl
                     then
                        Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := NUL;
                        exit BelegungFeldSchleife;
               
                     else
                        null;
                     end if;
            
                  end loop BelegungPositionSchleife;
               end loop BelegungFeldSchleife;
         end case;
         
         NeueAuswahl := GlobaleDatentypen.Tastenbelegung_Enum'Val (AuswahlWert);
         
         if
           Eingabe.Tastenbelegung (1, NeueAuswahl) = NeueTaste
           or
             Eingabe.Tastenbelegung (2, NeueAuswahl) = NeueTaste
         then
            null;
            
         elsif
           Eingabe.Tastenbelegung (1, NeueAuswahl) = NUL
         then
            Eingabe.Tastenbelegung (1, NeueAuswahl) := NeueTaste;
            
         elsif
           Eingabe.Tastenbelegung (2, NeueAuswahl) = NUL
         then
            Eingabe.Tastenbelegung (2, NeueAuswahl) := NeueTaste;
            
         else
            Eingabe.Tastenbelegung (2, NeueAuswahl) := Eingabe.Tastenbelegung (1, NeueAuswahl);
            Eingabe.Tastenbelegung (1, NeueAuswahl) := NeueTaste;
         end if;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;

end OptionenSteuerung;
