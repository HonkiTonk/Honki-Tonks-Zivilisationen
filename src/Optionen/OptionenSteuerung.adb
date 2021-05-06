pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen, GlobaleKonstanten;

with Eingabe, Auswahl, Anzeige, Schreiben;

package body OptionenSteuerung is

   function SteuerungBelegen
     return Integer
   is begin
      
      BelegungSchleife:
      loop
         
         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Fragen,
                                         TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeileExtern  => 28,
                                         ErsteZeileExtern  => 21,
                                         LetzteZeileExtern => 62);
         
         case
           AuswahlWert
         is
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante | GlobaleKonstanten.ZurückKonstante =>
               return AuswahlWert;
               
            when GlobaleKonstanten.SpeichernKonstante =>
               Schreiben.TastenbelegungSchreiben;
                     
            when others =>
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 46,
                                              LetzteZeileExtern      => 46,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);
               
               Put_Line (Eingabe.Tastenbelegung (1, AuswahlWert) & "    " & Eingabe.Tastenbelegung (2, AuswahlWert));
               
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
                     then
                        Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := NUL;
                        exit BelegungFeldSchleife;
               
                     else
                        null;
                     end if;
            
                  end loop BelegungPositionSchleife;
               end loop BelegungFeldSchleife;
         end case;
         
         Eingabe.Tastenbelegung (2, AuswahlWert) := Eingabe.Tastenbelegung (1, AuswahlWert);
         Eingabe.Tastenbelegung (1, AuswahlWert) := NeueTaste;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;

end OptionenSteuerung;
