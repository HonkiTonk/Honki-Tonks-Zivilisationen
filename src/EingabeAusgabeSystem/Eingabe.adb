pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Integer_Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with Anzeige;

package body Eingabe is 

   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function GanzeZahl (TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ZeileExtern : in Positive; ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer) return Integer is
   begin
      
      ZahlenString := ("000000000");
      WelchesVorzeichen := True;

      ZahlenAußenSchleife:
      loop         
         
         SchleifeVerlassen := ZahlSchleife (TextDateiExtern     => TextDateiExtern,
                                            ZeileExtern         => ZeileExtern,
                                            ZahlenMinimumExtern => ZahlenMinimumExtern,
                                            ZahlenMaximumExtern => ZahlenMaximumExtern);
         
         case SchleifeVerlassen is
            when 2 =>
               exit ZahlenAußenSchleife;
               
            when -1 =>
               return GlobaleKonstanten.GanzeZahlAbbruchKonstante;
                        
            when others =>
               null;
         end case;
               
      end loop ZahlenAußenSchleife;

      case WelchesVorzeichen is
         when True =>
            return Integer'Wide_Wide_Value (ZahlenString);
                  
         when False =>
            return -Integer'Wide_Wide_Value (ZahlenString);
      end case; 
      
      
   end GanzeZahl;



   function ZahlSchleife (TextDateiExtern : in GlobaleDatentypen.WelcheDatei_Enum; ZeileExtern : in Positive; ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei is
   begin

      ZahlenSchleife: -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen) = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
      loop

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                        TextDateiExtern        => TextDateiExtern,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => ZeileExtern,
                                        LetzteZeileExtern      => ZeileExtern,
                                        AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                        AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                        AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);

         if ZahlenMinimumExtern > 0 and Integer'Wide_Wide_Value (ZahlenString) = 0 then
            null;
            
         elsif ZahlenMinimumExtern >= 0 and WelchesVorzeichen = False then
            WelchesVorzeichen := True;
            Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer'Wide_Wide_Value (ZahlenString),
                                               Width => 1,
                                               Base  => 10);
            
         else
            if WelchesVorzeichen = True then
               null;

            elsif WelchesVorzeichen = False and Integer'Wide_Wide_Value (ZahlenString) = 0 then
               null;
                  
            else
               Put (Item => "-");
            end if;
            Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer'Wide_Wide_Value (ZahlenString),
                                               Width => 1,
                                               Base  => 10);
         end if;
            
         Get_Immediate (Item => Zahlen);
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         IstZahl := GanzeZahlPrüfung (ZeichenExtern => Zahlen);
         case IstZahl is
            when 1 =>
               ZahlenNachLinksVerschiebenSchleife:
               for ZahlEinsSchleifenwert in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                  ZahlenString (ZahlEinsSchleifenwert - 1) := ZahlenString (ZahlEinsSchleifenwert);

               end loop ZahlenNachLinksVerschiebenSchleife;
               ZahlenString (ZahlenString'Last) := Zahlen;

               if Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximumExtern then
                  null;
                  
               else -- Einfach auf ZahlenMaximumExtern setzen
                  ZahlenNachRechtsVerschiebenSchleife:
                  for ZahlZweiSchleifenwert in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                     ZahlenString (ZahlZweiSchleifenwert) := ZahlenString (ZahlZweiSchleifenwert - 1);

                  end loop ZahlenNachRechtsVerschiebenSchleife;
                  ZahlenString (1) := '0';
               end if;

            when -1 =>
               return -1;

            when 2 =>
               if -Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimumExtern and WelchesVorzeichen = False then
                  return 2;
                  
               elsif Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimumExtern then
                  return 2;
                     
               else -- Einfach auf ZahlenMinimumExtern setzen
                  null;
               end if;

            when -2 =>
               ZahlenNachRechtsVerschiebenSchleifeZwei:
               for ZahlDreiSchleifenwert in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                  ZahlenString (ZahlDreiSchleifenwert) := ZahlenString (ZahlDreiSchleifenwert - 1);

               end loop ZahlenNachRechtsVerschiebenSchleifeZwei;
               ZahlenString (1) := '0';
                  
            when others =>
               null;
         end case;

      end loop ZahlenSchleife;
      
   end ZahlSchleife;



   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function GanzeZahlPrüfung (ZeichenExtern : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusDreiZuDrei is
   begin
      
      case ZeichenExtern is
         when '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' =>            
            return 1;
            
         when 'q' | 'Q' =>
            return -1;

         when DEL =>
            return -2;

         when 'e' | 'E' =>
            return 2;

         when '-' =>
            WelchesVorzeichen := False;
            return 3;
            
         when '+' =>
            WelchesVorzeichen := True;
            return 3;
            
         when others =>
            return 0;
      end case;
      
   end GanzeZahlPrüfung;

   

   function StadtName return Unbounded_Wide_Wide_String is
   begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                            TextZeileExtern => 32);

      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
      return Name;
      
   end StadtName;



   function SpielstandName return Unbounded_Wide_Wide_String is
   begin            
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fragen,
                                            TextZeileExtern => 22);

      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);

      case To_Wide_Wide_String (Source => Name)'Length is
         when 0 =>
            return To_Unbounded_Wide_Wide_String (Source => "Kein Name"); -- Später noch durch eine Prüfung ersetzen ob das ein nicht leerer Name ist.
              
         when others =>
            return Name;
      end case;
      
   end SpielstandName;



   function TastenEingabe return Integer is
   begin

      Get_Immediate (Taste);
      
      return 1;
      
   end TastenEingabe;

end Eingabe;
