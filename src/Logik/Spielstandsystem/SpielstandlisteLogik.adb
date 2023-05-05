with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with TastenbelegungDatentypen;
with MenueDatentypen;
with GrafikDatentypen;
with TextnummernKonstanten;
with TextKonstanten;
with AuswahlKonstanten;

with LeseAllgemeines;

with MausauswahlLogik;
with TasteneingabeLogik;
with NachGrafiktask;
with SpielstandAllgemeinesLogik;
with JaNeinLogik;
with SpielstandEntfernenLogik;
with SpielstandVariablen;
with DebugobjekteLogik;

package body SpielstandlisteLogik is

   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String
   is begin
      
      SpielstandSchleife:
      loop
         
         Schleifenanfang := SpielstandVariablen.SpielstandArray'First;
         NachGrafiktask.MehrereSeiten := False;
         
         Start_Search (Search    => Suche,
                       Directory => VerzeichnisKonstanten.Spielstand,
                       Pattern   => "",
                       Filter    => (Ordinary_File => True,
                                     others        => False));
         
         MittelSchleife:
         loop
            
            case
              Schleifenanfang
            is
               when SpielstandVariablen.SpielstandArray'First =>
                  SpielstandVariablen.Nullsetzung;
                  
               when others =>
                  Zwischenspeicher := SpielstandVariablen.SpielstandnameLesen (NummerExtern => SpielstandVariablen.SpielstandArray'Last);
                  SpielstandVariablen.Nullsetzung;
                  SpielstandVariablen.SpielstandnameSchreiben (NameExtern   => Zwischenspeicher,
                                                               NummerExtern => SpielstandVariablen.SpielstandArray'First);
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
                 Size (Name => VerzeichnisKonstanten.SpielstandStrich & Simple_Name (Directory_Entry => Spielstanddatei)) not in KleinsteSpeicherdateigröße .. GrößteSpeicherdateigröße
               then
                  SpielstandVariablen.SpielstandnameSchreiben (NameExtern   => TextKonstanten.LeerUnboundedString,
                                                               NummerExtern => AktuellerSpielstand);
                  
               elsif
                 AktuellerSpielstand = SpielstandVariablen.SpielstandArray'Last
               then
                  NachGrafiktask.MehrereSeiten := True;
                  exit SpeicherdateiSchleife;
                     
               else
                  AktuellerSpielstand := AktuellerSpielstand + 1;
               end if;
               
            end loop SpeicherdateiSchleife;
                                    
            AuswahlSchleife:
            loop
               
               Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
               
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
                        Schleifenanfang := SpielstandVariablen.SpielstandArray'First + 1;
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
                     NachGrafiktask.LöschenAusgewählt := True;
                     Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
                     
                     if
                       Ausgewählt in SpielstandlisteAnfang .. SpielstandlisteEnde
                     then
                        SpielstandEntfernenLogik.SpielstandEntfernen (SpielstandnameExtern => To_Wide_Wide_String (Source => SpielstandVariablen.SpielstandnameLesen (NummerExtern => Ausgewählt)));
                        exit MittelSchleife;
                        
                     elsif
                       Ausgewählt = Zurück
                     then
                        RückgabeWert := TextKonstanten.LeerUnboundedString;
                        exit SpielstandSchleife;
                        
                     else
                        null;
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
      return Natural
   is begin
      
      NachGrafiktask.SpeichernLaden := SpeichernLadenExtern;
      NachGrafiktask.AktuellesMenü := MenueDatentypen.Spielstand_Menü_Enum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Menüs_Enum;
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausauswahlLogik.SpeichernLaden;
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  NachGrafiktask.AktuelleAuswahl.AuswahlEins := AuswahlKonstanten.LeerAuswahl;
                  NachGrafiktask.LöschenAusgewählt := False;
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               NachGrafiktask.LöschenAusgewählt := False;
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
        DebugobjekteLogik.Debug.LinuxWindows
      is
         when True =>
            return NamePrüfenLinux (NameExtern => NameExtern);
            
         when False =>
            return NamePrüfenWindows (NameExtern => NameExtern);
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
            when '/' | NUL =>
               return False;
               
            when others =>
               null;
         end case;
         
      end loop PrüfenSchleife;
      
      return True;
      
   end NamePrüfenLinux;
   
   
   
   function NamePrüfenWindows
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      PrüfenSchleife:
      for PrüfenSchleifenwert in NameExtern'Range loop
         
         case
           NameExtern (PrüfenSchleifenwert)
         is
            when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | Space | Hyphen | Low_Line | Full_Stop =>
               null;
               
            when others =>
               return False;
         end case;
         
      end loop PrüfenSchleife;
      
      return True;
      
   end NamePrüfenWindows;

end SpielstandlisteLogik;
