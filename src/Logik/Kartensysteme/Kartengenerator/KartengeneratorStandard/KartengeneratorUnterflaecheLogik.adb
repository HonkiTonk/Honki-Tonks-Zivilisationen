with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorErdweltLogik;
with KartengeneratorWasserweltLogik;
with MeldungssystemHTSEB;
with LadezeitenLogik;

package body KartengeneratorUnterflaecheLogik is

   procedure GenerierungLandschaft
   is begin
      
      LadezeitBasis := 100.00 / Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartengrundDatentypen.Küstengewässer_Enum | KartengrundDatentypen.Wasser_Enum =>
                  KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorUnterflaecheLogik.GenerierungLandschaft: Weder Wasser noch Erde");
            end case;
                              
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum,
                                                   ZeitExtern            => LadezeitBasis);
         
      end loop SenkrechteSchleife;
      
   end GenerierungLandschaft;

end KartengeneratorUnterflaecheLogik;
