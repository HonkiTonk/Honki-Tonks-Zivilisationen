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
   
      -- Später noch Ressourcen für weitere Ebenen einbauen? äöü
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
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Kartenzeitwert (EbeneExtern) := (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse + (33 - 1)) / 33;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse loop
            
            -- Ist aktuell nur vorhanden, da noch keine Ressourcen für den Kern vorhanden sind aber Werte für die Ladezeiten benötigt werden.
            case
              EbeneExtern
            is
               when KartenKonstanten.PlaneteninneresKonstante =>
                  exit XAchseSchleife;
                  
               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorWasserressourcenLogik.KartengeneratorWasserressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorLandressourcenLogik.KartengeneratorLandressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorUnterwasserressourcenLogik.KartengeneratorUnterwasserressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
                  KartengeneratorUnterlandressourcenLogik.KartengeneratorUnterlandressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert (EbeneExtern)
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;

end KartengeneratorRessourcenLogik;
