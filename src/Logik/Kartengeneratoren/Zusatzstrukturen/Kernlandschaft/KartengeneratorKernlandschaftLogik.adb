with ZufallsgeneratorenHTSEB;

with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with LadezeitenLogik;
with KartengeneratorVariablenLogik;
with Basisgrundplatzierungssystem;

package body KartengeneratorKernlandschaftLogik is

   procedure Landschaft
     (LadezeitbasisExtern : in Float)
   is begin
      
      Schleifenbereiche := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereiche.MinimaleSenkrechte .. Schleifenbereiche.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereiche.MinimaleWaagerechte .. Schleifenbereiche.MaximaleWaagerechte loop
            
            AktuellerGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                                                        
            case
              AktuellerGrund
            is
               -- Diese Standardgründe mal als Konstante auslagern. äöü
               when KartenbasisgrundDatentypen.Ringwoodit_Enum =>
                  BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.KernKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Zusatzstrukturen_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Landschaft;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in Grundwahrscheinlichkeiten'Range loop
         
         if
           GezogeneZahl in Grundwahrscheinlichkeiten (BasisgrundSchleifenwert).Anfangswahrscheinlichkeit .. Grundwahrscheinlichkeiten (BasisgrundSchleifenwert).Endwahrscheinlichkeit
         then
            WelcherGrund := BasisgrundSchleifenwert;
            exit BasisgrundSchleife;
            
         else
            null;
         end if;
         
      end loop BasisgrundSchleife;
      
      Basisgrundplatzierungssystem.Basisgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                          BasisgrundExtern  => Basisgrundumwandlung (WelcherGrund));
      
   end BasisgrundBestimmen;

end KartengeneratorKernlandschaftLogik;
