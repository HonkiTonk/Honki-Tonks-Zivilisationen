pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf;
with Sf.Window.Mouse;

with KartenDatentypen; use KartenDatentypen;
with GlobaleTexte;

with EingabeSystemeSFML;
with Anzeige;
with InteraktionTasks;
with Fehler;

package body EingabeSFML is
   
   function GanzeZahl
     (ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      EingegebeneZahl.EingegebeneZahl := ZahlenMinimumExtern;
      AktuellerWert := ZahlenMinimumExtern;
      
      if
        WelcheFrageExtern > GlobaleTexte.Frage'Last
      then
         Fehler.LogikStopp (FehlermeldungExtern => "EingabeSFML.GanzeZahl - Frage ist außerhalb des Fragenbereichs.");
         
      elsif
        ZahlenMinimumExtern > ZahlenMaximumExtern
      then
         Fehler.LogikStopp (FehlermeldungExtern => "EingabeSFML.GanzeZahl - Zahlenminimum ist größer als Zahlenmaximum.");
         
      else
         Frage := WelcheFrageExtern;
         ZahlenString := ("000000000");
         WelchesVorzeichen := True;
         InteraktionTasks.Eingabe := SystemDatentypen.Zahlen_Eingabe;
      end if;
      
      case
        InteraktionTasks.AktuelleDarstellung
      is
         -- Brauche ich den Stadtteil wirklich? Eventuell um in der Stadt bestimmte Dinge festzulegen.
         when SystemDatentypen.Grafik_Weltkarte | SystemDatentypen.Grafik_Stadtkarte =>
            null;
            
         when others =>
            InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Menüs;
      end case;
                  
      case
        ZahlSchleife (ZahlenMinimumExtern => ZahlenMinimumExtern,
                      ZahlenMaximumExtern => ZahlenMaximumExtern)
      is
         when True =>
            EingegebeneZahl.EingabeAbbruch := True;
               
         when False =>
            EingegebeneZahl.EingabeAbbruch := False;
      end case;
      
      if
        WelchesVorzeichen
      then
         EingegebeneZahl.EingegebeneZahl := Integer'Wide_Wide_Value (ZahlenString);
                  
      else
         EingegebeneZahl.EingegebeneZahl := -Integer'Wide_Wide_Value (ZahlenString);
      end if;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Keine_Eingabe;
      
      case
        InteraktionTasks.AktuelleDarstellung
      is
         when SystemDatentypen.Grafik_Menüs =>
            InteraktionTasks.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
            
         when others =>
            null;
      end case;
            
      return EingegebeneZahl;
      
   end GanzeZahl;
   
   
   
   function ZahlSchleife
     (ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return Boolean
   is begin
      
      ZahlenSchleife:
      loop

         VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                             ZahlenMaximumExtern => ZahlenMaximumExtern);
            
         EingabeSystemeSFML.TastenEingabe;
         Zahlen := EingabeSystemeSFML.TastaturTaste;
         
         -- 1 = 0 bis 9 als Zahl, -1 = q (Eingabe verlassen), -2 = DEL (Letzte Ziffer löschen), 2 = e/Enter (Eingabe bestätigen), sonst 0.
         case
           GanzeZahlPrüfung (ZeichenExtern => Zahlen)
         is
            when 1 =>
               ZahlHinzufügen (ZahlenMaximumExtern   => ZahlenMaximumExtern,
                                EingegebeneZahlExtern => Zahlen);

            when -1 =>
               return False;

            when 2 =>
               if
                 -Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimumExtern
                 and
                   WelchesVorzeichen = False
               then
                  return True;
                  
               elsif
                 Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimumExtern
               then
                  return True;
                     
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
         
         AktuellerWert := Natural'Wide_Wide_Value (ZahlenString);

      end loop ZahlenSchleife;
      
   end ZahlSchleife;
   
   
   
   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
   is begin
            
      if
        ZahlenMinimumExtern >= 0
      then
         WelchesVorzeichen := True;
         
      elsif
        ZahlenMaximumExtern < 0
      then
         WelchesVorzeichen := False;
            
      else
         null;
      end if;
      
   end VorzeichenAnpassen;
   
   
   
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
            
      return NameEingeben (WelcheFrageExtern => 35);
      
   end StadtName;
   
   
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return Unbounded_Wide_Wide_String
   is begin
      
      Frage := WelcheFrageExtern;
      InteraktionTasks.Eingabe := SystemDatentypen.Text_Eingabe;
      
      EingegebenerName := EingabeSystemeSFML.TextEingeben;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Keine_Eingabe;
      
      return EingegebenerName;
      
   end NameEingeben;
   
   
   
   function SpielstandName
     return Unbounded_Wide_Wide_String
   is begin
      
      Name := NameEingeben (WelcheFrageExtern => 18);

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
      EingabeSystemeSFML.TastenEingabe;
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      EingabeSystemeSFML.TastenEingabe;
      
      -- Das hier bis zur Schleife zu einem if-Block zusammenfassen?
      -- Das Mausrad muss? vor der Maustaste geprüft werden.
      if
        EingabeSystemeSFML.MausRad > 0.00
      then
         return SystemDatentypen.Ebene_Hoch;
               
      elsif
        EingabeSystemeSFML.MausRad < 0.00
      then
         return SystemDatentypen.Ebene_Runter;
               
      else
         null;
      end if;
            
      case
        EingabeSystemeSFML.MausTaste
      is
         when Sf.Window.Mouse.sfMouseLeft =>
            return SystemDatentypen.Auswählen;
            
         when Sf.Window.Mouse.sfMouseRight =>
            return SystemDatentypen.Menü_Zurück;
            
         when others =>
            null;
      end case;
            
      case
        EingabeSystemeSFML.TastaturTaste
      is
         when Sf.Window.Keyboard.sfKeyUnknown =>
            return SystemDatentypen.Leer;
            
         when others =>
            Taste := EingabeSystemeSFML.TastaturTaste;
      end case;
      
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
      
      return SystemDatentypen.Leer;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      Tastenbelegung := TastenbelegungStandard;
      
   end StandardTastenbelegungLaden;
   
end EingabeSFML;
