pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;

with LeseKarten;

with KartengeneratorVariablen;
with KartengeneratorRessourcenOberflaecheLand;
with KartengeneratorRessourcenOberflaecheWasser;
with KartengeneratorRessourcenUnterflaecheLand;
with KartengeneratorRessourcenUnterflaecheWasser;

package body KartengeneratorRessourcen is

   procedure GenerierungRessourcen
   is
   
      ----------------------- Später noch Ressourcen für weitere Ebenen einbauen.
      task RessourcenUnterfläche;
      task RessourcenKern;
      
      task body RessourcenUnterfläche
      is begin
         
         RessourcenGenerierung (EbeneExtern => -1);
         
      end RessourcenUnterfläche;
      
      
      
      task body RessourcenKern
      is begin
         
         -- RessourcenGenerierung (EbeneExtern => -2);
         null;
         
      end RessourcenKern;
   
   begin

      RessourcenGenerierung (EbeneExtern => 0);
      
   end GenerierungRessourcen;
   
   
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
               
            case
              LeseKarten.AktuellerGrund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorRessourcenOberflaecheWasser.KartengeneratorRessourcenOberflächeWasser (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorRessourcenOberflaecheLand.KartengeneratorRessourcenOberflächeLand (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
                  KartengeneratorRessourcenUnterflaecheWasser.KartengeneratorRessourcenUnterflächeWasser (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
                  KartengeneratorRessourcenUnterflaecheLand.KartengeneratorRessourcenUnterflächeLand (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end RessourcenGenerierung;

end KartengeneratorRessourcen;
