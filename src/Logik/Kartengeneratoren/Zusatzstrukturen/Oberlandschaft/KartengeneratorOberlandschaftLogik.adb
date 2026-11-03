with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with LadezeitenLogik;
with KartengeneratorZusatzlandschaftLogik;
with KartengeneratorBasislandschaftLogik;

package body KartengeneratorOberlandschaftLogik is

   procedure Landschaft
     (LadezeitbasisExtern : in Float)
   is begin
      
      Temperatur := KartengeneratorVariablenLogik.KartentemperaturLesen;
      
      Schleifenbereiche := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereiche.MinimaleSenkrechte .. Schleifenbereiche.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereiche.MinimaleWaagerechte .. Schleifenbereiche.MaximaleWaagerechte loop
            
            AktuellerGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                                                        
            case
              AktuellerGrund
            is
               when KartenbasisgrundDatentypen.Grasland_Enum =>
                  KartengeneratorBasislandschaftLogik.BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                           TemperaturExtern   => Temperatur);

               when others =>
                  null;
            end case;
            
            case
              AktuellerGrund
            is
               when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorZusatzlandschaftLogik.ZusatzgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Zusatzstrukturen_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Landschaft;

end KartengeneratorOberlandschaftLogik;
