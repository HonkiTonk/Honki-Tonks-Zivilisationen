with Ada.Exceptions; use Ada.Exceptions;

with KartenRecordKonstanten;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;

with LadezeitenLogik;
with LadenSichtbarkeitLogik;
with SpielstandAllgemeinesLogik;

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
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            null;
      end case;
      
      AnzahlFelder := 0;
      Koordinaten := (others => KartenRecordKonstanten.LeerKoordinate);
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               if
                 False = LadenSichtbarkeitLogik.Aufteilung (DateiLadenExtern        => DateiLadenExtern,
                                                            KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                            VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                            LadenPrüfenExtern       => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                             KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                             LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               else
                  Koordinaten (AnzahlFelder) := (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert);
                  AnzahlFelder := AnzahlFelder + 1;
               end if;
               
               case
                 AnzahlFelder
               is
                  when 8 =>
                     if
                       False = ZusatzgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                    KoordinatenExtern => Koordinaten,
                                                    LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     elsif
                       False = FlussEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                              KoordinatenExtern => Koordinaten,
                                              LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     elsif
                       False = RessourceEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                  KoordinatenExtern => Koordinaten,
                                                  LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     elsif
                       False = WegEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                            KoordinatenExtern => Koordinaten,
                                            LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     elsif
                       False = VerbesserungEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                     KoordinatenExtern => Koordinaten,
                                                     LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     elsif
                       False = StadtEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                              KoordinatenExtern => Koordinaten,
                                              LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     elsif
                       False = FeldeffekteEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                    KoordinatenExtern => Koordinaten,
                                                    LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                        
                     else
                        AnzahlFelder := 0;
                        Koordinaten := (others => KartenRecordKonstanten.LeerKoordinate);
                     end if;
                     
                  when others =>
                     null;
               end case;
                                                            
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EbeneSchleife;
      
      case
        AnzahlFelder
      is
         when 0 =>
            null;
            
         when others =>
            if
              False = ZusatzgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                           KoordinatenExtern => Koordinaten,
                                           LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                        
            elsif
              False = FlussEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                     KoordinatenExtern => Koordinaten,
                                     LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                        
            elsif
              False = RessourceEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                         KoordinatenExtern => Koordinaten,
                                         LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                        
            elsif
              False = WegEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                   KoordinatenExtern => Koordinaten,
                                   LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                        
            elsif
              False = VerbesserungEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                            KoordinatenExtern => Koordinaten,
                                            LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                        
            elsif
              False = StadtEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                     KoordinatenExtern => Koordinaten,
                                     LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                        
            elsif
              False = FeldeffekteEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                           KoordinatenExtern => Koordinaten,
                                           LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
               
            else
               null;
            end if;
      end case;
            
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end KarteLaden;
   
   
   
   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
            
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.HimmelKonstante =>
            Basisgrund := KartengrundDatentypen.Wolken_Enum;
            
         when KartenKonstanten.WeltraumKonstante =>
            Basisgrund := KartengrundDatentypen.Weltraum_Enum;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Basisgrund);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => Basisgrund);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.BasisgrundEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end BasisgrundEinlesen;
   
   
   
   function ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (ZusatzgrundSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**ZusatzgrundSchleifenwert
               then
                  KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                         Zusatzgrund);
            
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**ZusatzgrundSchleifenwert;
            
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern (ZusatzgrundSchleifenwert),
                                                       GrundExtern       => Zusatzgrund);
            
                     when False =>
                        null;
                  end case;
            
               else
                  null;
               end if;
         end case;
         
      end loop ZusatzgrundSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.ZusatzgrundEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end ZusatzgrundEinlesen;
   
   
   
   function FlussEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      FlussSchleife:
      for FlussSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (FlussSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**FlussSchleifenwert
               then
                  KartenextraDatentypen.Fluss_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                   Fluss);
            
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**FlussSchleifenwert;
            
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern (FlussSchleifenwert),
                                                 FlussExtern       => Fluss);
            
                     when False =>
                        null;
                  end case;
            
               else
                  null;
               end if;
         end case;
         
      end loop FlussSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.FlussEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FlussEinlesen;
   
   
   
   function RessourceEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      RessourceSchleife:
      for RessourceSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (RessourceSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**RessourceSchleifenwert
               then
                  KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                        Ressource);
            
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**RessourceSchleifenwert;
            
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern (RessourceSchleifenwert),
                                                     RessourceExtern   => Ressource);
            
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
         end case;
         
      end loop RessourceSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.RessourceEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end RessourceEinlesen;
   
   
   
   function WegEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      WegSchleife:
      for WegSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (WegSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**WegSchleifenwert
               then
                  KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                        Weg);
            
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**WegSchleifenwert;
            
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern (WegSchleifenwert),
                                               WegExtern         => Weg);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.WegEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end WegEinlesen;
   
   
   
   function VerbesserungEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      VerbesserungSchleife:
      for VerbesserungSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (VerbesserungSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**VerbesserungSchleifenwert
               then
                  KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                                 Verbesserung);
            
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**VerbesserungSchleifenwert;
            
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern (VerbesserungSchleifenwert),
                                                        VerbesserungExtern => Verbesserung);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
         end case;
         
      end loop VerbesserungSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.VerbesserungEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VerbesserungEinlesen;
   
   
   
   function StadtEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (StadtSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**StadtSchleifenwert
               then
                  StadtRecords.SpeziesStadtnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                                       Stadt);
            
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**StadtSchleifenwert;
            
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern (StadtSchleifenwert),
                                                         BelegterGrundExtern => (Stadt.Spezies, Stadt.Nummer));
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
         end case;
         
      end loop StadtSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.StadtEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end StadtEinlesen;
   
   
   
   function FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          VorhandeneFeldelemente);
      
      case
        VorhandeneFeldelemente
      is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in reverse KoordinatenExtern'Range loop
         
         case
           KoordinatenExtern (FeldeffekteSchleifenwert).Ebene
         is
            when KartenKonstanten.LeerEbene =>
               null;
               
            when others =>
               if
                 VorhandeneFeldelemente >= 2**FeldeffekteSchleifenwert
               then
                  SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                      VorhandeneFeldeffekte);
                  
                  VorhandeneFeldelemente := VorhandeneFeldelemente - 2**FeldeffekteSchleifenwert;
                  
                  FeldeffekteErmittelnSchleife:
                  for FeldeffekteErmittelnSchleifenwert in reverse KartenRecords.FeldeffektArray'Range loop

                     if
                       VorhandeneFeldeffekte >= AktuellerFeldeffekt
                     then
                        Feldeffekte (FeldeffekteErmittelnSchleifenwert) := True;
                        VorhandeneFeldeffekte := VorhandeneFeldeffekte - AktuellerFeldeffekt;

                     else
                        Feldeffekte (FeldeffekteErmittelnSchleifenwert) := False;
                     end if;

                     AktuellerFeldeffekt := AktuellerFeldeffekt / 2;

                  end loop FeldeffekteErmittelnSchleife;
                  
                  case
                    LadenPrüfenExtern
                  is
                     when True =>
                        SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => KoordinatenExtern (FeldeffekteSchleifenwert),
                                                           FeldeffekteExtern => Feldeffekte);
                        
                     when False =>
                        null;
                  end case;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FeldeffekteSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.FeldeffekteEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FeldeffekteEinlesen;

end LadenKarteLogik;
