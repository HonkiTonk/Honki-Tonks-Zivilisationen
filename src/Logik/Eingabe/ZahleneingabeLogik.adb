with Ada.Strings.Wide_Wide_Fixed; use Ada.Strings.Wide_Wide_Fixed;

with Sf;

with GrafikDatentypen;

with NachGrafiktask;
with NachLogiktask;
with EingabeAllgemeinLogik;

package body ZahleneingabeLogik is
   
   function Zahleneingabe
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      ZahlenString := ZahlenStringLeer;
      EingegebeneZahl.EingegebeneZahl := 0;
      
      WelchesVorzeichen := VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                               ZahlenMaximumExtern => ZahlenMaximumExtern,
                                               PlusMinusExtern     => True);
      
      -- Hier Sonderwerte setzen und in der Grafik das dann beim Text zusätzlich anzeigen? Oder neben der eingegebenen Zahl? Oder einfach gar nicht? äöü
      -- LeerWert := MinimumMaximumSetzen (ZahlenMinimumExtern => ZahlenMinimumExtern,
      --                                  ZahlenMaximumExtern => ZahlenMaximumExtern);
      
      NachGrafiktask.AnzeigeFrage := WelcheFrageExtern;
      NachGrafiktask.EingegebeneZahl := EingegebeneZahl.EingegebeneZahl;
      NachGrafiktask.Eingabe := GrafikDatentypen.Zahlen_Eingabe_Enum;
      
      return ZahlSchleife (ZahlenMinimumExtern => ZahlenMinimumExtern,
                           ZahlenMaximumExtern => ZahlenMaximumExtern);
      
   end Zahleneingabe;
   
   
   
   function ZahlSchleife
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
      return SystemRecords.ZahlenEingabeRecord
   is begin
                  
      ZahlenSchleife:
      loop
         
         NachLogiktask.GrafikWarten := True;
         NachGrafiktask.TastenEingabe := True;
         EingabeAllgemeinLogik.EingabeAbwarten;
         Zahlen := NachLogiktask.TastaturTaste;
         
         case
           GanzeZahlPrüfung (ZeichenExtern => Zahlen)
         is
            when Zahl_Hinzufügen =>
               ZahlHinzufügen (EingegebeneZahlExtern => Zahlen,
                                ZahlenMinimumExtern   => ZahlenMinimumExtern,
                                ZahlenMaximumExtern   => ZahlenMaximumExtern);

            when Eingabe_Abbrechen =>
               EingegebeneZahl.ErfolgreichAbbruch := False;
               exit ZahlenSchleife;

            when Eingabe_Fertig =>
               if
                 True = MinimumMaximumSetzen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                              ZahlenMaximumExtern => ZahlenMaximumExtern)
               then
                  EingegebeneZahl.ErfolgreichAbbruch := True;
                  exit ZahlenSchleife;
                  
               else
                  null;
               end if;

            when Zahl_Löschen =>
               ZahlEntfernen;
               
            when Vorzeichen_Plus =>
               WelchesVorzeichen := VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                                        ZahlenMaximumExtern => ZahlenMaximumExtern,
                                                        PlusMinusExtern     => True);
               
            when Vorzeichen_Minus =>
               WelchesVorzeichen := VorzeichenAnpassen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                                        ZahlenMaximumExtern => ZahlenMaximumExtern,
                                                        PlusMinusExtern     => False);
               
            when Leer =>
               null;
         end case;
         
         NachGrafiktask.EingegebenesVorzeichen := WelchesVorzeichen;
         NachGrafiktask.EingegebeneZahl := Natural'Wide_Wide_Value (ZahlenString);

      end loop ZahlenSchleife;
      
      case
        EingegebeneZahl.ErfolgreichAbbruch
      is
         when True =>
            if
              WelchesVorzeichen
            then
               EingegebeneZahl.EingegebeneZahl := Integer'Wide_Wide_Value (ZahlenString);
                  
            else
               EingegebeneZahl.EingegebeneZahl := -Integer'Wide_Wide_Value (ZahlenString);
            end if;
            
         when False =>
            null;
      end case;
            
      NachGrafiktask.Eingabe := GrafikDatentypen.Keine_Eingabe_Enum;
      
      return EingegebeneZahl;
      
   end ZahlSchleife;
   
   
   
   function VorzeichenAnpassen
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      PlusMinusExtern : in Boolean)
      return Boolean
   is begin
            
      if
        ZahlenMinimumExtern >= 0
      then
         return True;
         
      elsif
        ZahlenMaximumExtern < 0
      then
         return False;
         
      else
         return PlusMinusExtern;
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
     (EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode;
      ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
   is
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      if
        ZahlenString = Trim (Source => ZahlenMaximumExtern'Wide_Wide_Image,
                             Side   => Ada.Strings.Left)
      then
         return;
         
      else
         null;
      end if;
      
      ZahlenNachLinksVerschiebenSchleife:
      for PositionSchleifenwert in ZahlenString'First + 1 .. ZahlenString'Last loop
                  
         ZahlenString (PositionSchleifenwert - 1) := ZahlenString (PositionSchleifenwert);

      end loop ZahlenNachLinksVerschiebenSchleife;
      
      if
        EingegebeneZahlExtern > Sf.Window.Keyboard.sfKeyNum9
      then
         Zwischenspeicher := EingegebeneZahlExtern - Sf.Window.Keyboard.sfKeyNumpad0 + Sf.Window.Keyboard.sfKeyNum0;
         
      else
         Zwischenspeicher := EingegebeneZahlExtern;
      end if;
      
      ZahlenString (ZahlenString'Last) := EingabeZahlenUmwandeln (Zwischenspeicher);
              
      if
        ZahlenString (1) /= '0'
      then
         ZahlenString := Trim (Source => ZahlenDatentypen.EigenesPositive'Last'Wide_Wide_Image,
                               Side   => Ada.Strings.Left);
         
      else
         ZahlBeschränken (ZahlenMinimumExtern => ZahlenMinimumExtern,
                           ZahlenMaximumExtern => ZahlenMaximumExtern);
      end if;
      
   end ZahlHinzufügen;
   
   
   
   procedure ZahlBeschränken
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
   is begin
      
      StringNachZahl := Natural'Wide_Wide_Value (ZahlenString);
      
      if
        StringNachZahl > ZahlenMaximumExtern
        and
          ZahlenMaximumExtern > 0
          and
            WelchesVorzeichen
      then
         LeerWert := MinimumMaximumSetzen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                           ZahlenMaximumExtern => ZahlenMaximumExtern);
           
      elsif
        StringNachZahl > -ZahlenMinimumExtern
        and
          ZahlenMinimumExtern < 0
          and
            WelchesVorzeichen = False
      then
         LeerWert := MinimumMaximumSetzen (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                           ZahlenMaximumExtern => ZahlenMaximumExtern);
         
      else
         null;
      end if;
      
   end ZahlBeschränken;
   
   
   
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
      
      StringNachZahl := Natural'Wide_Wide_Value (ZahlenString);
      
      case
        WelchesVorzeichen
      is
         when True =>
            if
              StringNachZahl in ZahlenMinimumExtern .. ZahlenMaximumExtern
            then
               null;
              
            elsif
              StringNachZahl > ZahlenMaximumExtern
              and
                ZahlenMaximumExtern > 0
            then
               return ZahlenstringLimitieren (ZahlExtern => ZahlenMaximumExtern);
               
            elsif
              StringNachZahl < -ZahlenMaximumExtern
              and
                ZahlenMaximumExtern < 0
            then
               WelchesVorzeichen := not WelchesVorzeichen;
               
               return ZahlenstringLimitieren (ZahlExtern => -ZahlenMaximumExtern);
               
            elsif
              StringNachZahl < ZahlenMinimumExtern
              and
                ZahlenMinimumExtern > 0
            then
               return ZahlenstringLimitieren (ZahlExtern => ZahlenMinimumExtern);
               
            elsif
              StringNachZahl > -ZahlenMinimumExtern
              and
                ZahlenMinimumExtern < 0
            then
               WelchesVorzeichen := not WelchesVorzeichen;
               
               return ZahlenstringLimitieren (ZahlExtern => -ZahlenMinimumExtern);
               
            else
               null;
            end if;
            
         when False =>
            if
              -StringNachZahl in ZahlenMinimumExtern .. ZahlenMaximumExtern
            then
               null;
              
            elsif
              StringNachZahl < ZahlenMaximumExtern
              and
                ZahlenMaximumExtern > 0
            then
               WelchesVorzeichen := not WelchesVorzeichen;
               
               return ZahlenstringLimitieren (ZahlExtern => ZahlenMaximumExtern);
               
            elsif
              StringNachZahl > -ZahlenMaximumExtern
              and
                ZahlenMaximumExtern < 0
            then
               return ZahlenstringLimitieren (ZahlExtern => -ZahlenMaximumExtern);
               
            elsif
              StringNachZahl < ZahlenMinimumExtern
              and
                ZahlenMinimumExtern > 0
            then
               WelchesVorzeichen := not WelchesVorzeichen;
               
               return ZahlenstringLimitieren (ZahlExtern => ZahlenMinimumExtern);
               
            elsif
              StringNachZahl > -ZahlenMinimumExtern
              and
                ZahlenMinimumExtern < 0
            then
               return ZahlenstringLimitieren (ZahlExtern => -ZahlenMinimumExtern);
               
            else
               null;
            end if;
      end case;
      
      return True;
      
   end MinimumMaximumSetzen;
   
   
   
   function ZahlenstringLimitieren
     (ZahlExtern : in ZahlenDatentypen.EigenerInteger)
      return Boolean
   is begin
      
      AktuelleZahl := Trim (Source => ZahlenDatentypen.EigenerInteger'Wide_Wide_Image (ZahlExtern),
                            Side   => Ada.Strings.Left)'Length;
         
      ZahlenString := ZahlenStringLeer;
         
      ZahlenString (ZahlenString'Last - AktuelleZahl + 1 .. ZahlenString'Last) := Trim (Source => ZahlenDatentypen.EigenerInteger'Wide_Wide_Image (ZahlExtern),
                                                                                        Side   => Ada.Strings.Left);
      
      return False;
      
   end ZahlenstringLimitieren;
   
end ZahleneingabeLogik;
