pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Conversions; use Ada.Characters.Conversions;

with VerzeichnisKonstanten;
with TastenbelegungDatentypen;
with SystemKonstanten;
with MenueDatentypen;
with GrafikDatentypen;
with SpielVariablen;
with TextnummernKonstanten;

with MausauswahlLogik;
with TasteneingabeLogik;
with NachGrafiktask;
with SpielstandAllgemeinesLogik;
with JaNeinLogik;
with SpielstandEntfernenLogik;

package body SpielstandlisteLogik is

   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String
   is begin
                  
      SpielstandSchleife:
      loop
         
         Schleifenanfang := 1;
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
               when 1 =>
                  Spielstand := (others => TextKonstanten.LeerUnboundedString);
                  
               when others =>
                  Zwischenspeicher := Spielstand (SpielstandArray'Last);
                  Spielstand := (others => TextKonstanten.LeerUnboundedString);
                  Spielstand (SpielstandArray'First) := Zwischenspeicher;
            end case;
            
            SpeicherdateiSchleife:
            for SpeicherdateiSchleifenwert in Schleifenanfang .. SpielstandArray'Last loop
               
               case
                 More_Entries (Search => Suche)
               is
                  when False =>
                     exit SpeicherdateiSchleife;
                     
                  when True =>
                     Get_Next_Entry (Search          => Suche,
                                     Directory_Entry => Spielstanddatei);
               end case;
               
               Spielstand (SpeicherdateiSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Spielstanddatei)));
               
               case
                 SpeicherdateiSchleifenwert
               is
                  when SpielstandArray'Last =>
                     NachGrafiktask.MehrereSeiten := True;
                     
                  when others =>
                     null;
               end case;
                        
            end loop SpeicherdateiSchleife;
            
            AuswahlSchleife:
            loop
               
               Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
            
               case
                 Ausgewählt
               is
                  when 0 | 14 =>
                     RückgabeWert := TextKonstanten.LeerUnboundedString;
                     exit SpielstandSchleife;
                  
                     -- Mehr
                  when 11 =>
                     if
                       Spielstand (Ausgewählt) = TextKonstanten.LeerUnboundedString
                     then
                        exit MittelSchleife;
                     
                     else
                        Schleifenanfang := 2;
                        exit AuswahlSchleife;
                     end if;
                  
                     -- Neu
                  when 12 =>
                     -- Theoretisch sollte man das niemals bei Laden aufrufen können, da die Grafik keine Position setzt. äöü
                     -- Trotzdem eine Prüfung dafür einbauen? äöü
                     -- Dann muss da aber was umgebaut werden, sonst überschreite ich die Verschachtelungstiefe. äöü
                     -- if
                     --    SpeichernLadenExtern
                     --  then
                     RückgabeWert := NameNutzer;
                     
                     if
                       RückgabeWert = TextKonstanten.LeerUnboundedString
                     then
                        null;
                        
                     else
                        exit SpielstandSchleife;
                     end if;
                     
                     --  else
                     --     null;
                     --  end if;
                  
                     -- Löschen
                  when 13 =>
                     Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
                     
                     if
                       Ausgewählt in 1 .. 10
                     then
                        SpielstandEntfernenLogik.SpielstandEntfernen (SpielstandnameExtern => To_Wide_Wide_String (Source => Spielstand (Ausgewählt)));
                        exit MittelSchleife;
                        
                     elsif
                       Ausgewählt = 14
                     then
                        RückgabeWert := TextKonstanten.LeerUnboundedString;
                        exit SpielstandSchleife;
                        
                     else
                        null;
                     end if;
                  
                  when others =>
                     RückgabeWert := Spielstand (Ausgewählt);
                     exit SpielstandSchleife;
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
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  NachGrafiktask.AktuelleAuswahl.AuswahlEins := SystemKonstanten.LeerAuswahl;
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return 0;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Mausauswahl;
   
   
   
   function NameNutzer
     return Unbounded_Wide_Wide_String
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielVariablen.Allgemeines.IronmanName) /= TextKonstanten.LeerString
      then
         Spielstandname := SpielVariablen.Allgemeines.IronmanName;
               
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

end SpielstandlisteLogik;
