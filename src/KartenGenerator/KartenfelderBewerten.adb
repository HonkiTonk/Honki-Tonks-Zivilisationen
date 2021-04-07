pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, FelderwerteFestlegen;

package body KartenfelderBewerten is

   procedure KartenfelderBewerten
   is

      task Himmel;
      task Weltraum;
      task UnterwasserUnterirdisch;
      task PlanetenInneres;
      
      task body Himmel
      is begin

         YAchseHimmelSchleife:
         for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseHimmelSchleife:
            for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert));
               
            end loop XAchseHimmelSchleife;
         end loop YAchseHimmelSchleife;
         
      end Himmel;



      task body Weltraum
      is begin
         
         YAchseWeltraumSchleife:
         for YAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseWeltraumSchleife:
            for XAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (2, YAchseWeltraumSchleifenwert, XAchseWeltraumSchleifenwert));
               
            end loop XAchseWeltraumSchleife;
         end loop YAchseWeltraumSchleife;
         
      end Weltraum;
      
      
      
      task body UnterwasserUnterirdisch
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneres;


      
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                       KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;   

end KartenfelderBewerten;
