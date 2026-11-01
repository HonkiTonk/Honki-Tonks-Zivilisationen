with MeldungssystemHTSEB;
with ZufallsgeneratorenHTSEB;

with LadezeitenDatentypen;
with KartenKonstanten;
with KartenbasisgrundDatentypen;
with KartenDatentypen;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorErdweltLogik;
with KartengeneratorWasserweltLogik;
with LadezeitenLogik;

package body KartengeneratorUnterlandschaftLogik is

   procedure Landschaft
     (LadezeitbasisExtern : in Float)
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      Schleifenbereiche := KartengeneratorVariablenLogik.PolfreierBereichLesen;
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereiche.MinimaleSenkrechte .. Schleifenbereiche.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereiche.MinimaleWaagerechte .. Schleifenbereiche.MaximaleWaagerechte loop
            
            if
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang > KartenKonstanten.UnterflächeKonstante
            then
               exit SenkrechteSchleife;
            
            elsif
              KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde < KartenKonstanten.OberflächeKonstante
            then
               case
                 ZufallsgeneratorenHTSEB.Münzwurf
               is
                  when True =>
                     KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                     
                  when False =>
                     KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
               end case;
               
            else
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
               is
                  when KartenbasisgrundDatentypen.Küstengewässer_Enum | KartenbasisgrundDatentypen.Meer_Enum =>
                     KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
                  when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                     KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
                  when others =>
                     MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorUnterlandschaftLogik.Landschaft: Weder Wasser noch Erde");
               end case;
            end if;
                              
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Zusatzstrukturen_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Landschaft;

end KartengeneratorUnterlandschaftLogik;
