with ZufallsgeneratorenHTSEB;

with Basisgrundplatzierungssystem;
with KartengeneratorArktisberechnungenLogik;
with KartengeneratorTundraberechnungenLogik;
with KartengeneratorGraslandberechnungenLogik;
with KartengeneratorSteppenberechnungenLogik;
with KartengeneratorSavannenberechnungenLogik;
with KartengeneratorWuestenberechnungenLogik;

package body KartengeneratorBasislandschaftLogik is

   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
   is begin
      
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in Grundwahrscheinlichkeiten'Range (2) loop
         
         if
           GezogeneZahl in Grundwahrscheinlichkeiten (TemperaturExtern, BasisgrundSchleifenwert).Anfangswahrscheinlichkeit .. Grundwahrscheinlichkeiten (TemperaturExtern, BasisgrundSchleifenwert).Endwahrscheinlichkeit
         then
            WelcherGrund := BasisgrundSchleifenwert;
            exit BasisgrundSchleife;
            
         else
            null;
         end if;
         
      end loop BasisgrundSchleife;
         
      Basisgrund := Zusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => Basisgrundumwandlung (WelcherGrund));
      
      Basisgrundplatzierungssystem.Basisgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                          BasisgrundExtern  => Basisgrund);
      
   end BasisgrundBestimmen;
   
   
   
   function Zusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartenbasisgrundDatentypen.Basisgrund_Arktis_Enum'Range =>
            return KartengeneratorArktisberechnungenLogik.Arktis (KoordinatenExtern => KoordinatenExtern,
                                                                  GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range =>
            return KartengeneratorTundraberechnungenLogik.Tundra (KoordinatenExtern => KoordinatenExtern,
                                                                  GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Grasland_Enum'Range =>
            return KartengeneratorGraslandberechnungenLogik.Grasland (KoordinatenExtern => KoordinatenExtern,
                                                                      GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Steppe_Enum'Range =>
            return KartengeneratorSteppenberechnungenLogik.Steppe (KoordinatenExtern => KoordinatenExtern,
                                                                   GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Savanne_Enum'Range =>
            return KartengeneratorSavannenberechnungenLogik.Savanne (KoordinatenExtern => KoordinatenExtern,
                                                                     GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range =>
            return KartengeneratorWuestenberechnungenLogik.Wüste (KoordinatenExtern => KoordinatenExtern,
                                                                   GrundExtern       => GrundExtern);
                        
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            return GrundExtern;
      end case;
   
   end Zusatzberechnungen;

end KartengeneratorBasislandschaftLogik;
