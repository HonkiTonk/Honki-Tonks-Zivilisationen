with MeldungssystemHTSEB;

with KartenbasisgrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorOberrohstoffeLogik;
with KartengeneratorUnterlandrohstoffeLogik;
with KartengeneratorUnterwasserrohstoffeLogik;
with KartengeneratorKernrohstoffeLogik;
with LadezeitenLogik;
with LadezeitenAllgemeinesLogik;

package body KartengeneratorRohstoffeLogik is
   
   procedure Rohstoffe
   is begin
      
      GenerierungRohstoffe;
      
   end Rohstoffe;

   
   
   -- Alles ab hier auf protected setzen? äöü
   procedure GenerierungRohstoffe
   is
      use type KartenDatentypen.EbeneVorhanden;
      
      task RohstoffeUnterfläche;
      task RohstoffeKern;
      
      task body RohstoffeUnterfläche
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= -1
         then
            RohstoffeGenerierung (EbeneExtern             => KartenKonstanten.UnterflächeKonstante,
                                  LadezeitbasisExtern     => LadezeitenAllgemeinesLogik.ZeiteinheitPlanetBerechnen);
            
         else
            null;
         end if;
         
      end RohstoffeUnterfläche;
      
      
      
      task body RohstoffeKern
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang = -2
         then
            RohstoffeGenerierung (EbeneExtern             => KartenKonstanten.KernKonstante,
                                  LadezeitbasisExtern     => LadezeitenAllgemeinesLogik.ZeiteinheitPlanetBerechnen);
            
         else
            null;
         end if;
         
      end RohstoffeKern;
   
   begin

      if
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= 0
      then
         KartengeneratorOberrohstoffeLogik.Landrohstoffe (LadezeitbasisExtern => LadezeitenAllgemeinesLogik.ZeiteinheitPlanetBerechnen);
         
      else
         null;
      end if;
      
   end GenerierungRohstoffe;
   
   
   
   -- Später die Generatoren einstellbar machen dass eine Ressource nur einmal oder mehrmals pro Feld erlaubt ist? äöü
   procedure RohstoffeGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet;
      LadezeitbasisExtern : in SystemDatentypenHTSEB.LadezeitBasis)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. KartengeneratorVariablenLogik.KartengrößeLesen.Waagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is 
               when KartenbasisgrundDatentypen.Basisgrund_Gesamtunterfläche_Land_Enum'Range =>
                  KartengeneratorUnterlandrohstoffeLogik.Unterlandrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorUnterwasserrohstoffeLogik.Unterwasserrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Enum'Range =>
                  KartengeneratorKernrohstoffeLogik.Kernrohstoffe (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorRohstoffeLogik.RohstoffeGenerierung: Falscher Basisgrund: "
                                             & LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneExtern, SenkrechteSchleifenwert, WaagerechteSchleifenwert))'Wide_Wide_Image);
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Rohstoffe_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end RohstoffeGenerierung;

end KartengeneratorRohstoffeLogik;
