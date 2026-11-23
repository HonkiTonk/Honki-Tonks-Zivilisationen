with ZufallsgeneratorenHTSEB;

with LeseWeltkarte;

with Zusatzgrundplatzierungssystem;

package body KartengeneratorZusatzlandschaftLogik is
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
   is begin
            
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      case
        Basisgrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Eis_Enum'Range =>
            return;
            
         when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
            Zusatzgrund := Wasserbestimmung;
            
         when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
            Zusatzgrund := Landbestimmung (TemperaturExtern => TemperaturExtern,
                                           BasisgrundExtern => Basisgrund);
      end case;
      
      case
        Zusatzgrund
      is
         when KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum'Range =>
            Zusatzgrundplatzierungssystem.Zusatzgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                  ZusatzgrundExtern => Zusatzgrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function Wasserbestimmung
     return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in WassergrundwahrscheinlichkeitenArray'Range loop
         
         if
           GezogeneZahl in Wassergrundwahrscheinlichkeiten (ZusatzgrundSchleifenwert).Anfangswahrscheinlichkeit .. Wassergrundwahrscheinlichkeiten (ZusatzgrundSchleifenwert).Endwahrscheinlichkeit
         then
            Wasserzusatz := ZusatzgrundSchleifenwert;
            exit ZusatzgrundSchleife;
            
         else
            null;
         end if;
         
      end loop ZusatzgrundSchleife;
      
      case
        Wasserzusatz
      is
         when Leer_Enum =>
            return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
            
         when others =>
            return Wasserumwandlung (Wasserzusatz);
      end case;
      
   end Wasserbestimmung;
   
   
   
   function Landbestimmung
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum;
      BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
   
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in LandgrundwahrscheinlichkeitenArray'Range (2) loop
         
         if
           GezogeneZahl in Landgrundwahrscheinlichkeiten (TemperaturExtern, ZusatzgrundSchleifenwert).Anfangswahrscheinlichkeit
           .. Landgrundwahrscheinlichkeiten (TemperaturExtern, ZusatzgrundSchleifenwert).Endwahrscheinlichkeit
         then
            Landzusatz := ZusatzgrundSchleifenwert;
            exit ZusatzgrundSchleife;
            
         else
            null;
         end if;
                  
      end loop ZusatzgrundSchleife;
            
      case
        Landzusatz
      is
         when Leer_Enum =>
            return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
            
         when others =>
            return ZusatzExtraberechnungen (GesamtgrundExtern => (BasisgrundExtern, Landumwandlung (Landzusatz)));
      end case;
      
   end Landbestimmung;
   
   
   
   function ZusatzExtraberechnungen
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GesamtgrundExtern.Zusatzgrund
      is
         when KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range =>
            return ZusatzberechnungWald (GesamtgrundExtern => GesamtgrundExtern);
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum'Range =>
            return ZusatzberechnungDschungel (GesamtgrundExtern => GesamtgrundExtern);
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum'Range =>
            return ZusatzberechnungSumpf (GesamtgrundExtern => GesamtgrundExtern);
            
         when others =>
            return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
      end case;
   
   end ZusatzExtraberechnungen;
   
   
   
   -- Arktis_Enum, Tundra_Enum, Grasland_Enum, Steppe_Enum, Savanne_Enum, Wüste_Enum
   function ZusatzberechnungWald
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GesamtgrundExtern.Basisgrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Arktis_Enum'Range =>
            return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
         
         when others =>
            return GesamtgrundExtern.Zusatzgrund;
      end case;
      
   end ZusatzberechnungWald;
   
   
   
   -- Arktis_Enum, Tundra_Enum, Grasland_Enum, Steppe_Enum, Savanne_Enum, Wüste_Enum
   function ZusatzberechnungDschungel
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GesamtgrundExtern.Basisgrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Arktis_Enum'Range =>
            return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
         
         when others =>
            return GesamtgrundExtern.Zusatzgrund;
      end case;
            
   end ZusatzberechnungDschungel;
   
   
   
   -- Arktis_Enum, Tundra_Enum, Grasland_Enum, Steppe_Enum, Savanne_Enum, Wüste_Enum
   function ZusatzberechnungSumpf
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GesamtgrundExtern.Basisgrund
      is
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Arktis_Enum'Range =>
            return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
         
         when others =>
            return GesamtgrundExtern.Zusatzgrund;
      end case;
      
   end ZusatzberechnungSumpf;

end KartengeneratorZusatzlandschaftLogik;
