with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorLandressourcenLogik;
with KartengeneratorWasserressourcenLogik;
with KartengeneratorUnterlandressourcenLogik;
with KartengeneratorUnterwasserressourcenLogik;
with LadezeitenLogik;

package body KartengeneratorRessourcenLogik is

   procedure GenerierungRessourcen
   is
   
      -- Später noch Ressourcen für weitere Ebenen einbauen. äöü
      task RessourcenUnterfläche;
      task RessourcenKern;
      
      task body RessourcenUnterfläche
      is begin
         
         RessourcenGenerierung (EbeneExtern         => KartenKonstanten.UnterflächeKonstante,
                                LadezeitbasisExtern => 100.00 / (3.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         RessourcenGenerierung (EbeneExtern         => KartenKonstanten.PlaneteninneresKonstante,
                                LadezeitbasisExtern => 100.00 / (3.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
         
      end RessourcenKern;
   
   begin

      RessourcenGenerierung (EbeneExtern         => KartenKonstanten.OberflächeKonstante,
                             LadezeitbasisExtern => 100.00 / (3.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
      
   end GenerierungRessourcen;
   
   
   
   -- Warum generiere ich keine Ressourcen an den Polen? Mal anpassen. äöü
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet;
      LadezeitbasisExtern : in Float)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorWasserressourcenLogik.KartengeneratorWasserressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorLandressourcenLogik.KartengeneratorLandressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorUnterwasserressourcenLogik.KartengeneratorUnterwasserressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
                  KartengeneratorUnterlandressourcenLogik.KartengeneratorUnterlandressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end RessourcenGenerierung;

end KartengeneratorRessourcenLogik;
