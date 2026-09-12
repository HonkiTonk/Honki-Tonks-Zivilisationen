with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorLandressourcenLogik;
with KartengeneratorWasserressourcenLogik;
with KartengeneratorUnterlandressourcenLogik;
with KartengeneratorUnterwasserressourcenLogik;
with LadezeitenLogik;
with KartentestsLogik;

-- Später noch Ressourcen für weitere Ebenen einbauen. äöü
package body KartengeneratorRessourcenLogik is

   procedure GenerierungRessourcen
   is
      use type KartenDatentypen.EbeneVorhanden;
      use type KartenDatentypen.SenkrechtePositiv;
      
      task RessourcenUnterfläche;
      task RessourcenKern;
      
      task body RessourcenUnterfläche
      is begin
         
         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang <= -1
         then
            RessourcenGenerierung (EbeneExtern         => KartenKonstanten.UnterflächeKonstante,
                                   LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                     * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = -2
         then
            RessourcenGenerierung (EbeneExtern         => KartenKonstanten.KernKonstante,
                                   LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                     * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end RessourcenKern;
   
   begin

      if
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde >= 0
      then
         RessourcenGenerierung (EbeneExtern         => KartenKonstanten.OberflächeKonstante,
                                LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                  * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
         
      else
         null;
      end if;
      
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
               when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorWasserressourcenLogik.KartengeneratorWasserressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorLandressourcenLogik.KartengeneratorLandressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorUnterwasserressourcenLogik.KartengeneratorUnterwasserressourcen (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
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
