pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with Anzeige;

package body Eingabe is

   function GanzeZahl (Zahlengröße : Positive) return Integer is
   begin
      
      EingabeSchleife:
      loop

         Zahl := To_Unbounded_Wide_Wide_String (Source => Get_Line);
         if To_Wide_Wide_String (Source => Zahl)'Length = 0 then
            return -1;
            
         else
            null;
         end if;

         loop
            
            if To_Wide_Wide_String (Source => Zahl) (1) = '0' then
               Delete (Zahl, 1, 1);
               
            else
               exit;
            end if;
            
         end loop;
         
         if To_Wide_Wide_String (Source => Zahl)'Length = 0 then
            return -1;

         elsif To_Wide_Wide_String (Source => Zahl)'Length > Zahlengröße then
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                AktuelleAuswahl    => 1,
                                FrageDatei         => 0,
                                FrageZeile         => 0,
                                TextDatei          => 8,
                                ErsteZeile         => 13,
                                LetzteZeile        => 13);
         
         else
            for A in To_Wide_Wide_String (Source => Zahl)'Range loop
         
               case Is_Digit (To_Wide_Wide_String (Source => Zahl) (A)) is
                  when True =>
                     if A = Zahlengröße or A = To_Wide_Wide_String (Source => Zahl)'Last then
                        exit EingabeSchleife;
                     
                     else
                        null;
                     end if;
               
                  when False =>
                     Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                         AktuelleAuswahl    => 1,
                                         FrageDatei         => 0,
                                         FrageZeile         => 0,
                                         TextDatei          => 8,
                                         ErsteZeile         => 14,
                                         LetzteZeile        => 14);
                     exit;
               end case;
            end loop;
         end if;

      end loop EingabeSchleife;
      
      return Integer'Wide_Wide_Value (To_Wide_Wide_String (Source => Zahl));
      
   end GanzeZahl;
   


   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function GanzeZahlNeu (WelcheDatei, WelcherText, ZahlenMinimum, ZahlenMaximum : Natural) return Integer is
   begin
      
      Schleifen := (others => False);
      AktuelleZahlenPosition := 9;
      
      HauptSchleife:
      loop
         
         ErsteZahlSchleife: -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
         while Schleifen (9) = False loop
            
            Get_Immediate (Item => Zahlen);
            IstZahl := ZahlPrüfung (Zeichen => Zahlen);
            case IstZahl is
               when 1 =>
                  ZahlenString (9) := Zahlen;

                  if Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximum then
                     Schleifen (9) := True;
                     
                  else
                     Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  end if;

               when -1 =>
                  return -1;

               when 2 =>
                  if Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum then
                     exit HauptSchleife;
                     
                  else
                     null;
                  end if;
                  
               when others =>
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
            end case;

         end loop ErsteZahlSchleife;

         ZahlenAußenSchleife:
         loop
            ZahlenInnenSchleife:
            for ZifferPosition in reverse 2 .. ZahlenString'Last loop           
               
               if AktuelleZahlenPosition >= ZifferPosition then                  
                  Put (Item => Integer'Wide_Wide_Image (Integer'Wide_Wide_Value (ZahlenString)));
            
                  Test := ZahlSchleife (ZahlenMinimum        => ZahlenMinimum,
                                        ZahlenMaximum        => ZahlenMaximum,
                                        WelcheZahlenposition => ZifferPosition);
               
                  case Test is
                     when -1 =>
                        null;
                        
                     when 0 =>
                        null;
                        
                     when 1 =>
                        null;
                        
                     when 2 =>
                        null;
                        
                     when others =>
                        null;
                  end case;
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  
               else
                  null;
               end if;
               
            end loop ZahlenInnenSchleife;
         end loop ZahlenAußenSchleife;

      end loop HauptSchleife;
      
      NullstellenEntfernenSchleife:
      loop
            
         if ZahlenString (1) = '0' then
            Delete (Zahl, 1, 1);
               
         else
            exit NullstellenEntfernenSchleife;
         end if;
            
      end loop NullstellenEntfernenSchleife;

      return Integer'Wide_Wide_Value (ZahlenString);
            
   end GanzeZahlNeu;



   function ZahlSchleife (ZahlenMinimum, ZahlenMaximum : in Natural; WelcheZahlenposition : in Positive) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei is
   begin
      
      ZahlenSchleife: -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
      while Schleifen (WelcheZahlenposition) = False loop
            
         Get_Immediate (Item => Zahlen);
         IstZahl := ZahlPrüfung (Zeichen => Zahlen);
         case IstZahl is
            when 1 =>
               ZahlenString (8) := ZahlenString (9);
               ZahlenString (9) := Zahlen;

               if Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum and Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximum then
                  Schleifen (8) := True;
                     
               else
                  ZahlenString (9) := ZahlenString (8);
                  ZahlenString (8) := '0';
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               end if;

            when -1 =>
               null;

            when 2 =>
               if Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum then
                  null;
                     
               else
                  null;
               end if;

            when -2 =>
               ZahlenString (9) := ZahlenString (8);
               ZahlenString (8) := '0';
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  
            when others =>
               null;
         end case;

      end loop ZahlenSchleife;

      return 1;
      
   end ZahlSchleife;



   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function ZahlPrüfung (Zeichen : in Wide_Wide_Character) return GlobaleDatentypen.LoopRangeMinusZweiZuZwei is
   begin
      
      case Zeichen is
         when '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' =>
            return 1;
            
         when 'q' =>
            return -1;

         when DEL =>
            return -2;

         when 'e' =>
            return 2;
            
         when others =>
            return 0;
      end case;
      
   end ZahlPrüfung;

   

   function StadtName return Unbounded_Wide_Wide_String is
   begin
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 9,
                          ErsteZeile         => 32,
                          LetzteZeile        => 32);
      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
      return Name;
      
   end StadtName;



   function SpielstandName return Unbounded_Wide_Wide_String is
   begin            
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 9,
                          ErsteZeile         => 40,
                          LetzteZeile        => 40);
      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
      return Name;
      
   end SpielstandName;

end Eingabe;
