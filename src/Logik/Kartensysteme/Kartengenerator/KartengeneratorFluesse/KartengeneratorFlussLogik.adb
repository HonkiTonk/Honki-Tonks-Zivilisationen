with KartengrundDatentypen;
with LadezeitenDatentypen;

with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with FlussplatzierungssystemLogik;
with LadezeitenLogik;

package body KartengeneratorFlussLogik is

   procedure GenerierungFlüsse
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type SystemDatentypenHTSEB.NullBisHundert;
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      if
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = KartenKonstanten.KernKonstante
        and
          KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde = KartenKonstanten.UnterflächeKonstante
      then
         LadezeitBasis := 100.00 / Float (2 * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
         
      elsif
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = KartenKonstanten.UnterflächeKonstante
        and
          KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde = KartenKonstanten.UnterflächeKonstante
      then
         LadezeitBasis := 100.00 / Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
         
      elsif
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = KartenKonstanten.UnterflächeKonstante
        and
          KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde >= KartenKonstanten.OberflächeKonstante
      then
         LadezeitBasis := 100.00 / Float (2 * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
         
      elsif
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = KartenKonstanten.OberflächeKonstante
        and
          KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde >= KartenKonstanten.OberflächeKonstante
      then
         LadezeitBasis := 100.00 / Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
         
      else
         LadezeitBasis := 100.00 / Float (3 * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
      end if;
      
      if
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde > KartenKonstanten.OberflächeKonstante
      then
         EbeneEnde := KartenKonstanten.OberflächeKonstante;
           
      else
         EbeneEnde := KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde;
      end if;
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang .. EbeneEnde loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
               is
                  when KartengrundDatentypen.Basisgrund_Oberfläche_Eiswasser_Enum'Range | KartengrundDatentypen.Basisgrund_Unterfläche_Eiswasser_Enum'Range
                     | KartengrundDatentypen.Basisgrund_Kernfläche_Flüssig_Enum'Range =>
                     null;
                  
                  when others =>
                     if
                       ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte <= WahrscheinlichkeitFluss (EbeneSchleifenwert)
                     then
                        FlussplatzierungssystemLogik.Flussplatzierung (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                     
                     else
                        null;
                     end if;
               end case;
         
            end loop WaagerechteSchleife;
         
            LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum,
                                                      ZeitExtern            => LadezeitBasis);
         
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
   end GenerierungFlüsse;

end KartengeneratorFlussLogik;
