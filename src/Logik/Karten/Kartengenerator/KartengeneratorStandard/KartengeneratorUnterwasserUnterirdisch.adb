pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with LadezeitenDatentypen;

with LeseKarten;
with SchreibeKarten;

with KartengeneratorVariablen;
with KartengeneratorErdwelt;
with KartengeneratorWasserwelt;
with Fehler;
with LadezeitenLogik;

package body KartengeneratorUnterwasserUnterirdisch is

   procedure GenerierungLandschaft
   is begin
      
      Kartenzeitwert := (KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse + (100 - 1)) / 100;
               
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Küstengewässer_Enum =>
                  SchreibeKarten.GleicherGrund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert),
                                                GrundExtern       => KartengrundDatentypen.Küstengrund_Enum);
                  
               when KartengrundDatentypen.Wasser_Enum =>
                  KartengeneratorWasserwelt.KartengeneratorWasserwelt (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range =>
                  KartengeneratorErdwelt.KartengeneratorErdwelt (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "KartengeneratorUnterwasserUnterirdisch.GenerierungLandschaft - Weder Wasser noch Erde.");
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

end KartengeneratorUnterwasserUnterirdisch;
