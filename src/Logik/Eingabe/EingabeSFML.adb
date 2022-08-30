pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.Wide_Wide_Fixed;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Window.Mouse; use Sf.Window.Mouse;
with Sf;

with Meldungstexte;
with TextnummernKonstanten;
with SystemDatentypen;
with SystemRecordKonstanten;
with TastenbelegungVariablen;

with Fehler;
with NachGrafiktask;
with NachLogiktask;

package body EingabeSFML is
   
   -- Neue Version ähnlich der Texteingabe bauen. äöü
   function GanzeZahl
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
   is begin
            
      if
        WelcheFrageExtern > Meldungstexte.Frage'Last
      then
         Fehler.LogikFehler (FehlermeldungExtern => "EingabeSFML.GanzeZahl - Frage außerhalb des Fragenbereichs.");
         
      else
         NachGrafiktask.AnzeigeFrage := WelcheFrageExtern;
         AktuellerWert := 0;
         EingegebeneZahl.EingegebeneZahl := AktuellerWert;
         ZahlenString := ZahlenStringLeer;
         VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                             PlusMinusExtern     => True);
         
         NachGrafiktask.Eingabe := SystemDatentypen.Zahlen_Eingabe_Enum;
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
      
      NachGrafiktask.Eingabe := SystemDatentypen.Keine_Eingabe_Enum;
      
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
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
      return Boolean
   is begin
            
      ZahlenSchleife:
      loop
         
         EingabeAbwarten;
         Zahlen := NachLogiktask.TastaturTaste;
         
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
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
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
         when Sf.Window.Keyboard.sfKeyNum0 .. Sf.Window.Keyboard.sfKeyNum9 | Sf.Window.Keyboard.sfKeyNumpad0 .. Sf.Window.Keyboard.sfKeyNumpad9 =>
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
      
      if
        EingegebeneZahlExtern > Sf.Window.Keyboard.sfKeyNum9
      then
         Zwischenspeicher := EingegebeneZahlExtern - (Sf.Window.Keyboard.sfKeyNumpad0 - Sf.Window.Keyboard.sfKeyNum0);
         
      else
         Zwischenspeicher := EingegebeneZahlExtern;
      end if;
      
      ZahlenString (ZahlenString'Last) := EingabeZahlenUmwandeln (Zwischenspeicher);
      
      if
        ZahlenString (1) /= '0'
      then
         ZahlenString := Ada.Strings.Wide_Wide_Fixed.Trim (Source => ZahlenDatentypen.EigenerInteger'Last'Wide_Wide_Image,
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
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
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
      
      -- Diese Funktion wird auch beim Suchen nach einer Stadt benutzt, Frage universeller gestalten oder eine entsprechende Prüfung welcher Fall vorliegt.
      return NameEingeben (WelcheFrageExtern => TextnummernKonstanten.FrageStadtname);
      
   end StadtName;
   
   
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord
   is begin
      
      NachGrafiktask.AnzeigeFrage := WelcheFrageExtern;
      
      NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
      
      NachGrafiktask.Eingabe := SystemDatentypen.Text_Eingabe_Enum;
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TextEingabe := True;
        
      while NachLogiktask.Warten loop
         
         delay 0.0002;
         
      end loop;
      
      NachGrafiktask.Eingabe := SystemDatentypen.Keine_Eingabe_Enum;
      
      return NachLogiktask.EingegebenerText;
      
   end NameEingeben;
   
   
   
   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      Name := NameEingeben (WelcheFrageExtern => TextnummernKonstanten.FrageSpielstandname);
      
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
            return (True, To_Unbounded_Wide_Wide_String (Source => "Kein Name"));
              
         when others =>
            return Name;
      end case;
      
   end SpielstandName;
   
   
   
   function TastenbelegungAnpassen
     return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      TasteneingabeSchleife:
      loop
         
         EingabeAbwarten;
      
         case
           -- Maustaste mal als lokale Variable anlegen. äöü
           NachLogiktask.MausTaste
         is
            when Sf.Window.Mouse.sfMouseRight =>
               return Sf.Window.Keyboard.sfKeyUnknown;
            
            when others =>
               Taste := NachLogiktask.TastaturTaste;
         end case;
      
         case
           Taste
         is
            when Sf.Window.Keyboard.sfKeyNumpad0 .. Sf.Window.Keyboard.sfKeyNumpad9 | Sf.Window.Keyboard.sfKeyAdd .. Sf.Window.Keyboard.sfKeySubtract =>
               null;
            
            when Sf.Window.Keyboard.sfKeyEscape =>
               return Sf.Window.Keyboard.sfKeyUnknown;
               
            when Sf.Window.Keyboard.sfKeyUnknown =>
               null;
               
            when others =>
               return Taste;
         end case;
         
      end loop TasteneingabeSchleife;
      
   end TastenbelegungAnpassen;
   
   
   
   procedure EingabeAbwarten
   is begin
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TastenEingabe := True;
        
      while NachLogiktask.Warten loop
         
         delay 0.0002;
         
      end loop;
      
   end EingabeAbwarten;
   
   
   
   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum
   is begin
            
      EingabeAbwarten;
         
      if
        NachLogiktask.MausTaste = Sf.Window.Mouse.sfMouseLeft
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        NachLogiktask.MausTaste = Sf.Window.Mouse.sfMouseRight
      then
         return TastenbelegungDatentypen.Menü_Zurück_Enum;
         
      elsif
        NachLogiktask.TastaturTaste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return TastenbelegungDatentypen.Leer_Tastenbelegung_Enum;
            
      else
         Taste := NachLogiktask.TastaturTaste;
      end if;
      
      BelegungSchleife:
      for BelegungSchleifenwert in TastenbelegungVariablen.TastenbelegungArray'Range loop
            
         if
           TastenbelegungVariablen.Tastenbelegung (BelegungSchleifenwert) = Taste
         then
            return BelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop BelegungSchleife;
      
      return TastenbelegungDatentypen.Leer_Tastenbelegung_Enum;
      
   end Tastenwert;
   
end EingabeSFML;
