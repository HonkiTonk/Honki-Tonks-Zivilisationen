with TastenbelegungDatentypen;
with MenueDatentypen;
with GrafikDatentypen;
with TextnummernKonstanten;
with TextKonstanten;
with AuswahlKonstanten;
with TextArrays;
with MenueKonstanten;
with SpielstandVariablen;
with SystemDatentypen;

with LeseAllgemeines;
with SchreibeGrafiktask;

with MausauswahlLogik;
with TasteneingabeLogik;
with SpielstandAllgemeinesLogik;
with JaNeinLogik;
with SpielstandEntfernenLogik;
with UmwandlungenVerzeichnisse;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;

package body SpielstandlisteLogik is

   -- Noch einen Weg finden die Spielstände nach Datum/Name zu sortieren. äöü
   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String
   is begin
      
      LöschenAktiv := False;
            
      SpielstandSchleife:
      loop
         
         Schleifenanfang := TextArrays.SpielstandArray'First;
         SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => False);
         
         Start_Search (Search    => Suche,
                       Directory => UmwandlungenVerzeichnisse.Verzeichnispfad (SpielstandarteExtern => SpielstandVariablen.SpielstandartLesen),
                       Pattern   => "",
                       Filter    => (Ordinary_File => True,
                                     others        => False));
         
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
               
               SpielstandVariablen.SpielstandnameSchreiben (NameExtern   => UmwandlungenAdaEigenes.EigenesDecodeUnbounded (TextExtern => Simple_Name (Directory_Entry => Spielstanddatei)),
                                                            NummerExtern => AktuellerSpielstand);
               
               if
                 -- Wird diese Prüfung hier so überhaupt gebraucht? äöü
                 -- Eventuell bis Wide_Wide_Directories? äöü
                 VerzeichnisDateinamenTests.GültigerNamen (NameExtern => To_Wide_Wide_String (Source => SpielstandVariablen.SpielstandnameLesen (NummerExtern => AktuellerSpielstand))) = False
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
               
               case
                 LöschenAktiv
               is
                  when False =>
                     Ausgewählt := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
                     
                  when True =>
                     Ausgewählt := AuswahlKonstanten.Löschen;
               end case;
               
               case
                 Ausgewählt
               is
                  when AuswahlKonstanten.LeerAuswahl | AuswahlKonstanten.Zurück =>
                     RückgabeWert := TextKonstanten.LeerUnboundedString;
                     exit SpielstandSchleife;
                     
                  when AuswahlKonstanten.MehrAnzeigen =>
                     if
                       SpielstandVariablen.SpielstandnameLesen (NummerExtern => Ausgewählt) = TextKonstanten.LeerUnboundedString
                     then
                        exit MittelSchleife;
                     
                     else
                        -- Schleifenanfang muss hier auf einen Wert ungleich SpielstandVariablen.SpielstandArray'First gesetzt werden, damit bei mehreren Seiten es korrekt weitergeht.
                        Schleifenanfang := TextArrays.SpielstandArray'First + 1;
                        exit AuswahlSchleife;
                     end if;
                  
                  when AuswahlKonstanten.NeuerSpielstand =>
                     RückgabeWert := NameNutzer;
                     
                     if
                       RückgabeWert = TextKonstanten.LeerUnboundedString
                     then
                        null;
                        
                     else
                        exit SpielstandSchleife;
                     end if;
                     
                  when AuswahlKonstanten.Löschen =>
                     LöschenAktiv := True;
                     SchreibeGrafiktask.Löschauswahl (JaNeinExtern => True);
                     Löschauswahl := Mausauswahl (SpeichernLadenExtern => SpeichernLadenExtern);
                     
                     if
                       Löschauswahl in AuswahlKonstanten.SpielstandlisteAnfang .. AuswahlKonstanten.SpielstandlisteEnde
                     then
                        SpielstandEntfernenLogik.SpielstandEntfernen (SpielstandnameExtern => SpielstandVariablen.SpielstandnameLesen (NummerExtern => Löschauswahl),
                                                                      ManuellAutoExtern    => SpielstandVariablen.SpielstandartLesen);
                        exit MittelSchleife;
                        
                     elsif
                       Löschauswahl = AuswahlKonstanten.MehrAnzeigen
                       and then
                         SpielstandVariablen.SpielstandnameLesen (NummerExtern => Löschauswahl) = TextKonstanten.LeerUnboundedString
                     then
                        exit MittelSchleife;
                     
                     elsif
                       Löschauswahl = AuswahlKonstanten.MehrAnzeigen
                     then
                        -- Schleifenanfang muss hier auf einen Wert ungleich SpielstandVariablen.SpielstandArray'First gesetzt werden, damit bei mehreren Seiten es korrekt weitergeht.
                        Schleifenanfang := TextArrays.SpielstandArray'First + 1;
                        exit AuswahlSchleife;
                        
                     elsif
                       Löschauswahl = AuswahlKonstanten.Zurück
                     then
                        LöschenAktiv := False;
                        RückgabeWert := TextKonstanten.LeerUnboundedString;
                        SchreibeGrafiktask.Löschauswahl (JaNeinExtern => False);
                        exit SpielstandSchleife;
                        
                     elsif
                       Löschauswahl = AuswahlKonstanten.ManuellerSpielstand
                     then
                        SpielstandVariablen.SpielstandartSchreiben (SpielstandartExtern => SystemDatentypen.Manueller_Spielstand_Enum);
                        End_Search (Search => Suche);
                        exit MittelSchleife;
                     
                     elsif
                       Löschauswahl = AuswahlKonstanten.AutomatischerSpielstand
                     then
                        SpielstandVariablen.SpielstandartSchreiben (SpielstandartExtern => SystemDatentypen.Automatischer_Spielstand_Enum);
                        End_Search (Search => Suche);
                        exit MittelSchleife;
                        
                     else
                        LöschenAktiv := False;
                        SchreibeGrafiktask.Löschauswahl (JaNeinExtern => False);
                     end if;
                     
                  when AuswahlKonstanten.ManuellerSpielstand =>
                     SpielstandVariablen.SpielstandartSchreiben (SpielstandartExtern => SystemDatentypen.Manueller_Spielstand_Enum);
                     End_Search (Search => Suche);
                     exit MittelSchleife;
                     
                  when AuswahlKonstanten.AutomatischerSpielstand =>
                     SpielstandVariablen.SpielstandartSchreiben (SpielstandartExtern => SystemDatentypen.Automatischer_Spielstand_Enum);
                     End_Search (Search => Suche);
                     exit MittelSchleife;
                                       
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
      
      End_Search (Search => Suche);
      
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
           AktuelleAuswahl < AuswahlKonstanten.LeerAuswahl
         then
            SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
            SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AktuelleAuswahl);
            
         elsif
           AktuelleAuswahl > AuswahlKonstanten.LeerAuswahl
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
                  return AktuelleAuswahl - MenueKonstanten.SpielstandausgleichLogikGrafik;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
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
         return LeseAllgemeines.Ironman;
               
      else
         Spielstandname := SpielstandAllgemeinesLogik.SpielstandNameErmitteln;
      end if;
         
      if
        Spielstandname = TextKonstanten.LeerUnboundedString
      then
         null;
            
      elsif
        False = SpielstandAllgemeinesLogik.SpielstandVorhanden (SpielstandnameExtern => Spielstandname,
                                                                SpielstandartExtern  => SystemDatentypen.Manueller_Spielstand_Enum)
      then
         null;
            
      elsif
        True = JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageSpielstandÜberschreiben)
      then
         null;
                     
      else
         Spielstandname := TextKonstanten.LeerUnboundedString;
      end if;
      
      return Spielstandname;
      
   end NameNutzer;

end SpielstandlisteLogik;
