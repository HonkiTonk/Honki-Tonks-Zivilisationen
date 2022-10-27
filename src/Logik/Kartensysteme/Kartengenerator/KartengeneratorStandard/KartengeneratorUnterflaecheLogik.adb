pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;
with SchreibeWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorErdweltLogik;
with KartengeneratorWasserweltLogik;
with Fehler;
with LadezeitenLogik;

package body KartengeneratorUnterflaecheLogik is

   procedure GenerierungLandschaft
   is begin
      
      Kartenzeitwert := (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse + (100 - 1)) / 100;
               
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Küstengewässer_Enum =>
                  SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert),
                                                GrundExtern       => KartengrundDatentypen.Küstengrund_Enum);
                  
               when KartengrundDatentypen.Wasser_Enum =>
                  KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "KartengeneratorUnterflaecheLogik.GenerierungLandschaft: Weder Wasser noch Erde.");
            end case;
                              
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end GenerierungLandschaft;

end KartengeneratorUnterflaecheLogik;
