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

package body KartengeneratorUnterflaecheLogik is

   procedure GenerierungLandschaft
   is
      use type KartenDatentypen.EbeneBasis;
   begin
      
      LadezeitBasis := 100.00 / Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde < KartenKonstanten.OberflächeKonstante
            then
               case
                 ZufallsgeneratorenHTSEB.Münzwurf
               is
                  when True =>
                     null;
                     -- KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                     
                  when False =>
                     null;
                     -- KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
               end case;
               
            else
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
               is
                  when KartenbasisgrundDatentypen.Küstengewässer_Enum | KartenbasisgrundDatentypen.Wasser_Enum =>
                     KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
                  when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                     KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
                  when others =>
                     MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorUnterflaecheLogik.GenerierungLandschaft: Weder Wasser noch Erde");
               end case;
            end if;
                              
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum,
                                                   ZeitExtern            => LadezeitBasis);
         
      end loop SenkrechteSchleife;
      
   end GenerierungLandschaft;

end KartengeneratorUnterflaecheLogik;
