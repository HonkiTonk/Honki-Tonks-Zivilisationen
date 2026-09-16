with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenRecordKonstanten;
with StadtKonstanten;

with LeseWeltkarte;

package body SpeichernZusatzbelegungLogik is
   
   procedure Leersetzung
   is begin
      
      Zusatzgrund := (others => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum);
      Feldeffekte := (others => KartenRecordKonstanten.LeerEffekte);
      Fluss := (others => KartenfluesseDatentypen.Leer_Fluss_Enum);
      Rohstoffe := (others => KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum);
      Weg := (others => KartenwegeDatentypen.Leer_Weg_Enum);
      Verbesserung := (others => KartenverbesserungDatentypen.Leer_Verbesserungen_Enum);
      Stadt := (others => StadtKonstanten.LeerStadt);
      
   end Leersetzung;
   
   
   
   procedure ZusätzeAbfragen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive)
   is begin
      
      Zusatzgrund (FelderanzahlExtern) := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      Fluss (FelderanzahlExtern) := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      Rohstoffe (FelderanzahlExtern) := LeseWeltkarte.Rohstoff (KoordinatenExtern => KoordinatenExtern);
      Weg (FelderanzahlExtern) := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      Verbesserung (FelderanzahlExtern) := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
                  
      -- Stadt wird weiterhin gebraucht, da die Stadtbelegung damit auch gespeichert wird.
      -- Aber eventuell könnte man das mit der Stadt speichern? äöü
      -- Wäre dann kleiner als wenn man das in der Karte speichert. äöü
      -- Aber dann müsste man wieder durch alle Städte gehen um zu prüfen ob das Feld von einer Stadt belegt ist. äöü
      -- Man könnte natürlich beides haben und nur den Stadtteil speichern. äöü
      -- Erhöht natürlich den AS Verbrauch, mal drüber nachdenken. äöü
      Stadt (FelderanzahlExtern) := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      Feldeffekte (FelderanzahlExtern) := LeseWeltkarte.Feldeffekte (KoordinatenExtern => KoordinatenExtern);
      
   end ZusätzeAbfragen;
   
   

   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
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
        False = RohstoffSchreiben (RohstoffeExtern       => Rohstoffe,
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
         return True;
      end if;
      
   end Aufteilung;
   
   
   
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
            when KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum =>
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
            when KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum =>
               null;
               
            when others =>
               KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                             ZusatzgrundExtern (ZusatzgrundSpeichernSchleifenwert));
         end case;
         
      end loop ZusatzgrundSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.ZusatzgrundSchreiben: Konnte nicht gespeichert werden: "
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
            when KartenfluesseDatentypen.Leer_Fluss_Enum =>
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
            when KartenfluesseDatentypen.Leer_Fluss_Enum =>
               null;
               
            when others =>
               KartenfluesseDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   FlussExtern (FlussSpeichernSchleifenwert));
         end case;
         
      end loop FlussSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.FlussSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FlussSchreiben;
   
   
   
   function RohstoffSchreiben
     (RohstoffeExtern : in RohstoffeArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      FeldelementeVorhanden := 0;
      AktuellesFeldelement := 1;
      
      RohstoffSchleife:
      for RohstoffSchleifenwert in RohstoffeExtern'Range loop
         
         case
           RohstoffeExtern (RohstoffSchleifenwert)
         is
            when KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum =>
               null;
               
            when others =>
               FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
         end case;
         
         AktuellesFeldelement := AktuellesFeldelement * 2;
         
      end loop RohstoffSchleife;
      
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
      
      RohstoffSpeichernSchleife:
      for RohstoffSpeichernSchleifenwert in reverse RohstoffeExtern'Range loop
         
         case
           RohstoffeExtern (RohstoffSpeichernSchleifenwert)
         is
            when KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum =>
               null;
               
            when others =>
               KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                         RohstoffeExtern (RohstoffSpeichernSchleifenwert));
         end case;
         
      end loop RohstoffSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.RohstoffSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end RohstoffSchreiben;
   
   
   
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
            when KartenwegeDatentypen.Leer_Weg_Enum =>
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
            when KartenwegeDatentypen.Leer_Weg_Enum =>
               null;
               
            when others =>
               KartenwegeDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                              WegExtern (WegSpeichernSchleifenwert));
         end case;
         
      end loop WegSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.WegSchreiben: Konnte nicht gespeichert werden: "
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
            when KartenverbesserungDatentypen.Leer_Verbesserungen_Enum =>
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
            when KartenverbesserungDatentypen.Leer_Verbesserungen_Enum =>
               null;
               
            when others =>
               KartenverbesserungDatentypen.Verbesserungen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                                 VerbesserungExtern (VerbesserungSpeichernSchleifenwert));
         end case;
         
      end loop VerbesserungSpeichernSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.VerbesserungSchreiben: Konnte nicht gespeichert werden: "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.StadtSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end StadtSchreiben;
   
   
   
   function FeldeffekteSchreiben
     (FeldeffekteExtern : in FeldeffekteArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
      use type KartenArrays.FeldeffektArray;
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
            for FeldeffekteDurchgehenSchleifenwert in KartenArrays.FeldeffektArray'Range loop
            
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernZusatzbelegungLogik.FeldeffekteSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end FeldeffekteSchreiben;

end SpeichernZusatzbelegungLogik;
