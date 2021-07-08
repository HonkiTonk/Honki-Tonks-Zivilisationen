pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Integer_Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleKonstanten;

with Anzeige;

package body Eingabe is 

   -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
   function GanzeZahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer)
      return Integer
   is begin
      
      ZahlenString := ("000000000");
      WelchesVorzeichen := True;

      ZahlenAußenSchleife:
      loop         
                  
         case
           ZahlSchleife (TextDateiExtern     => TextDateiExtern,
                         ZeileExtern         => ZeileExtern,
                         ZahlenMinimumExtern => ZahlenMinimumExtern,
                         ZahlenMaximumExtern => ZahlenMaximumExtern)
         is
            when 2 =>
               exit ZahlenAußenSchleife;
               
            when -1 =>
               return GlobaleKonstanten.GanzeZahlAbbruchKonstante;
                        
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



   function ZahlSchleife
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer)
      return GlobaleDatentypen.LoopRangeMinusZweiZuZwei
   is begin

      -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen) = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
      ZahlenSchleife:
      loop

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => TextDateiExtern,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => ZeileExtern,
                                        LetzteZeileExtern      => ZeileExtern,
                                        AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
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
            
         else
            if
              WelchesVorzeichen = True
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
            end if;
            Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer'Wide_Wide_Value (ZahlenString),
                                               Width => 1,
                                               Base  => 10);
         end if;
         
         -- 1 = 0 bis 9 als Zahl, q (Eingabe verlassen) = -1, DEL (Letzte Ziffer löschen) = -2, e (Eingabe bestätigen) = 2, sonst 0
         Get_Immediate (Item => Zahlen);
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         case
           GanzeZahlPrüfung (ZeichenExtern => Zahlen)
         is
            when 1 =>
               ZahlenNachLinksVerschiebenSchleife:
               for ZahlEinsSchleifenwert in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
                  ZahlenString (ZahlEinsSchleifenwert - 1) := ZahlenString (ZahlEinsSchleifenwert);

               end loop ZahlenNachLinksVerschiebenSchleife;
               ZahlenString (ZahlenString'Last) := Zahlen;

               if
                 Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximumExtern
               then
                  null;
                  
               else
                  if
                    ZahlenMaximumExtern >= 100_000_000
                  then
                     ZahlenString := ZahlenMaximumExtern'Wide_Wide_Image;
                       
                  else
                     MinimumMaximumSetzen (ZahlenMinimumMaximumExtern => ZahlenMaximumExtern);
                  end if;
               end if;

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
   function GanzeZahlPrüfung
     (ZeichenExtern : in Wide_Wide_Character)
      return GlobaleDatentypen.LoopRangeMinusDreiZuDrei
   is begin
      
      case
        ZeichenExtern
      is
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

   

   function StadtName
     return Unbounded_Wide_Wide_String
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                            TextZeileExtern => 32);
      
      return To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
   end StadtName;



   function SpielstandName
     return Unbounded_Wide_Wide_String
   is begin            
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                            TextZeileExtern => 22);

      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);

      case
        To_Wide_Wide_String (Source => Name)'Length
      is
         when 0 =>
            -- Später noch durch eine Prüfung ersetzen ob das ein nicht leerer Name ist.
            return To_Unbounded_Wide_Wide_String (Source => "Kein Name");
              
         when others =>
            return Name;
      end case;
      
   end SpielstandName;



   function TastenEingabe
     return Wide_Wide_Character
   is begin

      Get_Immediate (Item => Taste);

      if
        Taste = ESC
      then
         Get_Immediate (Item => Taste);
         if
           Taste = '['
         then
            Get_Immediate (Item => Taste);
            if
              -- Pfeiltaste hoch
              Taste = 'A'
            then
               return 'w';
               
            elsif
              -- Pfeiltaste runter
              Taste = 'B'
            then
               return 's';

            elsif
              -- Pfeiltaste rechts
              Taste = 'C'
            then
               return 'd';
                 
            elsif
              -- Pfeiltaste links
              Taste = 'D'
            then
               return 'a';
                 
            else
               return '0';
            end if;
         
         else
            return ESC;
         end if;

      else
         null;
      end if;
      
      return To_Lower (Item => Taste);
      
   end TastenEingabe;



   procedure WartenEingabe
   is begin
      
      New_Line;
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Zeug,
                                            TextZeileExtern => 47);
      Get_Immediate (Taste);
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return GlobaleDatentypen.Tastenbelegung_Enum
   is begin
      
      Taste := TastenEingabe;
      
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
      
      return GlobaleDatentypen.Nicht_Vorhanden;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungWiederherstellen
   is begin
      
      Tastenbelegung := TastenbelegungStandard;
      
   end StandardTastenbelegungWiederherstellen;

end Eingabe;
