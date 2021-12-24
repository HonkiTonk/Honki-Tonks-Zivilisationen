pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.Wide_Wide_Fixed; -- use Ada.Strings.Wide_Wide_Fixed;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Window.Mouse; use Sf.Window.Mouse;
with Sf;

with GlobaleTexte;

with EingabeSystemeSFML;
with Anzeige;
with InteraktionTasks;
with Fehler;

package body EingabeSFML is
   
   function GanzeZahl
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
   is begin
            
      if
        WelcheFrageExtern > GlobaleTexte.Frage'Last
      then
         Fehler.LogikStopp (FehlermeldungExtern => "EingabeSFML.GanzeZahl - Frage ist außerhalb des Fragenbereichs.");
         
      elsif
        ZahlenMinimumExtern > ZahlenMaximumExtern
      then
         Fehler.LogikStopp (FehlermeldungExtern => "EingabeSFML.GanzeZahl - Zahlenminimum ist größer als Zahlenmaximum.");
         
      else
         -- Wegen der grafischen Anzeige festgelegt.
         Frage := WelcheFrageExtern;
         AktuellerWert := 0;
         EingegebeneZahl.EingegebeneZahl := AktuellerWert;
         ZahlenString := ZahlenStringLeer;
         VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                             PlusMinusExtern     => True);
         InteraktionTasks.Eingabe := SystemDatentypen.Zahlen_Eingabe;
      end if;
                  
      case
        ZahlSchleife (ZahlenMinimumExtern => ZahlenMinimumExtern,
                      ZahlenMaximumExtern => ZahlenMaximumExtern)
      is
         when True =>
            EingegebeneZahl.EingabeAbbruch := True;
               
         when False =>
            EingegebeneZahl.EingabeAbbruch := False;
      end case;
      
      InteraktionTasks.Eingabe := SystemDatentypen.Keine_Eingabe;
      
      if
        WelchesVorzeichen
      then
         EingegebeneZahl.EingegebeneZahl := Integer'Wide_Wide_Value (ZahlenString);
                  
      else
         EingegebeneZahl.EingegebeneZahl := -Integer'Wide_Wide_Value (ZahlenString);
      end if;
            
      return EingegebeneZahl;
      
   end GanzeZahl;
   
   
   
   function ZahlSchleife
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen)
      return Boolean
   is begin
            
      ZahlenSchleife:
      loop
            
         EingabeSystemeSFML.TastenEingabe;
         Zahlen := EingabeSystemeSFML.TastaturTaste;
         
         case
           GanzeZahlPrüfung (ZeichenExtern => Zahlen)
         is
            when Zahl_Hinzufügen =>
               ZahlHinzufügen (EingegebeneZahlExtern => Zahlen);

            when Eingabe_Abbrechen =>
               return False;

            when Eingabe_Fertig =>
               if
                 MinimumMaximumSetzen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                       ZahlenMaximumExtern => ZahlenMaximumExtern)
                 = True
               then
                  return True;
                  
               else
                  null;
               end if;

            when Zahl_Löschen =>
               ZahlEntfernen;
               
            when Vorzeichen_Plus =>
               VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                   ZahlenMaximumExtern => ZahlenMaximumExtern,
                                   PlusMinusExtern     => True);
               
            when Vorzeichen_Minus =>
               VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                   ZahlenMaximumExtern => ZahlenMaximumExtern,
                                   PlusMinusExtern     => False);
                  
            when Leer =>
               null;
         end case;
         
         AktuellerWert := Natural'Wide_Wide_Value (ZahlenString);

      end loop ZahlenSchleife;
      
   end ZahlSchleife;
   
   
   
   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen;
      PlusMinusExtern : in Boolean)
   is begin
            
      if
        ZahlenMinimumExtern >= 0
      then
         WelchesVorzeichen := True;
         
      elsif
        ZahlenMaximumExtern < 0
      then
         WelchesVorzeichen := False;
         
      elsif
        PlusMinusExtern
      then
         WelchesVorzeichen := True;
         
      else
         WelchesVorzeichen := False;
      end if;
      
   end VorzeichenAnpassen;
   
   
   
   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return Zahl_Prüfung_Enum
   is begin
      
      case
        ZeichenExtern
      is
         when Sf.Window.Keyboard.sfKeyNum0 | Sf.Window.Keyboard.sfKeyNum1 | Sf.Window.Keyboard.sfKeyNum2 | Sf.Window.Keyboard.sfKeyNum3 | Sf.Window.Keyboard.sfKeyNum4 | Sf.Window.Keyboard.sfKeyNum5
            | Sf.Window.Keyboard.sfKeyNum6 | Sf.Window.Keyboard.sfKeyNum7 | Sf.Window.Keyboard.sfKeyNum8 | Sf.Window.Keyboard.sfKeyNum9 =>
            return Zahl_Hinzufügen;
            
         when Sf.Window.Keyboard.sfKeyEscape =>
            return Eingabe_Abbrechen;

         when Sf.Window.Keyboard.sfKeyDelete | Sf.Window.Keyboard.sfKeyBack =>
            return Zahl_Löschen;

         when Sf.Window.Keyboard.sfKeyE | Sf.Window.Keyboard.sfKeyEnter =>
            return Eingabe_Fertig;

         when Sf.Window.Keyboard.sfKeySubtract =>
            return Vorzeichen_Minus;
            
         when Sf.Window.Keyboard.sfKeyAdd =>
            return Vorzeichen_Plus;
            
         when others =>
            return Leer;
      end case;
      
   end GanzeZahlPrüfung;
   
   
   
   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      ZahlenNachLinksVerschiebenSchleife:
      for PositionSchleifenwert in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (PositionSchleifenwert - 1) := ZahlenString (PositionSchleifenwert);

      end loop ZahlenNachLinksVerschiebenSchleife;
      
      ZahlenString (ZahlenString'Last) := EingabeZahlenUmwandeln (EingegebeneZahlExtern);
      
      if
        ZahlenString (1) /= '0'
      then
         ZahlenString := Ada.Strings.Wide_Wide_Fixed.Trim (Source => Grenzen'Last'Wide_Wide_Image,
                                                           Side   => Ada.Strings.Left);
           
      else
         null;
      end if;
      
   end ZahlHinzufügen;
   
   
   
   procedure ZahlEntfernen
   is begin
      
      ZahlenNachRechtsVerschiebenSchleife:
      for PositionSchleifenwert in reverse ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (PositionSchleifenwert) := ZahlenString (PositionSchleifenwert - 1);

      end loop ZahlenNachRechtsVerschiebenSchleife;
      
      ZahlenString (1) := '0';
      
   end ZahlEntfernen;
   
   
   
   function MinimumMaximumSetzen
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen)
      return Boolean
   is begin
      
      if
        (WelchesVorzeichen
         and
           Integer'Wide_Wide_Value (ZahlenString) > ZahlenMaximumExtern)
        or
          (WelchesVorzeichen = False
           and
             Integer'Wide_Wide_Value (ZahlenString) > ZahlenMaximumExtern
           and
             ZahlenMaximumExtern < 0)
      then
         AktuelleZahl := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMaximumExtern'Wide_Wide_Image,
                                                           Side   => Ada.Strings.Left)'Length;
         ZahlenString := ZahlenStringLeer;
         
         ZahlenString (ZahlenString'Last - AktuelleZahl + 1 .. ZahlenString'Last) := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMaximumExtern'Wide_Wide_Image,
                                                                                                                       Side   => Ada.Strings.Left);
         return False;
         
      elsif
        (WelchesVorzeichen = False
         and
           Integer'Wide_Wide_Value (ZahlenString) > ZahlenMinimumExtern)
        or
          (WelchesVorzeichen
           and
             Integer'Wide_Wide_Value (ZahlenString) < ZahlenMinimumExtern
           and
             ZahlenMinimumExtern > 0)
      then
         AktuelleZahl := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMinimumExtern'Wide_Wide_Image,
                                                           Side   => Ada.Strings.Left)'Length;
         ZahlenString := ZahlenStringLeer;
         
         ZahlenString (ZahlenString'Last - AktuelleZahl + 1 .. ZahlenString'Last) := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenMinimumExtern'Wide_Wide_Image,
                                                                                                                       Side   => Ada.Strings.Left);
         return False;
         
      else
         return True;
      end if;
      
   end MinimumMaximumSetzen;
   
   
   
   function StadtName
     return SystemRecords.TextEingabeRecord
   is begin
            
      return NameEingeben (WelcheFrageExtern => 35);
      
   end StadtName;
   
   
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord
   is begin
      
      Frage := WelcheFrageExtern;
      
      EingegebenerName := EingabeSystemeSFML.TextEingeben;
      
      return EingegebenerName;
      
   end NameEingeben;
   
   
   
   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      Name := NameEingeben (WelcheFrageExtern => 18);
      
      case
        Name.ErfolgreichAbbruch
      is
         when False =>
            return Name;
            
         when True =>
            null;
      end case;

      case
        To_Wide_Wide_String (Source => Name.EingegebenerText)'Length
      is
         when 0 =>
            -- Später noch durch eine Prüfung ersetzen ob das ein nicht leerer Name ist?
            return (True, To_Unbounded_Wide_Wide_String (Source => "Kein Name"));
              
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
      
      -- InteraktionTasks.EingabeTastenwert := True;
      
      EingabeSystemeSFML.TastenEingabe;
      -- while InteraktionTasks.EingabeTastenwert loop
         
      --     delay 0.000000002;
         
      --  end loop;
      
      -- Das Mausrad muss? vor der Maustaste geprüft werden.
      if
        EingabeSystemeSFML.MausRad > 0.00
      then
         return SystemDatentypen.Ebene_Hoch;
               
      elsif
        EingabeSystemeSFML.MausRad < 0.00
      then
         return SystemDatentypen.Ebene_Runter;
         
      elsif
        EingabeSystemeSFML.MausTaste = Sf.Window.Mouse.sfMouseLeft
      then
         return SystemDatentypen.Auswählen;
         
      elsif
        EingabeSystemeSFML.MausTaste = Sf.Window.Mouse.sfMouseRight
      then
         return SystemDatentypen.Menü_Zurück;
         
      elsif
        EingabeSystemeSFML.TastaturTaste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return SystemDatentypen.Leer;
            
      else
         Taste := EingabeSystemeSFML.TastaturTaste;
      end if;
      
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
