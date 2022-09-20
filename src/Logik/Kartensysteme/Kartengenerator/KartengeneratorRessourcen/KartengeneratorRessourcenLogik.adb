pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;

with LeseWeltkarte;

with KartengeneratorVariablen;
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
         
         RessourcenGenerierung (EbeneExtern => -1);
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         RessourcenGenerierung (EbeneExtern => -2);
         
      end RessourcenKern;
   
   begin

      RessourcenGenerierung (EbeneExtern => 0);
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet)
   is begin
      
      Kartenzeitwert (EbeneExtern) := (KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse + (33 - 1)) / 33;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            -- Ist aktuell nur vorhanden, da noch keine Ressourcen für den Kern vorhanden sind aber Werte für die Ladezeiten benötigt werden.
            case
              EbeneExtern
            is
               when -2 =>
                  exit XAchseSchleife;
                  
               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorWasserressourcenLogik.KartengeneratorWasserressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorLandressourcenLogik.KartengeneratorLandressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorUnterwasserressourcenLogik.KartengeneratorUnterwasserressourcen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
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