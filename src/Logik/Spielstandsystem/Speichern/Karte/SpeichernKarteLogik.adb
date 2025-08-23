with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with LadezeitenDatentypen;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with SpeichernSichtbarkeitLogik;
with LadezeitenLogik;

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
                 False = Basisgrund (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                     DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  Zusatzgrund (AnzahlFelder) := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Feldeffekte (AnzahlFelder) := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
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
                  
                  AnzahlFelder := AnzahlFelder + 1;
               end if;
               
               case
                 AnzahlFelder
               is
                  when 8 =>
                     if
                       False = ZusatzgrundSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                                     DateiSpeichernExtern => DateiSpeichernExtern)
                     then
                        return False;
                        
                     else
                        null;
                     end if;
                     
                     AnzahlFelder := 0;
      
                     Zusatzgrund := (others => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
                     Feldeffekte := (others => KartenRecordKonstanten.LeerEffekte);
                     Fluss := (others => KartenextraDatentypen.Leer_Fluss_Enum);
                     Ressource := (others => KartenextraDatentypen.Leer_Ressource_Enum);
                     Weg := (others => KartenverbesserungDatentypen.Leer_Weg_Enum);
                     Verbesserung := (others => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
                     Stadt := (others => StadtKonstanten.LeerStadt);
                     
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
            null;
      end case;
      
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.HimmelKonstante | KartenKonstanten.WeltraumKonstante =>
            null;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Basisgrund: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Basisgrund;
   
   
   
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
      for ZusatzgrundSpeichernSchleifenwert in ZusatzgrundExtern'Range loop
         
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
   
   
   
   -- function FeldeffekteSchreiben (AnzahlFelder) := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
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
      for FlussSpeichernSchleifenwert in FlussExtern'Range loop
         
         case
           FlussExtern (FlussSpeichernSchleifenwert)
         is
            when KartenextraDatentypen.Leer_Fluss_Enum =>
               null;
               
            when others =>
               KartenextraDatentypen.Fluss_Enum'Write (Stream (File => DateiSpeichernExtern),
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
   
   -- Ressource (AnzahlFelder) := LeseWeltkarte.Ressource (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
   -- Weg (AnzahlFelder) := LeseWeltkarte.Weg (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
   -- Verbesserung (AnzahlFelder) := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
   -- Stadt (AnzahlFelder) := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
   
   
   
   function VorhandeneFeldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      AktuellesFeldelement := 1;
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            FeldelementeVorhanden := 0;
                     
         when others =>
            FeldelementeVorhanden := AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end if;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
                             
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end if;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           FeldelementeVorhanden);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.VorhandeneFeldelemente: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VorhandeneFeldelemente;
   
   
   
   function Feldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                               (StadtExtern.Spezies, StadtExtern.Nummer));
      end if;
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                            VerbesserungExtern);
      end case;
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   WegExtern);
      end case;
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   RessourceExtern);
      end case;
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            KartenextraDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                              FlussExtern);
      end case;
      
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         FeldeffekteVorhanden := 0;
         AktuellerFeldeffekt := 1;
         
         FeldeffekteSchleife:
         for FeldeffekteSchleifenwert in KartenRecords.FeldeffektArray'Range loop
            
            case
              FeldeffekteExtern (FeldeffekteSchleifenwert)
            is
               when True =>
                  FeldeffekteVorhanden := FeldeffekteVorhanden + AktuellerFeldeffekt;
                  
               when False =>
                  null;
            end case;
            
            AktuellerFeldeffekt := AktuellerFeldeffekt * 2;
            
         end loop FeldeffekteSchleife;
         
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              FeldeffekteVorhanden);
      end if;
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
                     
         when others =>
            KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                    ZusatzgrundExtern);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Feldelemente: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Feldelemente;

end SpeichernKarteLogik;
