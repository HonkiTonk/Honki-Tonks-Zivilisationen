with ZufallsgeneratorenHTSEB;

with LeseWeltkarte;

with Zusatzgrundplatzierungssystem;

package body KartengeneratorWasserweltLogik is
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
   is begin
            
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      -- case
      --   Basisgrund
      -- is
      --    when KartenbasisgrundDatentypen.Untereis_Enum =>
      --       return;
            
      --    when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
      Zusatzgrund := Wasserbestimmung (TemperaturExtern => TemperaturExtern);
      
      --   when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
      --      Zusatzgrund := Landbestimmung (TemperaturExtern => TemperaturExtern,
      --                                      BasisgrundExtern => Basisgrund);
      -- end case;
      
      case
        Zusatzgrund
      is
         when KartenzusatzgrundDatentypen.Zusatzgrund_Unterfläche_Enum'Range =>
            Zusatzgrundplatzierungssystem.Zusatzgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                  ZusatzgrundExtern => Zusatzgrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function Wasserbestimmung
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
     return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in WassergrundwahrscheinlichkeitenArray'Range (2) loop
         
         if
           GezogeneZahl in Wassergrundwahrscheinlichkeiten (TemperaturExtern, ZusatzgrundSchleifenwert).Anfangswahrscheinlichkeit
           .. Wassergrundwahrscheinlichkeiten (TemperaturExtern, ZusatzgrundSchleifenwert).Endwahrscheinlichkeit
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

end KartengeneratorWasserweltLogik;
