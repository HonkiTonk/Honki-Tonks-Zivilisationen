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
         
         RessourcenGenerierung (EbeneExtern => KartenKonstanten.UnterflächeKonstante);
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         RessourcenGenerierung (EbeneExtern => KartenKonstanten.PlaneteninneresKonstante);
         
      end RessourcenKern;
   
   begin

      RessourcenGenerierung (EbeneExtern => KartenKonstanten.OberflächeKonstante);
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet)
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      Kartenzeitwert (EbeneExtern) := Basiszeitwert (ZusatzwertExtern => KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte,
                                                     TeilerExtern     => 33);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
            -- Ist aktuell nur vorhanden, da noch keine Ressourcen für den Kern vorhanden sind aber Werte für die Ladezeiten benötigt werden.
            case
              EbeneExtern
            is
               when KartenKonstanten.PlaneteninneresKonstante =>
                  exit WaagerechteSchleife;
                  
               when others =>
                  null;
            end case;
            
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
            
         case
           SenkrechteSchleifenwert mod Kartenzeitwert (EbeneExtern)
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
               
            when others =>
               null;
         end case;
         
      end loop SenkrechteSchleife;
      
   end RessourcenGenerierung;

end KartengeneratorRessourcenLogik;
