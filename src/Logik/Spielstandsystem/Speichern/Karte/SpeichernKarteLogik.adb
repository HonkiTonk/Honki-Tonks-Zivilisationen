with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with LadezeitenDatentypen;

with LeseWeltkarte;
with LeseWeltkarteneinstellungen;

with SpielstandAllgemeinesLogik;
with SpeichernSichtbarkeitLogik;
with LadezeitenLogik;
with SpeichernKartenbelegungLogik;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True);
      
      AnzahlFelder := 0;
      
      Zusatzgrund := (others => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
      Feldeffekte := (others => KartenRecordKonstanten.LeerEffekte);
      Fluss := (others => KartenextraDatentypen.Leer_Fluss_Enum);
      Ressource := (others => KartenextraDatentypen.Leer_Ressource_Enum);
      Weg := (others => KartenverbesserungDatentypen.Leer_Weg_Enum);
      Verbesserung := (others => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      Stadt := (others => StadtKonstanten.LeerStadt);
                
      EbeneSchleife:
      -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               if
                 False = SpeichernSichtbarkeitLogik.Aufteilung (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                DateiSpeichernExtern    => DateiSpeichernExtern)
               then
                  return False;
                  
               elsif
                 False = SpeichernKartenbelegungLogik.Basisgrund (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                  DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  Zusatzgrund (AnzahlFelder) := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Fluss (AnzahlFelder) := LeseWeltkarte.Fluss (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Ressource (AnzahlFelder) := LeseWeltkarte.Ressource (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Weg (AnzahlFelder) := LeseWeltkarte.Weg (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Verbesserung (AnzahlFelder) := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
                  -- Stadt wird weiterhin gebraucht, da die Stadtbelegung damit auch gespeichert wird.
                  -- Aber eventuell könnte man das mit der Stadt speichern? äöü
                  -- Wäre dann kleiner als wenn man das in der Karte speichert. äöü
                  -- Aber dann müsste man wieder durch alle Städte gehen um zu prüfen ob das Feld von einer Stadt belegt ist. äöü
                  -- Man könnte natürlich beides haben und nur den Stadtteil speichern. äöü
                  -- Erhöht natürlich den AS Verbrauch, mal drüber nachdenken. äöü
                  Stadt (AnzahlFelder) := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Feldeffekte (AnzahlFelder) := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
                  AnzahlFelder := AnzahlFelder + 1;
               end if;
               
               case
                 AnzahlFelder
               is
                  when 8 =>
                     if
                       SpeichernKartenbelegungLogik.Aufteilung = False
                     then
                        return False;
                        
                     else
                        null;
                     end if;
                     
                     if
                       False = ZusatzgrundSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                                     DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     elsif
                       False = FlussSchreiben (FlussExtern          => Fluss,
                                               DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     elsif
                       False = RessourceSchreiben (RessourceExtern      => Ressource,
                                                   DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     elsif
                       False = WegSchreiben (WegExtern            => Weg,
                                             DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     elsif
                       False = VerbesserungSchreiben (VerbesserungExtern   => Verbesserung,
                                                      DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     elsif
                       False = StadtSchreiben (StadtExtern          => Stadt,
                                               DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     elsif
                       False = FeldeffekteSchreiben (FeldeffekteExtern    => Feldeffekte,
                                                     DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     else
                        AnzahlFelder := 0;
      
                        Zusatzgrund := (others => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
                        Fluss := (others => KartenextraDatentypen.Leer_Fluss_Enum);
                        Ressource := (others => KartenextraDatentypen.Leer_Ressource_Enum);
                        Weg := (others => KartenverbesserungDatentypen.Leer_Weg_Enum);
                        Verbesserung := (others => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
                        Stadt := (others => StadtKonstanten.LeerStadt);
                        Feldeffekte := (others => KartenRecordKonstanten.LeerEffekte);
                     end if;
                     
                  when others =>
                     null;
               end case;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         case
           AutospeichernExtern
         is
            when False =>
               null;
               
            when True =>
               LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
                                          ErhöhungExtern              => 20);
         end case;
         
         -- SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
      
      case
        AnzahlFelder
      is
         when 0 =>
            null;
            
         when others =>
            if
              False = ZusatzgrundSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                            DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            elsif
              False = FlussSchreiben (FlussExtern          => Fluss,
                                      DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            elsif
              False = RessourceSchreiben (RessourceExtern      => Ressource,
                                          DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            elsif
              False = WegSchreiben (WegExtern            => Weg,
                                    DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            elsif
              False = VerbesserungSchreiben (VerbesserungExtern   => Verbesserung,
                                             DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            elsif
              False = StadtSchreiben (StadtExtern          => Stadt,
                                      DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            elsif
              False = FeldeffekteSchreiben (FeldeffekteExtern    => Feldeffekte,
                                            DateiSpeichernExtern => DateiSpeichernExtern)
            then
               return False;
                        
            else
               null;
            end if;
      end case;
      
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
   function ZusatzgrundSchreiben
     (ZusatzgrundExtern : in ZusatzgrundArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in ZusatzgrundExtern'Range loop
         
         case
           ZusatzgrundExtern (ZusatzgrundSchleifenwert)
         is
            when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
               null;
               
            when others =>
               FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end case;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop ZusatzgrundSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      ZusatzgrundSpeichernSchleife:
      for ZusatzgrundSpeichernSchleifenwert in reverse ZusatzgrundExtern'Range loop
         
         case
           ZusatzgrundExtern (ZusatzgrundSpeichernSchleifenwert)
         is
            when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
               null;
               
            when others =>
               KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                       ZusatzgrundExtern (ZusatzgrundSpeichernSchleifenwert));
         end case;
         
      end loop ZusatzgrundSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.ZusatzgrundSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end ZusatzgrundSchreiben;
   
   
   
   function FlussSchreiben
     (FlussExtern : in FlussArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      FlussSchleife:
      for FlussSchleifenwert in FlussExtern'Range loop
         
         case
           FlussExtern (FlussSchleifenwert)
         is
            when KartenextraDatentypen.Leer_Fluss_Enum =>
               null;
               
            when others =>
               FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end case;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop FlussSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      FlussSpeichernSchleife:
      for FlussSpeichernSchleifenwert in reverse FlussExtern'Range loop
         
         case
           FlussExtern (FlussSpeichernSchleifenwert)
         is
            when KartenextraDatentypen.Leer_Fluss_Enum =>
               null;
               
            when others =>
               KartenextraDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                 FlussExtern (FlussSpeichernSchleifenwert));
         end case;
         
      end loop FlussSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.FlussSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FlussSchreiben;
   
   
   
   function RessourceSchreiben
     (RessourceExtern : in RessourceArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      RessourceSchleife:
      for RessourceSchleifenwert in RessourceExtern'Range loop
         
         case
           RessourceExtern (RessourceSchleifenwert)
         is
            when KartenextraDatentypen.Leer_Ressource_Enum =>
               null;
               
            when others =>
               FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end case;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop RessourceSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      RessourceSpeichernSchleife:
      for RessourceSpeichernSchleifenwert in reverse RessourceExtern'Range loop
         
         case
           RessourceExtern (RessourceSpeichernSchleifenwert)
         is
            when KartenextraDatentypen.Leer_Ressource_Enum =>
               null;
               
            when others =>
               KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                      RessourceExtern (RessourceSpeichernSchleifenwert));
         end case;
         
      end loop RessourceSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.RessourceSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end RessourceSchreiben;
   
   
   
   function WegSchreiben
     (WegExtern : in WegArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      WegSchleife:
      for WegSchleifenwert in WegExtern'Range loop
         
         case
           WegExtern (WegSchleifenwert)
         is
            when KartenverbesserungDatentypen.Leer_Weg_Enum =>
               null;
               
            when others =>
               FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end case;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop WegSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      WegSpeichernSchleife:
      for WegSpeichernSchleifenwert in reverse WegExtern'Range loop
         
         case
           WegExtern (WegSpeichernSchleifenwert)
         is
            when KartenverbesserungDatentypen.Leer_Weg_Enum =>
               null;
               
            when others =>
               KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                      WegExtern (WegSpeichernSchleifenwert));
         end case;
         
      end loop WegSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.WegSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end WegSchreiben;
   
   
   
   function VerbesserungSchreiben
     (VerbesserungExtern : in VerbesserungArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      VerbesserungSchleife:
      for VerbesserungSchleifenwert in VerbesserungExtern'Range loop
         
         case
           VerbesserungExtern (VerbesserungSchleifenwert)
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end case;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop VerbesserungSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      VerbesserungSpeichernSchleife:
      for VerbesserungSpeichernSchleifenwert in reverse VerbesserungExtern'Range loop
         
         case
           VerbesserungExtern (VerbesserungSpeichernSchleifenwert)
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                               VerbesserungExtern (VerbesserungSpeichernSchleifenwert));
         end case;
         
      end loop VerbesserungSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.VerbesserungSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end VerbesserungSchreiben;
   
   
   
   function StadtSchreiben
     (StadtExtern : in StadtArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtExtern'Range loop
         
         if
           StadtExtern (StadtSchleifenwert) = StadtKonstanten.LeerStadt
         then
            null;
               
         else
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end if;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop StadtSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      StadtSpeichernSchleife:
      for StadtSpeichernSchleifenwert in reverse StadtExtern'Range loop
         
         if
           StadtExtern (StadtSpeichernSchleifenwert) = StadtKonstanten.LeerStadt
         then
            null;
               
         else
            StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                                  (StadtExtern (StadtSpeichernSchleifenwert).Spezies, StadtExtern (StadtSpeichernSchleifenwert).Nummer));
         end if;
         
      end loop StadtSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.StadtSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end StadtSchreiben;
   
   
   
   function FeldeffekteSchreiben
     (FeldeffekteExtern : in FeldeffekteArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
      use type KartenRecords.FeldeffektArray;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in FeldeffekteExtern'Range loop
         
         if
           FeldeffekteExtern (FeldeffekteSchleifenwert) = KartenRecordKonstanten.LeerEffekte
         then
            null;
               
         else
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end if;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop FeldeffekteSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      case
        FeldelementeVorhanden
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
         
      FeldeffekteSpeichernSchleife:
      for FeldeffekteSpeichernSchleifenwert in reverse FeldeffekteExtern'Range loop
      
         if
           FeldeffekteExtern (FeldeffekteSpeichernSchleifenwert) = KartenRecordKonstanten.LeerEffekte
         then
            null;
               
         else
            FeldeffekteVorhanden := 0;
            AktuellerFeldeffekt := 1;
         
            FeldeffekteDurchgehenSchleife:
            for FeldeffekteDurchgehenSchleifenwert in KartenRecords.FeldeffektArray'Range loop
            
               case
                 FeldeffekteExtern (FeldeffekteSpeichernSchleifenwert) (FeldeffekteDurchgehenSchleifenwert)
               is
                  when True =>
                     FeldeffekteVorhanden := FeldeffekteVorhanden + AktuellerFeldeffekt;
                  
                  when False =>
                     null;
               end case;
            
               AktuellerFeldeffekt := AktuellerFeldeffekt * 2;
            
            end loop FeldeffekteDurchgehenSchleife;
         
            SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                                 FeldeffekteVorhanden);
         end if;
         
      end loop FeldeffekteSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.FeldeffekteSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end FeldeffekteSchreiben;

end SpeichernKarteLogik;
