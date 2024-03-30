with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with TastenbelegungDatentypen;
with MenueDatentypen;
with GrafikDatentypen;
with TextnummernKonstanten;
with TextKonstanten;
with AuswahlKonstanten;
with Projekteinstellungen;
with TextArrays;
with BetriebssystemKonstanten;

with LeseAllgemeines;
with SchreibeGrafiktask;

with MausauswahlLogik;
with TasteneingabeLogik;
with SpielstandAllgemeinesLogik;
with JaNeinLogik;
with SpielstandEntfernenLogik;
with SpielstandVariablen;
with EinlesenAllgemeinesLogik;

package body SpielstandlisteLogik is

   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String
   is begin
            
      SpielstandSchleife:
      loop
         
         Schleifenanfang := TextArrays.SpielstandArray'First;
         SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => False);
         
         case
           Spielstandart
         is
            when SpielstandDatentypen.Manueller_Spielstand_Enum =>
               Start_Search (Search    => Suche,
                             Directory => VerzeichnisKonstanten.SpielstandStrich & VerzeichnisKonstanten.SpielstandSpieler,
                             Pattern   => "",
                             Filter    => (Ordinary_File => True,
                                           others        => False));
               
            when SpielstandDatentypen.Automatischer_Spielstand_Enum =>
               Start_Search (Search    => Suche,
                             Directory => VerzeichnisKonstanten.SpielstandStrich & VerzeichnisKonstanten.SpielstandAuto,
                             Pattern   => "",
                             Filter    => (Ordinary_File => True,
                                           others        => False));
               
         end case;
         
         MittelSchleife:
         loop
            
            case
              Schleifenanfang
            is
               when TextArrays.SpielstandArray'First =>
                  SpielstandVariablen.Nullsetzung;
                  
               when others =>
                  Zwischenspeicher := SpielstandVariablen.SpielstandnameLesen (NummerExtern => TextArrays.SpielstandArray'Last);
                  SpielstandVariablen.Nullsetzung;
                  SpielstandVariablen.SpielstandnameSchreiben (NameExtern   => Zwischenspeicher,
                                                               NummerExtern => TextArrays.SpielstandArray'First);
            end case;
            
            AktuellerSpielstand := Schleifenanfang;
            
            SpeicherdateiSchleife:
            loop
                              
               case
                 More_Entries (Search => Suche)
               is
                  when False =>
                     exit SpeicherdateiSchleife;
                     
                  when True =>
                     Get_Next_Entry (Search          => Suche,
                                     Directory_Entry => Spielstanddatei);
               end case;
               
               SpielstandVariablen.SpielstandnameSchreiben (NameExtern   => To_Unbounded_Wide_Wide_String (Source => Decode (Item => Simple_Name (Directory_Entry => Spielstanddatei))),
                                                            NummerExtern => AktuellerSpielstand);
               
               if
                 NamePrüfen (NameExtern => To_Wide_Wide_String (Source => SpielstandVariablen.SpielstandnameLesen (NummerExtern => AktuellerSpielstand))) = False
               then
                  SpielstandVariablen.SpielstandnameSchreiben (NameExtern   => TextKonstanten.LeerUnboundedString,
                                                               NummerExtern => AktuellerSpielstand);
                  
               elsif
                 AktuellerSpielstand = TextArrays.SpielstandArray'Last
               then
                  SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => True);
                  exit SpeicherdateiSchleife;
                     
               else
                  AktuellerSpielstand := AktuellerSpielstand + 1;
               end if;
               
            end loop SpeicherdateiSchleife;
                                    
            AuswahlSchleife:
            loop
               
               Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
               
               if
                 Ausgewählt > 0
               then
                  Ausgewählt := Ausgewählt - 2;
                    
               else
                  null;
               end if;
               
               case
                 Ausgewählt
               is
                  when AuswahlKonstanten.LeerAuswahl | Zurück =>
                     RückgabeWert := TextKonstanten.LeerUnboundedString;
                     exit SpielstandSchleife;
                     
                  when MehrAnzeigen =>
                     if
                       SpielstandVariablen.SpielstandnameLesen (NummerExtern => Ausgewählt) = TextKonstanten.LeerUnboundedString
                     then
                        exit MittelSchleife;
                     
                     else
                        -- Schleifenanfang muss hier auf einen Wert ungleich SpielstandVariablen.SpielstandArray'First gesetzt werden, damit bei mehreren Seiten es korrekt weitergeht.
                        Schleifenanfang := TextArrays.SpielstandArray'First + 1;
                        exit AuswahlSchleife;
                     end if;
                  
                  when NeuerSpielstand =>
                     RückgabeWert := NameNutzer;
                     
                     if
                       RückgabeWert = TextKonstanten.LeerUnboundedString
                     then
                        null;
                        
                     else
                        exit SpielstandSchleife;
                     end if;
                     
                  when Löschen =>
                     SchreibeGrafiktask.Löschauswahl (JaNeinExtern => True);
                     Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
                     
                     if
                       Ausgewählt - 2 in SpielstandlisteAnfang .. SpielstandlisteEnde
                     then
                        SpielstandEntfernenLogik.SpielstandEntfernen (SpielstandnameExtern => To_Wide_Wide_String (Source => SpielstandVariablen.SpielstandnameLesen (NummerExtern => Ausgewählt - 2)),
                                                                      ManuellAutoExtern    => Spielstandart);
                        exit MittelSchleife;
                        
                     elsif
                       Ausgewählt = Zurück
                     then
                        RückgabeWert := TextKonstanten.LeerUnboundedString;
                        exit SpielstandSchleife;
                        
                     else
                        null;
                     end if;
                     
                  when -1 =>
                     Spielstandart := SpielstandDatentypen.Manueller_Spielstand_Enum;
                     exit MittelSchleife;
                     
                  when -2 =>
                     if
                       SpeichernLadenExtern
                     then
                        null;
                        
                     else
                        Spielstandart := SpielstandDatentypen.Automatischer_Spielstand_Enum;
                        exit MittelSchleife;
                     end if;
                                       
                  when others =>
                     if
                       SpeichernLadenExtern
                       and then
                         JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageSpielstandÜberschreiben) = True
                     then
                        RückgabeWert := SpielstandVariablen.SpielstandnameLesen (NummerExtern => Ausgewählt);
                        exit SpielstandSchleife;
                        
                     elsif
                       SpeichernLadenExtern = False
                     then
                        RückgabeWert := SpielstandVariablen.SpielstandnameLesen (NummerExtern => Ausgewählt);
                        exit SpielstandSchleife;
                        
                     else
                        null;
                     end if;
               end case;
            
            end loop AuswahlSchleife;
         end loop MittelSchleife;
      end loop SpielstandSchleife;
      
      return RückgabeWert;
      
   end Spielstandliste;
   
   
   
   function Mausauswahl
     (SpeichernLadenExtern : in Boolean)
      return Integer
   is begin
      
      SchreibeGrafiktask.SpeichernLaden (JaNeinExtern => SpeichernLadenExtern);
      SchreibeGrafiktask.Menü (MenüExtern => MenueDatentypen.Spielstand_Menü_Enum);
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Menüs_Enum);
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausauswahlLogik.SpeichernLaden;
         
         if
           AktuelleAuswahl < 0
         then
            SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
            SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AktuelleAuswahl);
            
         elsif
           AktuelleAuswahl > 0
         then
            SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AktuelleAuswahl);
            SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
            
         else
            SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
            SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
         end if;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               elsif
                 AktuelleAuswahl < AuswahlKonstanten.LeerAuswahl
               then
                  SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
                  return AktuelleAuswahl;
                  
               else
                  SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
                  SchreibeGrafiktask.Löschauswahl (JaNeinExtern => False);
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               SchreibeGrafiktask.Löschauswahl (JaNeinExtern => False);
               return AuswahlKonstanten.LeerAuswahl;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Mausauswahl;
   
   
   
   function NameNutzer
     return Unbounded_Wide_Wide_String
   is begin
      
      if
        LeseAllgemeines.Ironman /= TextKonstanten.LeerUnboundedString
      then
         Spielstandname := LeseAllgemeines.Ironman;
               
      else
         Spielstandname := SpielstandAllgemeinesLogik.SpielstandNameErmitteln;
         
         if
           Spielstandname = TextKonstanten.LeerUnboundedString
         then
            null;
            
         else
            case
              SpielstandAllgemeinesLogik.SpielstandVorhanden (SpielstandnameExtern => Spielstandname)
            is
               when False =>
                  null;
                  
               when True =>
                  if
                    JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageSpielstandÜberschreiben) = True
                  then
                     null;
                     
                  else
                     Spielstandname := TextKonstanten.LeerUnboundedString;
                  end if;
            end case;
         end if;
      end if;
      
      return Spielstandname;
      
   end NameNutzer;
   
   
   
   function NamePrüfen
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      case
        Projekteinstellungen.Debug.LinuxWindows
      is
         when True =>
            return NamePrüfenLinux (NameExtern => NameExtern);
            
         when False =>
            return EinlesenAllgemeinesLogik.NamensprüfungWindows (NameExtern => NameExtern);
      end case;
      
   end NamePrüfen;
   
   
   
   function NamePrüfenLinux
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      PrüfenSchleife:
      for PrüfenSchleifenwert in NameExtern'Range loop
         
         case
           NameExtern (PrüfenSchleifenwert)
         is
            when '/' | BetriebssystemKonstanten.NUL =>
               return False;
               
            when others =>
               null;
         end case;
         
      end loop PrüfenSchleife;
      
      return True;
      
   end NamePrüfenLinux;

end SpielstandlisteLogik;
