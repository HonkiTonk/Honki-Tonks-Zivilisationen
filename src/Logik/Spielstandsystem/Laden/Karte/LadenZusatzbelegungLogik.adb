with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenRecordKonstanten;
with KartenKonstanten;

with SchreibeWeltkarte;

package body LadenZusatzbelegungLogik is

   procedure Leersetzung
   is begin
            
      Koordinaten := (others => KartenRecordKonstanten.LeerKoordinate);
      
   end Leersetzung;
   
   
   
   procedure KoordinatenSetzen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive)
   is begin
      
      Koordinaten (FelderanzahlExtern) := KoordinatenExtern;
      
   end KoordinatenSetzen;
   
   
   
   function Aufteilung
     (DateiLadenExtern : in File_Type;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
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
         return True;
      end if;
      
   end Aufteilung;
   
   
   
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.ZusatzgrundEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.FlussEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.RessourceEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.WegEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.VerbesserungEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.StadtEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenZusatzbelegungLogik.FeldeffekteEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FeldeffekteEinlesen;

end LadenZusatzbelegungLogik;
