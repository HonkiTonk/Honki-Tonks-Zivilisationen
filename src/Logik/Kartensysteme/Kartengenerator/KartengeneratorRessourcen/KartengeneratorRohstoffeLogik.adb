with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorLandrohstoffeLogik;
with KartengeneratorWasserrohstoffeLogik;
with KartengeneratorUnterlandrohstoffeLogik;
with KartengeneratorUnterwasserrohstoffeLogik;
with LadezeitenLogik;
with KartentestsLogik;

package body KartengeneratorRohstoffeLogik is

   procedure GenerierungRohstoffe
   is
      use type KartenDatentypen.EbeneVorhanden;
      use type KartenDatentypen.SenkrechtePositiv;
      
      task RohstoffeUnterfläche;
      task RohstoffeKern;
      
      task body RohstoffeUnterfläche
      is begin
         
         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang <= -1
         then
            RohstoffeGenerierung (EbeneExtern         => KartenKonstanten.UnterflächeKonstante,
                                   LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                     * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end RohstoffeUnterfläche;
      
      
      
      task body RohstoffeKern
      is begin
         
         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = -2
         then
            RohstoffeGenerierung (EbeneExtern         => KartenKonstanten.KernKonstante,
                                   LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                     * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end RohstoffeKern;
   
   begin

      if
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde >= 0
      then
         RohstoffeGenerierung (EbeneExtern         => KartenKonstanten.OberflächeKonstante,
                                LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                  * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
         
      else
         null;
      end if;
      
   end GenerierungRohstoffe;
   
   
   
   -- Warum generiere ich keine Rohstoffe an den Polen? Mal anpassen. äöü
   procedure RohstoffeGenerierung
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
                  KartengeneratorWasserrohstoffeLogik.KartengeneratorWasserrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorLandrohstoffeLogik.KartengeneratorLandrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorUnterwasserrohstoffeLogik.KartengeneratorUnterwasserrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
                  KartengeneratorUnterlandrohstoffeLogik.KartengeneratorUnterlandrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Rohstoffe_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end RohstoffeGenerierung;

end KartengeneratorRohstoffeLogik;
