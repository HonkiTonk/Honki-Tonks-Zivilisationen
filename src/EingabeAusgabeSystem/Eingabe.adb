pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Integer_Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with Anzeige;

package body Eingabe is 

   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function GanzeZahl (WelcheDatei, WelcherText : in Natural; ZahlenMinimum, ZahlenMaximum : Integer) return Integer is
   begin
      
      ZahlenString := ("000000000");
      WelchesVorzeichen := True;

      ZahlenAußenSchleife:
      loop
         
         Test := ZahlSchleife (WelcheDatei   => WelcheDatei,
                               WelcherText   => WelcherText,
                               ZahlenMinimum => ZahlenMinimum,
                               ZahlenMaximum => ZahlenMaximum);
                       
         case Test is
            when 2 =>
               exit ZahlenAußenSchleife;
               
            when -1 =>
               return -1_000_000_000;
                        
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



   function ZahlSchleife (WelcheDatei, WelcherText : in Natural; ZahlenMinimum, ZahlenMaximum : Integer) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei is
   begin

      ZahlenSchleife: -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen) = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
      loop

         -- Hier die einzugebenden Zahlen als Meldung ausgeben.

         if ZahlenMinimum > 0 and Integer'Wide_Wide_Value (ZahlenString) = 0 then
            null;
            
         elsif ZahlenMinimum >= 0 and WelchesVorzeichen = False then
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
         IstZahl := GanzeZahlPrüfung (Zeichen => Zahlen);
         case IstZahl is
            when 1 =>
               ZahlenNachLinksVerschiebenSchleife:
               for Zahl in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                  ZahlenString (Zahl - 1) := ZahlenString (Zahl);

               end loop ZahlenNachLinksVerschiebenSchleife;
               ZahlenString (ZahlenString'Last) := Zahlen;

               if Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximum then
                  null;
                  
               else -- Hier noch eine Fehlermeldung einbauen
                  ZahlenNachRechtsVerschiebenSchleife:
                  for Zahl in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                     ZahlenString (Zahl) := ZahlenString (Zahl - 1);

                  end loop ZahlenNachRechtsVerschiebenSchleife;
                  ZahlenString (1) := '0';
               end if;

            when -1 =>
               return -1;

            when 2 =>
               if -Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum and WelchesVorzeichen = False then
                  return 2;
                  
               elsif Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum then
                  return 2;
                     
               else -- Hier noch eine Fehlermeldung einbauen
                  null;
               end if;

            when -2 =>
               ZahlenNachRechtsVerschiebenSchleifeZwei:
               for Zahl in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                  ZahlenString (Zahl) := ZahlenString (Zahl - 1);

               end loop ZahlenNachRechtsVerschiebenSchleifeZwei;
               ZahlenString (1) := '0';
                  
            when others =>
               null;
         end case;

      end loop ZahlenSchleife;
      
   end ZahlSchleife;



   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function GanzeZahlPrüfung (Zeichen : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusDreiZuDrei is
   begin
      
      case Zeichen is
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
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Zeug,
                                            TextZeile => 32);

      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
      return Name;
      
   end StadtName;



   function SpielstandName return Unbounded_Wide_Wide_String is
   begin            
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Fragen,
                                            TextZeile => 22);

      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);

      case To_Wide_Wide_String (Source => Name)'Length is
         when 0 =>
            return To_Unbounded_Wide_Wide_String (Source => "Kein Name"); -- Später noch durch eine Prüfung ersetzen ob das ein nicht leerer Name ist.
              
         when others =>      
            return Name;
      end case;
      
   end SpielstandName;

end Eingabe;
