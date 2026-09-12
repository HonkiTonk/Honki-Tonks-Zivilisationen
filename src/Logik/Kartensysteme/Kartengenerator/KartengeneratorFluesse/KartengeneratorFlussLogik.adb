with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;

with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with FlussplatzierungssystemLogik;
with LadezeitenLogik;
with KartentestsLogik;

-- Das hier auch mal noch Parallelisieren. äöü
package body KartengeneratorFlussLogik is

   procedure GenerierungFlüsse
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type SystemDatentypenHTSEB.NullBisHundert;
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      LadezeitBasis := 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                       * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte);
      
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
                  when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Eiswasser_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Eiswasser_Enum'Range
                     | KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Flüssig_Enum'Range =>
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
