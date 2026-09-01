with Ada.Exceptions; use Ada.Exceptions;

with LadezeitenLogik;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with KartenRecordKonstanten;
with LadezeitenDatentypen;

with SchreibeWeltkarteneinstellungen;

with LadenSichtbarkeitLogik;
with SpielstandAllgemeinesLogik;
with LadenBasisgrundLogik;
with LadenZusatzbelegungLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenKarteLogik is
   
   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => False);
      
      case
        VorhandeneSpezies
      is
         when 1 .. 8 =>
            LadezeitSichtbarkeitBasiswert := 100.00 / (5.00 * Float (Karteneinstellungen.Kartengröße.Senkrechte));
            LadezeitSichtbarkeit := LadezeitSichtbarkeitBasiswert;
            
         when others =>
            null;
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            null;
      end case;
      
      FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
      LadenZusatzbelegungLogik.Leersetzung;
      
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      KoordinatenFestgelegt := (others => KartenRecordKonstanten.LeerKoordinate);
      
      LadezeitKarteBasiswert := 100.00 / (5.00 * Float (Karteneinstellungen.Kartengröße.Senkrechte));
      LadezeitKarte := LadezeitKarteBasiswert;
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               case
                 LadenBasisgrundLogik.BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                          KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                          KartenfeldExtern  => Karteneinstellungen.Kartengröße,
                                                          LadenPrüfenExtern => LadenPrüfenExtern)
               is
                  when False =>
                     return False;
                     
                  when True =>
                     LadenZusatzbelegungLogik.KoordinatenSetzen (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                 FelderanzahlExtern => FelderanzahlZusatzgrund);
                     FelderanzahlZusatzgrund := FelderanzahlZusatzgrund + 1;
               end case;
               
               if
                 FelderanzahlZusatzgrund <= SystemDatentypenHTSEB.AchtElemente'Last
               then
                  null;
                  
               elsif
                 False = LadenZusatzbelegungLogik.Aufteilung (DateiLadenExtern  => DateiLadenExtern,
                                                              LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                        
               else
                  FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
                  LadenZusatzbelegungLogik.Leersetzung;
               end if;
               
               case
                 VorhandeneSpezies
               is
                  when 1 .. 8 =>
                     KoordinatenFestgelegt (FelderanzahlSichtbarkeit) := (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert);
                     
                     FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
                     if
                       FelderanzahlSichtbarkeit <= SystemDatentypenHTSEB.AchtElemente'Last
                     then
                        null;
                        
                     elsif
                       False = LadenSichtbarkeitLogik.Felderreihe (DateiLadenExtern  => DateiLadenExtern,
                                                                   KoordinatenExtern => KoordinatenFestgelegt,
                                                                   LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                           
                     else
                        FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                        KoordinatenFestgelegt := (others => KartenRecordKonstanten.LeerKoordinate);
                     end if;
                     
                  when others =>
                     null;
               end case;
                                                            
            end loop WaagerechteSchleife;
         
            LadezeitenLogik.SpeichernLaden (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
                                            ZeitExtern                  => SystemDatentypenHTSEB.NullBisHundert (LadezeitKarte));
            
            LadezeitKarte := Ladezeittest (BasiswertExtern  => LadezeitKarte,
                                           ZusatzwertExtern => LadezeitKarteBasiswert);
            
            case
              VorhandeneSpezies
            is
               when 1 .. 8 =>
                  LadezeitenLogik.SpeichernLaden (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Sichtbarkeit_Enum,
                                                  ZeitExtern                  => SystemDatentypenHTSEB.NullBisHundert (LadezeitSichtbarkeit));
            
                  LadezeitSichtbarkeit := Ladezeittest (BasiswertExtern  => LadezeitSichtbarkeit,
                                                        ZusatzwertExtern => LadezeitSichtbarkeitBasiswert);
            
               when others =>
                  null;
            end case;
            
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
            
      LadezeitenLogik.SpeichernLadenMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      if
        FelderanzahlZusatzgrund = SystemDatentypenHTSEB.AchtElemente'First
      then
         null;
         
      elsif
        False = LadenZusatzbelegungLogik.Aufteilung (DateiLadenExtern  => DateiLadenExtern,
                                                     LadenPrüfenExtern => LadenPrüfenExtern)
      then
         return False;
                                               
      else
         null;
      end if;
      
      case
        VorhandeneSpezies
      is
         when 1 .. 8 =>
            if
              FelderanzahlSichtbarkeit = SystemDatentypenHTSEB.AchtElemente'First
            then
               null;
               
            elsif
              False = LadenSichtbarkeitLogik.Felderreihe (DateiLadenExtern  => DateiLadenExtern,
                                                          KoordinatenExtern => KoordinatenFestgelegt,
                                                          LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                           
            else
               null;
            end if;
            
            LadezeitenLogik.SpeichernLadenMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Sichtbarkeit_Enum);
            
            return True;
            
         when others =>
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                SichtbarkeitLadeaufteilung);
      end case;
      
      -- Die 0/1 in ein Enum umbasteln? äöü
      case
        SichtbarkeitLadeaufteilung
      is
         when 0 =>
            return Felderzusammenfassung (LadenPrüfenExtern => LadenPrüfenExtern,
                                          DateiLadenExtern  => DateiLadenExtern);
            
         when 1 =>
            return Spezieszusammenfassung (LadenPrüfenExtern => LadenPrüfenExtern,
                                           DateiLadenExtern  => DateiLadenExtern);
            
         when others =>
            return False;
      end case;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end KarteLaden;
   
   
   
   function Felderzusammenfassung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      KoordinatenFestgelegt := (others => KartenRecordKonstanten.LeerKoordinate);
      
      LadezeitSichtbarkeitBasiswert := 100.00 / (5.00 * Float (Karteneinstellungen.Kartengröße.Senkrechte));
      LadezeitSichtbarkeit := LadezeitSichtbarkeitBasiswert;
            
      EbeneSchleife:
      -- Warum loope ich da nicht direkt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               KoordinatenFestgelegt (FelderanzahlSichtbarkeit) := (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert);
                     
               FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
               if
                 FelderanzahlSichtbarkeit <= SystemDatentypenHTSEB.AchtElemente'Last
               then
                  null;
                        
               elsif
                 False = LadenSichtbarkeitLogik.Felderreihe (DateiLadenExtern  => DateiLadenExtern,
                                                             KoordinatenExtern => KoordinatenFestgelegt,
                                                             LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                           
               else
                  FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                  KoordinatenFestgelegt := (others => KartenRecordKonstanten.LeerKoordinate);
               end if;
               
            end loop WaagerechteSchleife;
            
            LadezeitenLogik.SpeichernLaden (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Sichtbarkeit_Enum,
                                            ZeitExtern                  => SystemDatentypenHTSEB.NullBisHundert (LadezeitSichtbarkeit));
            
            LadezeitSichtbarkeit := Ladezeittest (BasiswertExtern  => LadezeitSichtbarkeit,
                                                  ZusatzwertExtern => LadezeitSichtbarkeitBasiswert);
            
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
            
      if
        FelderanzahlSichtbarkeit = SystemDatentypenHTSEB.AchtElemente'First
      then
         null;
               
      elsif
        False = LadenSichtbarkeitLogik.Felderreihe (DateiLadenExtern  => DateiLadenExtern,
                                                    KoordinatenExtern => KoordinatenFestgelegt,
                                                    LadenPrüfenExtern => LadenPrüfenExtern)
      then
         return False;
                           
      else
         null;
      end if;
            
      LadezeitenLogik.SpeichernLadenMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Sichtbarkeit_Enum);
            
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.Felderzusammenfassung: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Felderzusammenfassung;
   
   
   
   function Spezieszusammenfassung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      LadezeitSichtbarkeitBasiswert := 100.00 / (5.00 * Float (Karteneinstellungen.Kartengröße.Senkrechte));
      LadezeitSichtbarkeit := LadezeitSichtbarkeitBasiswert;
      
      EbeneSchleife:
      -- Warum loope ich da nicht direkt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               case
                 LadenSichtbarkeitLogik.AufteilungSpezieszeile (DateiLadenExtern        => DateiLadenExtern,
                                                                KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                LadenPrüfenExtern       => LadenPrüfenExtern)
               is
                  when False =>
                     return False;
                     
                  when True =>
                     null;
               end case;
                     
            end loop WaagerechteSchleife;
            
            LadezeitenLogik.SpeichernLaden (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Sichtbarkeit_Enum,
                                   ZeitExtern                  => SystemDatentypenHTSEB.NullBisHundert (LadezeitSichtbarkeit));
            
            LadezeitSichtbarkeit := Ladezeittest (BasiswertExtern  => LadezeitSichtbarkeit,
                                                  ZusatzwertExtern => LadezeitSichtbarkeitBasiswert);
            
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
            
      LadezeitenLogik.SpeichernLadenMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Sichtbarkeit_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.Spezieszusammenfassung: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Spezieszusammenfassung;
   
   
   
   function Ladezeittest
     (BasiswertExtern : in Float;
      ZusatzwertExtern : in Float)
      return Float
   is begin
      
      if
        BasiswertExtern + ZusatzwertExtern > 100.00
      then
         return 100.00;
               
      else
         return BasiswertExtern + ZusatzwertExtern;
      end if;
      
   end Ladezeittest;
   

end LadenKarteLogik;
